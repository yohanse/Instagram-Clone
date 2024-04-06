from django.shortcuts import render
from rest_framework.response import Response
from django.contrib.contenttypes.models import ContentType
from instagram.permissions import CanDeletePost
from . import models
from .import seriliazer
from rest_framework.viewsets import GenericViewSet, ModelViewSet
from rest_framework.mixins import CreateModelMixin, ListModelMixin, UpdateModelMixin, RetrieveModelMixin, DestroyModelMixin
from rest_framework.permissions import IsAuthenticated


class ProfileView(GenericViewSet, CreateModelMixin, ListModelMixin):
    # permission_classes = [CanDeletePost]
    queryset = models.User.objects.all()
    serializer_class = seriliazer.UserProfileSerializer
    
    def list(self, request, *args, **kwargs):
        user = self.queryset.get(user_id=request.user.id)
        serializer = self.get_serializer(user)
        return Response(serializer.data)
    
    


class PostView(ModelViewSet):
    # permission_classes = [CanDeletePost]
    queryset = models.Post.objects.all()
    serializer_class = seriliazer.PostSerializer


class ReelView(ModelViewSet):
    # permission_classes = [CanDeletePost]
    queryset = models.Reel.objects.all()
    serializer_class = seriliazer.ReelSerializer

class CommentView(ModelViewSet):
    serializer_class = seriliazer.CommentSerializer

    def get_queryset(self):
        return models.Comment.objects.filter(content_type=self.get_content_type(), object_id=self.get_pk())
    
    def get_serializer_context(self):
        return {
            "content_type": self.get_content_type(),
            "object_id": self.get_pk(),
            "user_id": self.request.user.id,
        }
    
    def get_content_type(self):
        if "post_pk" in self.kwargs:
            return ContentType.objects.get_for_model(models.Post)
        return ContentType.objects.get_for_model(models.Reel)
    
    def get_pk(self):
        return self.kwargs.get("post_pk") or self.kwargs.get("reel_pk")


class LikeView(ModelViewSet):
    serializer_class = seriliazer.LikeSerializer

    def get_queryset(self):
        return models.Like.objects.filter(content_type=self.get_content_type(), object_id=self.get_pk())
    
    def get_serializer_context(self):
        return {
            "content_type": self.get_content_type(),
            "object_id": self.get_pk(),
            "user_id": self.request.user.id,
        }
    
    def get_content_type(self):
        if "post_pk" in self.kwargs:
            return ContentType.objects.get_for_model(models.Post)
        return ContentType.objects.get_for_model(models.Reel)
    
    def get_pk(self):
        return self.kwargs.get("post_pk") or self.kwargs.get("reel_pk")