import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';


class ChatTestPage extends StatefulWidget {
  const ChatTestPage({super.key});

  @override
  State<ChatTestPage> createState() => _ChatTestPageState();
}

class _ChatTestPageState extends State<ChatTestPage> {
  TextEditingController messageController = TextEditingController();
  late WebSocketChannel channel;

  List<String> messages = [];
  @override
  void initState() {
    channel = WebSocketChannel.connect(
      Uri.parse('ws://127.0.0.1:8000/ws/chat/lobby/'),
    );
    preparing();
    super.initState();
  }
  Future<void> preparing() async {
    await channel.ready;

    channel.stream.listen((event) {
      
    }, onDone: () {
      channel.sink.close(status.goingAway);
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
    );
  }
}