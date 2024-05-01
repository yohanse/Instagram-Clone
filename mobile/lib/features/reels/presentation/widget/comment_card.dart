import 'package:flutter/material.dart';

class CommentCard extends StatelessWidget {
  final String profileImage, authorName, commentContent;
  const CommentCard(
      {super.key,
      required this.profileImage,
      required this.authorName,
      required this.commentContent});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(profileImage),
          radius: 25,
        ),
        Column(
          children: [
            Text(
              authorName,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            Text(
              commentContent,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
