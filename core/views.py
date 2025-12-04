from rest_framework import viewsets, status
from rest_framework.response import Response
from rest_framework.decorators import action
from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework.authtoken.views import ObtainAuthToken
from rest_framework.authtoken.models import Token
from django.contrib.auth.models import update_last_login
from django.db.models import Q 
from django.utils import timezone 
from django.utils.dateparse import parse_date
from datetime import datetime, time
from django.http import HttpResponse 
from .models import Usuario, Evento, Reserva
from .serializers import UsuarioSerializer, EventoSerializer, ReservaSerializer
import uuid 
import csv 

# API de Eventos
class EventoViewSet(viewsets.ModelViewSet):
    serializer_class = EventoSerializer
    queryset = Evento.objects.all()
    
    # Filtros de busqueda y fecha (GET /api/eventos/?search=&fecha=)
    def get_queryset(self):
        queryset = Evento.objects.all().order_by('fecha_inicio')
        
        search_query = self.request.query_params.get('search', None)
        fecha_query = self.request.query_params.get('fecha', None)
        
        if search_query:
            queryset = queryset.filter(
                Q(nombre__icontains=search_query) | 
                Q(ubicacion__icontains=search_query)
            )
            
        # Filtro por Fecha
        if fecha_query:
            # texto 'yyyy-mm-dd' a objeto fecha
            fecha_obj = parse_date(fecha_query)
            
            if fecha_obj:
                # inicio (00:00) y fin (23:59) 
                # make_aware zona horaria de Chile (settings.py)
                start_of_day = timezone.make_aware(datetime.combine(fecha_obj, time.min))
                end_of_day = timezone.make_aware(datetime.combine(fecha_obj, time.max))
                
                # evento que empiece DENTRO del rango
                queryset = queryset.filter(fecha_inicio__range=(start_of_day, end_of_day))
            
        return queryset
    
    # Permisos: Lectura publica / Escritura requiere login
    def get_permissions(self):
        if self.action == 'list' or self.action == 'retrieve':
            return [AllowAny()]
        return [IsAuthenticated()]

# API de Reservas
class ReservaViewSet(viewsets.ModelViewSet):
    serializer_class = ReservaSerializer
    queryset = Reserva.objects.all()

    # Filtros de privacidad y busqueda administrativa
    def get_queryset(self):
        user = self.request.user
        
        if not user.is_authenticated:
            return Reserva.objects.none()

        if user.is_staff:
            queryset = Reserva.objects.all().order_by('-fecha_reserva')
        else:
            queryset = Reserva.objects.filter(usuario=user).order_by('-fecha_reserva')

        # Filtros adicionales para el Admin
        if user.is_staff:
            search_query = self.request.query_params.get('search', None)
            fecha_inicio = self.request.query_params.get('fecha_inicio', None)
            fecha_fin = self.request.query_params.get('fecha_fin', None)

            if search_query:
                queryset = queryset.filter(
                    Q(codigo_reserva__icontains=search_query) |
                    Q(evento__nombre__icontains=search_query) |
                    Q(email_contacto__icontains=search_query) |
                    Q(usuario__email__icontains=search_query)
                )

            if fecha_inicio and fecha_fin:
                queryset = queryset.filter(fecha_reserva__range=[fecha_inicio, fecha_fin])

        return queryset

    # Permisos: Creación publica / lo demas requiere login
    def get_permissions(self):
        if self.action == 'create': 
            return [AllowAny()]
        return [IsAuthenticated()]

    # Cancelar reserva (PATCH /api/reservas/{id}/cancelar/)
    @action(detail=True, methods=['patch'])
    def cancelar(self, request, pk=None):
        try:
            reserva = Reserva.objects.get(pk=pk)
        except Reserva.DoesNotExist:
            return Response({"error": "Reserva no encontrada."}, status=status.HTTP_404_NOT_FOUND)

        if reserva.usuario and reserva.usuario != request.user and not request.user.is_staff:
            return Response({"error": "No tienes permiso para cancelar esta reserva."}, status=status.HTTP_403_FORBIDDEN)
        
        if reserva.estado_reserva == 'cancelada':
            return Response({"mensaje": "La reserva ya está cancelada."}, status=status.HTTP_200_OK)

        reserva.estado_reserva = 'cancelada'
        reserva.save()
        return Response({"mensaje": "Reserva cancelada exitosamente. Cupo liberado."}, status=status.HTTP_200_OK)
    
    # Exportar reporte CSV (GET /api/reservas/reporte/)
    @action(detail=False, methods=['get'])
    def reporte(self, request):
        reservas = self.filter_queryset(self.get_queryset())

        response = HttpResponse(content_type='text/csv')
        response['Content-Disposition'] = 'attachment; filename="reporte_reservas.csv"'
        
        writer = csv.writer(response)
        writer.writerow(['ID', 'Codigo', 'Evento', 'Usuario/Contacto', 'Plazas', 'Fecha', 'Estado'])
        
        for r in reservas:
            usuario_info = r.usuario.email if r.usuario else f"{r.nombre_contacto} ({r.email_contacto})"
            
            writer.writerow([
                r.id,
                r.codigo_reserva,
                r.evento.nombre,
                usuario_info,
                r.cantidad_plazas,
                r.fecha_reserva.strftime("%Y-%m-%d %H:%M"),
                r.estado_reserva
            ])
            
        return response
    
    # Bloqueo de edicion directa
    def update(self, request, *args, **kwargs):
        return Response({"error": "No se permite editar. Cancele y cree nueva."}, status=status.HTTP_405_METHOD_NOT_ALLOWED)

    def partial_update(self, request, *args, **kwargs):
        return Response({"error": "No se permite editar."}, status=status.HTTP_405_METHOD_NOT_ALLOWED)

    # Crear reserva con validaciones (POST /api/reservas/)
    def create(self, request, *args, **kwargs):
        evento_id = request.data.get('evento') 
        
        try:
            cantidad = int(request.data.get('cantidad_plazas', 1))
            if cantidad <= 0:
                return Response({"error": "La cantidad debe ser mayor a 0."}, status=status.HTTP_400_BAD_REQUEST)
        except ValueError:
             return Response({"error": "Cantidad inválida."}, status=status.HTTP_400_BAD_REQUEST)

        try:
            evento_obj = Evento.objects.get(id=evento_id)
        except Evento.DoesNotExist:
            return Response({"error": "Evento no encontrado"}, status=status.HTTP_404_NOT_FOUND)

        if evento_obj.fecha_inicio < timezone.now():
             return Response({"error": "Evento pasado."}, status=status.HTTP_400_BAD_REQUEST)

        # Validacion de Integridad (Usuario - Invitado)
        mutable_data = request.data.copy()
        usuario_id = request.user.id if request.user.is_authenticated else None
        
        nombre_contacto = mutable_data.get('nombre_contacto')
        email_contacto = mutable_data.get('email_contacto')

        if not usuario_id and (not nombre_contacto or not email_contacto):
             return Response({"error": "Datos de contacto requeridos."}, status=status.HTTP_400_BAD_REQUEST)

        if usuario_id:
             mutable_data['usuario'] = usuario_id
        
        # Validacion de Aforo
        reservas_existentes = Reserva.objects.filter(evento=evento_obj, estado_reserva='confirmada')
        ocupacion_actual = sum(r.cantidad_plazas for r in reservas_existentes)
        
        if (ocupacion_actual + cantidad) > evento_obj.capacidad:
             return Response(
                {"error": f"Sin cupos. Quedan {evento_obj.capacidad - ocupacion_actual}."}, 
                status=status.HTTP_400_BAD_REQUEST
            )
        
        # UUID
        unique_code = "RES-" + str(uuid.uuid4()).split('-')[0].upper() 
        mutable_data['codigo_reserva'] = unique_code
        
        serializer = self.get_serializer(data=mutable_data)
        serializer.is_valid(raise_exception=True)
        self.perform_create(serializer) 
        
        # SIMULACION de notificacion
        destinatario = request.user.email if request.user.is_authenticated else email_contacto
        print(f"\n Enviando Email a: {destinatario} | Código: {unique_code}\n")
        
        headers = self.get_success_headers(serializer.data)
        return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)

# API de Usuarios
class UsuarioViewSet(viewsets.ModelViewSet):
    queryset = Usuario.objects.all()
    serializer_class = UsuarioSerializer
    
    # Permisos: Registro publico
    def get_permissions(self):
        if self.action == 'create':
            return [AllowAny()]
        return [IsAuthenticated()]

    # Filtro de privacidad: Usuario solo ve su perfil
    def get_queryset(self):
        user = self.request.user
        if not user.is_authenticated:
            return Usuario.objects.none()
        if user.is_staff:
            return Usuario.objects.all()
        return Usuario.objects.filter(id=user.id)
    
# API Actualiza last_login
class CustomLoginView(ObtainAuthToken):
    def post(self, request, *args, **kwargs):
        # Validamos usuario y contraseña (Django)
        serializer = self.serializer_class(data=request.data, context={'request': request})
        serializer.is_valid(raise_exception=True)
        user = serializer.validated_data['user']
        
        update_last_login(None, user)
        
        # Genera/obtiene el token
        token, created = Token.objects.get_or_create(user=user)
        
        # Token (datos al loguear)
        return Response({
            'token': token.key,
            'user_id': user.pk,
            'email': user.email,
            'rol': user.rol
        })