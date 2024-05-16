import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/post/post_bloc.dart';

class SignlePostWidget extends StatelessWidget {
  final String imageUrl, authName, profileImageUrl, text;
  final int numberOfComment, numberOfLike, postId;
  final DateTime time;
  final bool isILiked;
  final int? likeId;
  final int index;

  const SignlePostWidget({
    super.key,
    required this.imageUrl,
    required this.authName,
    required this.profileImageUrl,
    required this.numberOfComment,
    required this.numberOfLike,
    required this.text,
    required this.time,
    required this.isILiked,
    required this.postId,
    required this.likeId,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                imageUrl,
                height: 500,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: ProfileWidget(
                authorName: authName,
                profileImageUrl: profileImageUrl,
              ),
            ),
            Positioned(
              top: 15,
              right: 10,
              child: FollowButton(),
            ),
          ],
        ),
        BottomBarButtons(
          isIliked: isILiked,
          postId: postId,
          likeId: likeId,
        ),
        LastSection(
          text: text,
          time: time,
          numberOfComment: numberOfComment,
          numberOfLike: numberOfLike,
        )
      ],
    );
  }
}

class FollowButton extends StatelessWidget {
  const FollowButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 86,
      child: ElevatedButton(
        onPressed: () {},
        child: Text(
          "Follow",
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
            side: BorderSide(color: Colors.white, width: 1.0),
          ),
        ),
      ),
    );
  }
}

class ProfileWidget extends StatelessWidget {
  final String profileImageUrl;
  final String authorName;
  const ProfileWidget(
      {super.key, required this.profileImageUrl, required this.authorName});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(profileImageUrl),
          radius: 20,
        ),
        SizedBox(
          width: 15,
        ),
        Text(
          authorName,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

class BottomBarButtons extends StatelessWidget {
  final bool isIliked;
  final int postId;
  final int? likeId;

  const BottomBarButtons({
    super.key,
    required this.isIliked,
    required this.postId,
    this.likeId,
  });

  @override
  Widget build(BuildContext context) {
    print(
        "<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>$isIliked");
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            textBaseline: TextBaseline.alphabetic,
            children: [
              IconButton(
                icon: Icon(
                  isIliked
                      ? Icons.favorite_rounded
                      : Icons.favorite_outline_rounded,
                  color: isIliked ? Colors.red : Colors.white,
                ),
                onPressed: () {
                  print(
                      "likeIdIlike likeIdIlike likeIdIlike likeIdIlikelikeIdIlikelikeIdIlike likeIdIlike: $likeId");
                  if (!isIliked) {
                    print(
                        "liking post liking post liking post liking post liking post liking post liking post");
                    BlocProvider.of<PostBloc>(context).add(
                      LikePostEvent(postId: postId),
                    );
                  } else {
                    print("unlike post unlike post unlike post unlike post unlike post unlike post unlike post unlike post");
                    BlocProvider.of<PostBloc>(context).add(
                      UnLikePostEvent(
                        postId: postId,
                        likeId: likeId!,
                      ),
                    );
                  }
                },
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.chat_bubble_outline_rounded,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Transform.rotate(
                angle: -45 * 3.141592653589793 / 180,
                child: Icon(
                  Icons.send_outlined,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          Icon(
            Icons.bookmark_outline_rounded,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

class LastSection extends StatelessWidget {
  final int numberOfLike, numberOfComment;
  final String text;
  final DateTime time;
  const LastSection(
      {super.key,
      required this.numberOfLike,
      required this.text,
      required this.time,
      required this.numberOfComment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$numberOfLike likes",
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          Text(
            "View all $numberOfComment comments",
            style: TextStyle(
              color: Colors.white10,
              fontSize: 12,
            ),
          ),
          Text(
            "${time.day} ${time.month}",
            style: TextStyle(
              color: Colors.white10,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
