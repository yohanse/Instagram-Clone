from djoser.serializers import UserCreateSerializer as BaseUserCreateSerializer
from rest_framework import serializers
from . import models

class UserCreateSerializer(BaseUserCreateSerializer):
    class Meta(BaseUserCreateSerializer.Meta):
        model = models.User
        fields = ['id', 'email']


class ConfirmationSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Confirmation
        fields=['email']

class CheckConfirmationSerializer(ConfirmationSerializer):
    class Meta(ConfirmationSerializer.Meta):
        fields=['email', 'confirmation_code']