import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
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
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                "Chat Page",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
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
                      onPressed: () {},
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
                SizedBox(height: 8,),
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
  final String name;
  final String profile_image;
  UserParams({
    required this.name,
    required this.profile_image,
  });
}
