from django.contrib import admin
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from core.views import EventoViewSet, ReservaViewSet, UsuarioViewSet, CustomLoginView
from rest_framework.authtoken.views import obtain_auth_token

router = DefaultRouter()
router.register(r'eventos', EventoViewSet)
router.register(r'reservas', ReservaViewSet)
router.register(r'usuarios', UsuarioViewSet)

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/', include(router.urls)),
    path('api/login/', CustomLoginView.as_view(), name='api_token_auth'),
]