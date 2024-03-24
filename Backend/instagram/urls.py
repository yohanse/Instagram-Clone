from . import views
from rest_framework.routers import DefaultRouter

router = DefaultRouter()

router.register('post', views.PostView, basename='post')



urlpatterns = router.urls