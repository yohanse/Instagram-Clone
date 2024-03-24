from django.shortcuts import render
from . import models
from .import seriliazer
from rest_framework.viewsets import GenericViewSet, ModelViewSet
from rest_framework.mixins import CreateModelMixin, ListModelMixin, UpdateModelMixin, RetrieveModelMixin, DestroyModelMixin
class ProfileView(GenericViewSet, CreateModelMixin, RetrieveModelMixin):
    queryset = models.UserProfile.objects.all()
    serializer_class = seriliazer.UserProfileSerializer

class PostView(ModelViewSet):
    queryset = models.Post.objects.all()
    serializer_class = seriliazer.PostSerializer
