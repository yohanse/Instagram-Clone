from django.shortcuts import render
from rest_framework.response import Response
from django.contrib.contenttypes.models import ContentType
from instagram.permissions import CanDeletePost
from . import models
from .import seriliazer
from rest_framework.viewsets import GenericViewSet, ModelViewSet
from rest_framework.mixins import CreateModelMixin, ListModelMixin, UpdateModelMixin, RetrieveModelMixin, DestroyModelMixin
from rest_framework.permissions import IsAuthenticated
from django.db.models import Q, Max
from rest_framework import status
from django.db import connection
from rest_framework.decorators import action
from django.shortcuts import get_object_or_404

class ProfileView(GenericViewSet, CreateModelMixin, ListModelMixin, RetrieveModelMixin):
    queryset = models.User.objects.all()
    serializer_class = seriliazer.UserProfileShortSerializer
    
    @action(detail=False, methods=['get'])
    def me(self, request):
        user = request.user.id
        user_object = get_object_or_404(models.User, user_id=user)
        return Response(seriliazer.UserProfileShortSerializer(user_object).data)


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
    

class MessageView(GenericViewSet, ListModelMixin, CreateModelMixin):
    queryset = models.Message.objects.all()
    serializer_class = seriliazer.MessageSerializer
    
    def list(self, request):
        receiver_id = request.query_params.get('receiver_id')
        if receiver_id:
            messages = models.Message.objects.filter(Q(sender_id=self.request.user.id, receiver_id=receiver_id) | Q(sender_id=receiver_id, receiver_id=self.request.user.id))
            serializer = self.get_serializer(messages, many=True)
            return Response(serializer.data)
        else:
            return Response({"error": "receiver_id are required."}, status=status.HTTP_400_BAD_REQUEST)

class HistoryMessageUsers(GenericViewSet, ListModelMixin):
    serializer_class = seriliazer.UserProfileShortSerializer
    def get_queryset(self):

        with connection.cursor() as cursor:
            cursor.execute("""
                SELECT 
                    CASE 
                        WHEN receiver_id = %s THEN sender_id 
                        WHEN sender_id = %s THEN receiver_id 
                        ELSE NULL 
                    END AS user
                FROM instagram_message 
                GROUP BY user
                ORDER BY MAX(created_at) DESC
            """, [self.request.user.id, self.request.user.id])
            results = cursor.fetchall()

        user_ids = [result[0] for result in results if result[0] is not None]
        return models.User.objects.filter(pk__in=user_ids)