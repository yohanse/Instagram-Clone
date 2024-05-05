import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile/features/profile/Domain/Entite/profile_entitie.dart';

class ChatPage extends StatelessWidget {
  final UserParams userParams;
  ChatPage({super.key, required this.userParams});
  TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(userParams.profile_image),
            radius: 25,
          ),
          title: Text(
            userParams.name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
      body: Center(
        child: Text(
          "Chat Page",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
      bottomNavigationBar: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: messageController,
            decoration: InputDecoration(
              disabledBorder: InputBorder.none,
              suffix: IconButton(
                icon: Icon(
                  Icons.send,
                  color: Colors.blue,
                ),
                onPressed: () {},
              ),
              hintText: "Message...",
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}

class UserParams {
  final String name;
  final String profile_image;
  UserParams({
    required this.name,
    required this.profile_image,
  });
}
