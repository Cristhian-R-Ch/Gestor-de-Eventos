from rest_framework import serializers
from .models import Usuario, Evento, Reserva

# Serializer de Usuarios (registro y edición con encript.)
class UsuarioSerializer(serializers.ModelSerializer):
    class Meta:
        model = Usuario
        fields = ['id', 'email', 'nombre', 'apellido', 'rol', 'password']
        extra_kwargs = {'password': {'write_only': True}}

    # Crear usuario encriptando contraseña
    def create(self, validated_data):
        validated_data['username'] = validated_data['email']
        user = Usuario.objects.create_user(**validated_data)
        return user
    
    # Actualizar usuario (encripta si hay nueva clave)
    def update(self, instance, validated_data):
        password = validated_data.pop('password', None)
        
        # Si cambian el email, actualiza tambien el username
        if 'email' in validated_data:
            validated_data['username'] = validated_data['email']

        for attr, value in validated_data.items():
            setattr(instance, attr, value)

        if password:
            instance.set_password(password)
            
        instance.save()
        return instance

# Serializer de Eventos (calculo de cupos)
class EventoSerializer(serializers.ModelSerializer):
    cupos_disponibles = serializers.SerializerMethodField()

    class Meta:
        model = Evento
        fields = '__all__'

    # Campo calculado: (capacidad - reservas confirmadas)
    def get_cupos_disponibles(self, obj):
        reservas = obj.reserva_set.filter(estado_reserva='confirmada')
        ocupados = sum(r.cantidad_plazas for r in reservas)
        return obj.capacidad - ocupados

    # VALIDACION FECHAS 
    def validate(self, data):
        # fechas en la peticion
        inicio = data.get('fecha_inicio')
        fin = data.get('fecha_fin')

        # edit (PATCH), fecha en la instancia (self.instance)
        if self.instance:
            inicio = inicio or self.instance.fecha_inicio
            fin = fin or self.instance.fecha_fin

        # Fin no puede ser antes que Inicio
        if inicio and fin and fin < inicio:
            raise serializers.ValidationError({
                "fecha_fin": "La fecha de fin no puede ser anterior a la fecha de inicio"
            })

        return data
    
# Serializer de Reservas
class ReservaSerializer(serializers.ModelSerializer):
    class Meta:
        model = Reserva
        fields = '__all__'

    # Email del usuario en lugar del ID al leer
    def to_representation(self, instance):
        response = super().to_representation(instance)
        if instance.usuario:
            response['usuario'] = instance.usuario.email
        return response