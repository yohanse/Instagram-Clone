from rest_framework import serializers
from . import models


class UserProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.UserProfile
        fields = ('id', 'bio', 'user')



class ImageSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Image
        fields = ('id', 'image')



class VideoSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Video
        fields = ('id', 'video')

class LikeSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Like
        fields = ('id', 'user', 'post', 'created_at')


class CommentSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Comment
        fields = ('id', 'user', 'post', 'content', 'created_at')


class PostSerializer(serializers.ModelSerializer):
    author = UserProfileSerializer(read_only=True)  
    images = ImageSerializer(many=True, read_only=True)
    videos = VideoSerializer(many=True, read_only=True)

    class Meta:
        model = models.Post
        fields = ('id', 'author', 'text', 'created_at', 'images', 'videos')