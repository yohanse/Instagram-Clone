import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatPage extends StatefulWidget {
  final UserParams userParams;
  ChatPage({super.key, required this.userParams});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController messageController = TextEditingController();
  final channel = WebSocketChannel.connect(
    Uri.parse('ws://192.168.43.57:8000/ws/chat/2/'),
  );
  List<String> messages = [];
  @override
  void initState() {
    super.initState();
    streamListener();
  }

  streamListener() {
    channel.stream.listen((message) {
      print(
          "====================================================================================================================================");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => context.go("/"),
        ),
        title: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(widget.userParams.profile_image),
            radius: 25,
          ),
          title: Text(
            widget.userParams.name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemBuilder: (context, index) => Text(
                      messages[index],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                itemCount: messages.length),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: messageController,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        channel.sink.add(jsonEncode({
                          'type': 'chat.message',
                          'message': 'Hello, world!',
                        }));

                        messageController.clear();
                      },
                    ),
                    disabledBorder: InputBorder.none,
                    hintText: "Message...",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                Container(
                  color: Colors.grey,
                  width: double.maxFinite,
                  height: 1,
                ),
                SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ],
      ),
      // Container(
      //   height: double.maxFinite,
      //   width: double.maxFinite,
      //   child:

      // ),
    );
  }
}

class UserParams {
  final String id;
  final String name;
  final String profile_image;
  UserParams({
    required this.name,
    required this.profile_image,
    required this.id,
  });
}
