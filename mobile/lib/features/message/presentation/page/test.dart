import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebsocketDemo extends StatefulWidget {
  const WebsocketDemo({Key? key}) : super(key: key);

  @override
  State<WebsocketDemo> createState() => _WebsocketDemoState();
}

class _WebsocketDemoState extends State<WebsocketDemo> {
  String btcUsdtPrice = "0";
  final channel = IOWebSocketChannel.connect(
    protocols: ["websocket", "http"],
    headers: {
        'Content-Type': 'application/json',
        'Authorization':
            "JWT eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzE3NTY3OTcxLCJpYXQiOjE3MTIzODM5NzEsImp0aSI6ImM0NTY2YjgxZTMxODRlYjE5ZDlmOWI2YmJiNzQ2ZDlmIiwidXNlcl9pZCI6MX0.y7M19fO4EcaKgPXI-LLrOjGzFCz98gEWld3kcWDp4os",
      },
    'ws://127.0.0.1:8000/ws/chat/john/',);
  @override
  void initState() {
    super.initState();
    streamListener();
  }

  streamListener() {
    channel.stream.listen((message) {
      // channel.sink.add('received!');
      // channel.sink.close(status.goingAway);
      Map getData = jsonDecode(message);
      setState(() {
        btcUsdtPrice = getData['p'];
      });
      // print(getData['p']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "BTC/USDT Price",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 30),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                btcUsdtPrice,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 250, 194, 25),
                    fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';
// import 'package:web_socket_channel/status.dart' as status;

// class ChatTestPage extends StatefulWidget {
//   const ChatTestPage({super.key});

//   @override
//   State<ChatTestPage> createState() => _ChatTestPageState();
// }

// class _ChatTestPageState extends State<ChatTestPage> {
//   final channel = WebSocketChannel.connect(
//     Uri.parse(
//       "ws://127.0.0.1:8000/ws/chat/lobby/",
//     ),
//   );

  

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder(
//         stream: channel.stream,
//         builder: (context, snapshot) {
//           return Column(
//             children: [
//               TextField(
//                 onSubmitted: (value) {
//                   channel.sink.add(value);
//                 },
//               ),
//               Expanded(
//                 child: ListView(
//                   children: [
//                     snapshot.hasData
//                         ? Text(
//                             "data",
//                           )
//                         : Text(
//                             "no data",
//                           )
//                   ],
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
