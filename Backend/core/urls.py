from . import views
from rest_framework.routers import DefaultRouter

router = DefaultRouter()

router.register('checkEmail', views.CheckEmailView, basename='checkEmail')
router.register('checkCode', views.CheckConfirmationView, basename='checkCode')
router.register('checkUsername', views.CheckUsernameView, basename='checkUsername')



urlpatterns = router.urls