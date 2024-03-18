from djoser.serializers import UserCreateSerializer as BaseUserCreateSerializer
from rest_framework import serializers
from . import models

class UserCreateSerializer(BaseUserCreateSerializer):
    class Meta(BaseUserCreateSerializer.Meta):
        model = models.User
        fields = ['email', 'password', 'birth_date', 'first_name', 'username']

    def perform_create(self, validated_data):
        email = validated_data['email']

        try:
            models.Confirmation.objects.get(email=email, is_confirmed=True)
        except models.Confirmation.DoesNotExist:
            raise serializers.ValidationError({'error': 'Email not confirmed. Please confirm your email to proceed.'})
            
        user = super().perform_create(validated_data)
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