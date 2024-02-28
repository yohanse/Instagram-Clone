from djoser.serializers import UserCreateSerializer as BaseUserCreateSerializer

class UserCreateSerializer(BaseUserCreateSerializer):
    
    class Meta(BaseUserCreateSerializer.Meta):
        fields = ['id', 'password', 'email', 'birth_date', 'username', 'first_name', 'last_name']