from rest_framework.permissions import IsAuthenticated, BasePermission
from rest_framework import permissions

class CanDeletePost(BasePermission):
    def has_permission(self, request, view):
        if request.method in permissions.SAFE_METHODS:
            return bool(request.user and request.user.is_authenticated)
        return bool(request.user and request.user.is_authenticated)
    
    def has_object_permission(self, request, view, obj):
        if request.method == "DELETE" or request.method == "UPDATE":
            return obj.author_id == request.user.id
        return True
    