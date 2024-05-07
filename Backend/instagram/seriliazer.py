from rest_framework import serializers
from django.contrib.contenttypes.models import ContentType
from . import models


class UserProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.User
        fields = ['bio']

    def create(self, validated_data):
        validated_data['user_id'] = self.context['request'].user.id
        return super().create(validated_data)


class UserProfileShortSerializer(serializers.ModelSerializer):
    name = serializers.SerializerMethodField()
    class Meta:
        model = models.User
        fields = ['user_id', "name", 'profile_image',]
    
    def get_name(self, obj):
        return obj.user.first_name
    def create(self, validated_data):
        validated_data['user_id'] = self.context['request'].user.id
        print(validated_data)
        return super().create(validated_data)
    
    
class ImageSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Image
        fields = ('id', 'image')


class VideoSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Video
        fields = ['id', 'video']

class VideoSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Video
        fields = ('id', 'video')

class LikeSerializer(serializers.ModelSerializer):
    user = UserProfileShortSerializer(read_only=True)
    class Meta:
        model = models.Like
        fields = ("user", 'id', 'created_at')

    def create(self, validated_data):
        validated_data["user_id"] = self.context["user_id"]
        validated_data["object_id"] = self.context["object_id"]
        validated_data["content_type"] = self.context["content_type"]
        return super().create(validated_data)

class CommentSerializer(serializers.ModelSerializer):
    user = UserProfileShortSerializer(read_only=True)
    class Meta:
        model = models.Comment
        fields = ("user", 'id', 'content', 'created_at')

    def create(self, validated_data):
        validated_data["user_id"] = self.context["user_id"]
        validated_data["object_id"] = self.context["object_id"]
        validated_data["content_type"] = self.context["content_type"]
        return super().create(validated_data)


class PostSerializer(serializers.ModelSerializer):
    user = UserProfileShortSerializer(read_only=True)
    upload_images =  serializers.ListField(
        child=serializers.ImageField(allow_empty_file=False, use_url=False),
        write_only=True
    )
    images = ImageSerializer(many=True, read_only=True)
    comments = serializers.SerializerMethodField()
    numberOfLike = serializers.SerializerMethodField()
    isILiked = serializers.SerializerMethodField()
    

    class Meta:
        model = models.Post
        fields = ['id', 'user', 'text', 'created_at', 'images', "comments", "upload_images", "numberOfLike", "isILiked"]
    
    def create(self, validated_data):
        upload_images = validated_data.pop("upload_images")
        validated_data["user_id"] = self.context["request"].user.id
        post = models.Post.objects.create(**validated_data)

        for image_data in upload_images:
            image_instance = models.Image.objects.create(image=image_data)
            post.images.add(image_instance)

        return post
    
    def get_comments(self, post):
        comments = models.Comment.objects.filter(content_type=ContentType.objects.get_for_model(post), object_id=post.id)
        return CommentSerializer(comments, many=True).data
    
    def get_numberOfLike(self, post):
        return models.Like.objects.filter(content_type=ContentType.objects.get_for_model(post), object_id=post.id).count()
    
    def get_isILiked(self, post):
        
        return bool(models.Like.objects.filter(content_type=ContentType.objects.get_for_model(post), object_id=post.id, user_id=self.context["request"].user.id).count())
    

class ReelSerializer(serializers.ModelSerializer):
    user = UserProfileShortSerializer(read_only=True)
    upload_video =  serializers.FileField(allow_empty_file=False, use_url=False, write_only=True)
    video = VideoSerializer(read_only=True)
    likes = serializers.SerializerMethodField()
    comments = serializers.SerializerMethodField()
    numberOfLike = serializers.SerializerMethodField()
    isILiked = serializers.SerializerMethodField()
    likeIdILike = serializers.SerializerMethodField(read_only=True)

    class Meta:
        model = models.Reel
        fields = ['id', 'user', 'content', 'created_at', 'video', "likes", "comments", "upload_video", "numberOfLike", "isILiked", "likeIdILike"]
    
    def create(self, validated_data):
        validated_data["user_id"] = self.context["request"].user.id
        
        video_instance = models.Video.objects.create(video=validated_data["upload_video"])
        validated_data.pop("upload_video")
        validated_data["video_id"] = video_instance.id
        return super().create(validated_data)
    
    def get_likes(self, reel):
        likes = models.Like.objects.filter(content_type=ContentType.objects.get_for_model(reel), object_id=reel.id)
        return LikeSerializer(likes, many=True).data
    
    def get_comments(self, reel):
        comments = models.Comment.objects.filter(content_type=ContentType.objects.get_for_model(reel), object_id=reel.id)
        return CommentSerializer(comments, many=True).data
    
    def get_numberOfLike(self, reel):
        return models.Like.objects.filter(content_type=ContentType.objects.get_for_model(reel), object_id=reel.id).count()
    
    def get_isILiked(self, reel):
        return bool(models.Like.objects.filter(content_type=ContentType.objects.get_for_model(reel), object_id=reel.id, user_id=self.context["request"].user.id).count())
    
    def get_likeIdILike(self, reel):
        try:
            like = models.Like.objects.get(content_type=ContentType.objects.get_for_model(reel), object_id=reel.id, user_id=self.context["request"].user.id)
            
            return like.id
        except:
            return None
        


class MessageSerializer(serializers.ModelSerializer):
    sender = UserProfileShortSerializer(read_only=True)
    receiver = UserProfileShortSerializer(read_only=True)
    class Meta:
        model = models.Message
        fields = ['id', 'sender', 'receiver', 'content', 'created_at', 'file']

    def create(self, validated_data):
        validated_data["sender_id"] = self.context["request"].user.id
        return super().create(validated_data)
        