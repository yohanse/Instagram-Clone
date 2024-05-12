import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/features/message/Domain/entitie/message_entitie.dart';
import 'package:mobile/features/message/data/models/message_model.dart';
import 'package:mobile/features/message/presentation/bloc/fetch%20messages/fetch_messages_bloc.dart';
import 'package:mobile/features/message/presentation/widget/message_accepting_widget.dart';
import 'package:mobile/features/message/presentation/widget/message_sending_widget.dart';
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

  final channel = IOWebSocketChannel.connect(
    headers: {
      'Authorization':
          "JWT eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzE3NTY3OTcxLCJpYXQiOjE3MTIzODM5NzEsImp0aSI6ImM0NTY2YjgxZTMxODRlYjE5ZDlmOWI2YmJiNzQ2ZDlmIiwidXNlcl9pZCI6MX0.y7M19fO4EcaKgPXI-LLrOjGzFCz98gEWld3kcWDp4os",
    },
    Uri.parse('ws://192.168.43.57:8000/ws/chat/2/'),
  );
  List<dynamic> messages = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<FetchMessagesBloc>(context).add(
      GetMessagesEvent(
        recieverId: widget.userParams.id,
      ),
    );
    streamListener();
  }

  streamListener() {
    channel.stream.listen((message) {
      setState(() {
        messages.insert(
          0,
          jsonDecode(message),
        );
      });
    });
  }

  void sendMessage() {
    channel.sink.add(messageController.text);
    messageController.clear();
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
          BlocBuilder<FetchMessagesBloc, FetchMessagesState>(
              builder: (context, state) {
            if (state is FetchMessagesLoadedState) {
              return Expanded(
                child: ListView.builder(
                    reverse: true,
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      if ("${state.messages[index].sender.user_id}" !=
                          widget.userParams.id) {
                        return MessageSendingWidget(
                            message: state.messages[index]);
                      }
                      return MessageAcceptingWidget(
                          message: state.messages[index]);
                    }),
              );
            } else if (state is FetchMessagesErrorState) {
              return Center(
                child: Text(
                  state.message,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              );
            }
            return Center(
                child: Text(
                  "Loading.......",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              );
          }),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: messageController,
                  onSubmitted: (value) => sendMessage(),
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
                        channel.sink.add(messageController.text);
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
