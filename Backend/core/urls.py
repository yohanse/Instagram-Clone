from . import views
from rest_framework.routers import DefaultRouter

router = DefaultRouter()

router.register('checkEmail', views.CheckEmail, basename='checkEmail')

urlpatterns = router.urls