import json
import jwt
from channels.generic.websocket import AsyncWebsocketConsumer
from . import models, seriliazer
from channels.db import database_sync_to_async
from rest_framework_simplejwt.tokens import AccessToken
from django.conf import settings


class ChatConsumer(AsyncWebsocketConsumer):
    async def connect(self):
        self.receiver_id = self.scope["url_route"]["kwargs"]["receiver_id"]
        self.sender_id = await self.get_sender_id_from_token()
        print(self.sender_id, self.receiver_id)
        self.room_group_name = f"chat_sender_id{self.sender_id}receiver_id{self.receiver_id}"

        await self.channel_layer.group_add(self.room_group_name, self.channel_name)

        await self.accept()

    async def disconnect(self, close_code):
        # Leave room group
        await self.channel_layer.group_discard(self.room_group_name, self.channel_name)

    async def receive(self, text_data):
        text_data = json.loads(text_data)
        message_data = text_data["message"]
        await self.create_message(message_data)
        
        # Send message to room group
        await self.channel_layer.group_send(
            self.room_group_name, text_data
        )

    # Receive message from room group
    async def chat_message(self, event):
        message = event["message"]

        # Send message to WebSocket
        await self.send(text_data=json.dumps({"message": message}))

    @database_sync_to_async
    def create_message(self, message, file=None):
        new_message = models.Message.objects.create(
            sender_id=self.sender_id, receiver_id=self.receiver_id, content=message, file=file,
        )
        new_message.save()
        return new_message

    @database_sync_to_async
    def get_sender_id_from_token(self):
        
        try:
            token = self.scope['headers'][6][1].split()[1]
            decoded_token = jwt.decode(token, settings.SECRET_KEY, algorithms=['HS256'])
            user_id = decoded_token['user_id']
            print("*" * 100)
            print(user_id)
            models.User.objects.get(user_id=user_id)
            print("*" * 100)
            return user_id
        except Exception as e:
            return None
        
    @database_sync_to_async
    def get_json(self, message):
        return seriliazer.MessageSerializer(message).data
