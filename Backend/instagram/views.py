from django.shortcuts import render

from instagram.permissions import CanDeletePost
from . import models
from .import seriliazer
from rest_framework.viewsets import GenericViewSet, ModelViewSet
from rest_framework.mixins import CreateModelMixin, ListModelMixin, UpdateModelMixin, RetrieveModelMixin, DestroyModelMixin
from rest_framework.permissions import IsAuthenticated
class ProfileView(GenericViewSet, CreateModelMixin, RetrieveModelMixin):
    permission_classes = [CanDeletePost]
    queryset = models.UserProfile.objects.all()
    serializer_class = seriliazer.UserProfileSerializer

class PostView(ModelViewSet):
    permission_classes = [CanDeletePost]
    queryset = models.Post.objects.all()
    serializer_class = seriliazer.PostSerializer
