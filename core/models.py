from django.db import models
from django.contrib.auth.models import AbstractUser

# Modelo de Usuario
class Usuario(AbstractUser):
    """
    Extension del usuario nativo de Django, Usa el email como identificador principal (Login)
    """
    ROLES = [('admin', 'Administrador'), ('cliente', 'Cliente')]
    ESTADOS = [('activo', 'Activo'), ('inactivo', 'Inactivo')]
    
    email = models.EmailField(unique=True)
    nombre = models.CharField(max_length=150, blank=True) 
    apellido = models.CharField(max_length=150, blank=True)
    
    rol = models.CharField(max_length=20, choices=ROLES, default='cliente')
    estado = models.CharField(max_length=20, choices=ESTADOS, default='activo')

    # Configuracion para usar email en lugar de username
    USERNAME_FIELD = 'email' 
    REQUIRED_FIELDS = ['username', 'nombre', 'apellido']

    def __str__(self):
        return self.email

# Modelo de Eventos
class Evento(models.Model):
    ESTADOS = [('activo', 'Activo'), ('cancelado', 'Cancelado')]
    
    nombre = models.CharField(max_length=200)
    descripcion = models.TextField()
    fecha_inicio = models.DateTimeField()
    fecha_fin = models.DateTimeField()
    capacidad = models.IntegerField() # Aforo total
    ubicacion = models.CharField(max_length=200)
    estado = models.CharField(max_length=20, choices=ESTADOS, default='activo')

    def __str__(self):
        return self.nombre

# Modelo de Reservas
class Reserva(models.Model):
    ESTADOS = [('confirmada', 'Confirmada'), ('cancelada', 'Cancelada')]
    
    # Relacion
    usuario = models.ForeignKey(Usuario, on_delete=models.CASCADE, null=True, blank=True)
    evento = models.ForeignKey(Evento, on_delete=models.CASCADE)
    
    # Datos de la reserva
    cantidad_plazas = models.IntegerField(default=1)
    estado_reserva = models.CharField(max_length=20, choices=ESTADOS, default='confirmada')
    fecha_reserva = models.DateTimeField(auto_now_add=True)
    codigo_reserva = models.CharField(max_length=50, unique=True) # Generado por UUID en la vista
    
    # Datos para Invitados
    nombre_contacto = models.CharField(max_length=100, null=True, blank=True)
    email_contacto = models.EmailField(null=True, blank=True)
    rut_contacto = models.CharField(max_length=12, null=True, blank=True)

    def __str__(self):
        return f"Reserva {self.codigo_reserva}"