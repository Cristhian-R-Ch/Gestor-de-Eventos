from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from .models import Usuario, Evento, Reserva

# === ADMIN (Django) ===
class CustomUserAdmin(UserAdmin):
    list_display = ('email', 'nombre', 'apellido', 'rol', 'estado', 'is_staff')

    list_filter = ('rol', 'estado', 'is_staff')

    fieldsets = (
        (None, {'fields': ('email', 'password')}),
        ('Información Personal', {'fields': ('nombre', 'apellido', 'rol', 'estado')}),
        ('Permisos', {'fields': ('is_active', 'is_staff', 'is_superuser')}),
        ('Fechas', {'fields': ('last_login', 'date_joined')}),
    )

    ordering = ('email',)

# Reg.modelo clase personalizada
admin.site.register(Usuario, CustomUserAdmin)

# Reg.tablas normal
admin.site.register(Evento)
admin.site.register(Reserva)