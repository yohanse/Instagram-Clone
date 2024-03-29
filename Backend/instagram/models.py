from django.conf import settings
from django.db import models
from django.contrib.contenttypes.fields import GenericForeignKey
from django.contrib.contenttypes.models import ContentType


class UserProfile(models.Model):
    profile_image = models.ImageField(upload_to="profile/images", default="profile/images/profile.webp")
    bio = models.CharField(max_length=200)
    user = models.OneToOneField(settings.AUTH_USER_MODEL, on_delete=models.CASCADE,primary_key=True)

class Image(models.Model):
    image = models.ImageField(upload_to="post/images")

class Video(models.Model):
    video = models.FileField(upload_to="post/videos")

class Post(models.Model):
    author = models.ForeignKey(UserProfile, on_delete=models.CASCADE)
    text = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    images = models.ManyToManyField(Image, related_name='posts')
    videos = models.ManyToManyField(Video, related_name='posts')

    class Meta:
        ordering = ['-created_at']


class Like(models.Model):
    user = models.ForeignKey(UserProfile, on_delete=models.CASCADE, related_name="likes")
    post = models.ForeignKey(Post, on_delete=models.CASCADE, related_name="likes")
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        unique_together = (('user', 'post'),)  


class Comment(models.Model):
    user = models.ForeignKey(UserProfile, on_delete=models.CASCADE, related_name="comments")
    post = models.ForeignKey(Post, on_delete=models.CASCADE, related_name="comments")
    content = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ['created_at']