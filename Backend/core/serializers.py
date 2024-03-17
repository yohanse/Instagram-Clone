from djoser.serializers import UserCreateSerializer as BaseUserCreateSerializer
from rest_framework import serializers
from . import models

class UserCreateSerializer(BaseUserCreateSerializer):
    class Meta(BaseUserCreateSerializer.Meta):
        model = models.User

    def perform_create(self, validated_data):
        user = super().perform_create(validated_data)
        email = user.email

        try:
            confirmation = models.Confirmation.objects.get(email=email, is_confirmed=True)
        except models.Confirmation.DoesNotExist:
            raise serializers.ValidationError({'error': 'Email not confirmed. Please confirm your email to proceed.'})

        return user

class ConfirmationSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Confirmation
        fields=['email']

class CheckConfirmationSerializer(ConfirmationSerializer):
    class Meta(ConfirmationSerializer.Meta):
        fields=['email', 'confirmation_code']

class CheckUsernameSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.User
        fields=['username']