import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              context.go("/posts");
            },
            icon: Icon(
              Icons.home,
              color: Colors.white,
              size: 30,
            ),
          ),
          Icon(
            Icons.search,
            color: Colors.white,
            size: 30,
          ),
          IconButton(
            icon: Icon(
              Icons.add_circle_outline,
              size: 40,
            ),
            color: Colors.white,
            onPressed: () {
              context.go("/pickImage");
            },
          ),
          IconButton(
            onPressed: () {
              context.go("/reel");
            },
            icon: Icon(
              Icons.video_collection_outlined,
              color: Colors.white,
              size: 30,
            ),
          ),
          GestureDetector(
            onTap: () {
              context.go("/profile");
            },
            child: const CircleAvatar(
              backgroundImage: NetworkImage(
                  "http://192.168.43.57:8000/media/profile/images/profile.webp"),
              radius: 15,
            ),
          ),
        ],
      ),
    );
  }
}
