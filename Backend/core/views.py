from rest_framework.response import Response
from rest_framework.viewsets import GenericViewSet
from rest_framework.mixins import CreateModelMixin
from . import serializers
from rest_framework import status

class CheckEmail(CreateModelMixin, GenericViewSet):
    serializer_class = serializers.ConfirmationSerializer
    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        self.perform_create(serializer)
        headers = self.get_success_headers(serializer.data)
        return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)
    def perform_create(self, serializer):
        serializer.validated_data['confirmation_code'] = "123456"
        serializer.save()
    

