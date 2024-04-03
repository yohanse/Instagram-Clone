from django.shortcuts import render
from rest_framework.response import Response

from instagram.permissions import CanDeletePost
from . import models
from .import seriliazer
from rest_framework.viewsets import GenericViewSet, ModelViewSet
from rest_framework.mixins import CreateModelMixin, ListModelMixin, UpdateModelMixin, RetrieveModelMixin, DestroyModelMixin
from rest_framework.permissions import IsAuthenticated


class ProfileView(GenericViewSet, CreateModelMixin, ListModelMixin):
    # permission_classes = [CanDeletePost]
    queryset = models.UserProfile.objects.all()
    serializer_class = seriliazer.UserProfileShortSerializer
    
    def list(self, request, *args, **kwargs):
        user = self.queryset.get(user_id=request.user.id)
        serializer = self.get_serializer(user)
        return Response(serializer.data)
    
    


class PostView(ModelViewSet):
    # permission_classes = [CanDeletePost]
    queryset = models.Post.objects.all()
    serializer_class = seriliazer.PostSerializer


class CommentView(ModelViewSet):
    queryset = models.Comment.objects.all()
    serializer_class = seriliazer.CommentSerializer
    
    def get_serializer_context(self):
        return {"post_id": self.kwargs["post_pk"],
                "user_id":self.request.user.id,
                }


class LikeView(ModelViewSet):
    queryset = models.Like.objects.all()
    serializer_class = seriliazer.LikeSerializer

    def get_serializer_context(self):
        return {"post_id": self.kwargs["post_pk"],
                "user_id":self.request.user.id,
                }