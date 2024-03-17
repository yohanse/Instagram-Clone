from rest_framework.response import Response
from rest_framework.viewsets import GenericViewSet
from rest_framework.mixins import CreateModelMixin
from . import serializers
from rest_framework import status
from . import utiles
from . import models

from djoser.views import UserViewSet as DjoserUserViewSet

class CheckEmailView(CreateModelMixin, GenericViewSet):
    serializer_class = serializers.ConfirmationSerializer
    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        email = serializer.validated_data['email']

        # check if it already have an account
        try:
            models.User.objects.get(email=email)
            return Response({'error': 'Email already exists'}, status=status.HTTP_400_BAD_REQUEST)
        except:
            try: 
                models.Confirmation.objects.get(email=email).delete()
            finally:
                try:
                    self.perform_create(serializer, utiles.send_email(email))
                    headers = self.get_success_headers(serializer.data)
                    return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)
                except:
                    return Response({"error": "Email does not exist."}, status=status.HTTP_509_BANDWIDTH_LIMIT_EXCEEDED)
            
    def perform_create(self, serializer, code):
        serializer.validated_data['confirmation_code'] = code
        serializer.save()



class CheckConfirmationView(CreateModelMixin, GenericViewSet):
    serializer_class = serializers.CheckConfirmationSerializer
    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        email = serializer.validated_data['email']
        confirmation_code = serializer.validated_data['confirmation_code']
        try:
            confirmation = models.Confirmation.objects.get(email=email, confirmation_code=confirmation_code)
            confirmation.delete()
            return Response({'valid': True}, status=status.HTTP_200_OK)
        except models.Confirmation.DoesNotExist:
            return Response({'valid': False}, status=status.HTTP_200_OK)
        

class CheckUsernameView(CreateModelMixin, GenericViewSet):
    serializer_class = serializers.CheckUsernameSerializer
    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        username = serializer.validated_data['username']
        print(serializer.validated_data)
        try:
            confirmation = models.User.objects.get(username=username)
            return Response({'valid': False}, status=status.HTTP_200_OK)
        except models.User.DoesNotExist:
            return Response({'valid': True}, status=status.HTTP_200_OK)