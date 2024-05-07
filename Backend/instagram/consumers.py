import json

from channels.generic.websocket import AsyncWebsocketConsumer
from . import models, seriliazer
from channels.db import database_sync_to_async


class ChatConsumer(AsyncWebsocketConsumer):
    async def connect(self):
        self.receiver_id = self.scope["url_route"]["kwargs"]["receiver_id"]
        self.sender_id = self.scope["user"].id
        self.room_group_name = f"chat_sender_id{self.sender_id}receiver_id{self.receiver_id}"

        await self.channel_layer.group_add(self.room_group_name, self.channel_name)

        await self.accept()

    async def disconnect(self, close_code):
        # Leave room group
        await self.channel_layer.group_discard(self.room_group_name, self.channel_name)

    async def receive(self, text_data):
        text_data_json = json.loads(text_data)
        message = text_data_json["message"]
        file = text_data_json.get("file")
        message = await self.create_message(message, file)

        json_message = seriliazer.MessageSerializer(message).data
        # Send message to room group
        await self.channel_layer.group_send(
            self.room_group_name, json_message
        )

    # Receive message from room group
    async def chat_message(self, event):
        message = event["message"]

        # Send message to WebSocket
        await self.send(text_data=json.dumps({"message": message}))

    @database_sync_to_async
    def create_message(self, message, file=None):
        new_message = models.Message.objects.create(
            sender_id=self.sender_id, receiver_id=self.receiver_id, message=message, file=file,
        )
        new_message.save()
        return new_message
