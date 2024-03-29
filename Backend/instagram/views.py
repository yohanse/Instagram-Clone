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