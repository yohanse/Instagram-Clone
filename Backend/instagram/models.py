from datetime import datetime
from django.conf import settings
from django.db import models
from django.contrib.contenttypes.fields import GenericForeignKey
from django.contrib.contenttypes.models import ContentType

class User(models.Model):
    profile_image = models.ImageField(upload_to="profile/images", default="profile/images/profile.webp")
    bio = models.CharField(max_length=200)
    user = models.OneToOneField(settings.AUTH_USER_MODEL, on_delete=models.CASCADE,primary_key=True)

class Image(models.Model):
    image = models.ImageField(upload_to='images/')

class Video(models.Model):
    video = models.FileField(upload_to='videos/')

class Post(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    text = models.TextField(blank=True)  # Optional text content for posts
    created_at = models.DateTimeField(auto_now_add=True)
    images = models.ManyToManyField(Image)  # Allow zero or more images

    class Meta:
        ordering = ['-created_at']  # Order posts by creation date (descending)

class Story(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    content = models.TextField()  # Content for stories
    created_at = models.DateTimeField(auto_now_add=True) # Optional expiration for stories
    images = models.ManyToManyField(Image)
    videos = models.ManyToManyField(Video)

    class Meta:
        ordering = ['-created_at']  # Order stories by creation date (descending)


class Reel(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    content = models.TextField(default="Reel Content")
    video = models.OneToOneField(Video, on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)


class Comment(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    content = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)

    # Content Type for Polymorphic Relationships
    content_type = models.ForeignKey(ContentType, on_delete=models.CASCADE, related_name="comments")
    object_id = models.PositiveIntegerField()
    content_object = GenericForeignKey('content_type','object_id')

    class Meta:
        ordering = ['-created_at']  # Order comments by creation date (descending)

class Like(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)

    # Content Type for Polymorphic Relationships
    content_type = models.ForeignKey(ContentType, on_delete=models.CASCADE, related_name="likes")
    object_id = models.PositiveIntegerField()
    content_object = GenericForeignKey('content_type','object_id')
    class Meta:
        unique_together = [('user', 'content_type', 'object_id')]