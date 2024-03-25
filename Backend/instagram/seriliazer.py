from rest_framework import serializers
from . import models


class UserProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.UserProfile
        fields = ['bio']

    def create(self, validated_data):
        validated_data['user_id'] = self.context['request'].user.id
        return super().create(validated_data)



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
        fields = ('id', 'created_at')
    
    def create(self, validated_data):
        validated_data["user_id"] = self.context["user_id"]
        validated_data["post_id"] = self.context["post_id"]
        return super().create(validated_data)

class CommentSerializer(serializers.ModelSerializer):

    class Meta:
        model = models.Comment
        fields = ('id', 'content', 'created_at')

    def create(self, validated_data):
        validated_data["user_id"] = self.context["user_id"]
        validated_data["post_id"] = self.context["post_id"]
        return super().create(validated_data)


class PostSerializer(serializers.ModelSerializer):
    author = UserProfileSerializer(read_only=True)
    upload_images =  serializers.ListField(
        child=serializers.ImageField(allow_empty_file=False, use_url=False),
        write_only=True
    )
    images = ImageSerializer(many=True, read_only=True)
    videos = VideoSerializer(many=True, read_only=True)
    comments = CommentSerializer(many=True, read_only=True)
    likes = LikeSerializer(many=True, read_only=True)

    class Meta:
        model = models.Post
        fields = ('id', 'author', 'text', 'created_at', 'images', 'videos', "upload_images", "comments", "likes")
    
    def create(self, validated_data):
        upload_images = validated_data.pop("upload_images")
        validated_data["author_id"] = self.context["request"].user.id
        post = models.Post.objects.create(**validated_data)

        for image_data in upload_images:
            image_instance = models.Image.objects.create(image=image_data)
            post.images.add(image_instance)

        return post