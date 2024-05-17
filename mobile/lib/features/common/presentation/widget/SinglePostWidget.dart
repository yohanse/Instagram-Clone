import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:snapping_bottom_sheet/snapping_bottom_sheet.dart';

import '../../../message/presentation/page/message_with_user.dart';
import '../bloc/post/post_bloc.dart';

class SignlePostWidget extends StatelessWidget {
  final String imageUrl, authName, profileImageUrl, text;
  final int numberOfComment, numberOfLike, postId;
  final DateTime time;
  final bool isILiked;
  final int? likeId;
  final int index;
  final UserParams author;

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
    required this.author,
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
                height: 700,
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
          postIndex: index,
          profileImageUrl: profileImageUrl,
          author: author,
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

class BottomBarButtons extends StatefulWidget {
  final bool isIliked;
  final int postId, postIndex;
  final int? likeId;
  final String profileImageUrl;
  final UserParams author;

  BottomBarButtons({
    super.key,
    required this.isIliked,
    required this.postId,
    this.likeId,
    required this.postIndex,
    required this.profileImageUrl,
    required this.author,
  });

  @override
  State<BottomBarButtons> createState() => _BottomBarButtonsState();
}

class _BottomBarButtonsState extends State<BottomBarButtons> {
  final TextEditingController _commentController = TextEditingController();

  void commentBottomSheet() async {
    showSnappingBottomSheet(context, builder: (context) {
      return SnappingBottomSheetDialog(
        elevation: 8,
        cornerRadius: 25,
        color: Color(0xFF262626),
        snapSpec: const SnapSpec(
          snap: true,
          snappings: [0.6, 1],
        ),
        builder: (context, state) {
          return BlocBuilder<PostBloc, PostState>(builder: (context, state) {
            if (state is PostLoaded && state.post.isNotEmpty) {
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: state.post[widget.postIndex].comments!.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Color(0xFF262626),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(state
                            .post[widget.postIndex]
                            .comments![index]
                            .user
                            .profile_image),
                        radius: 25,
                      ),
                      title: Text(
                        state.post[widget.postIndex].comments![index].user.name,
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                          state.post[widget.postIndex].comments![index].content,
                          style: TextStyle(color: Colors.white)),
                    ),
                  );
                },
              );
            }
            return Text(
              "Loading",
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                decoration: TextDecoration.none,
              ),
            );
          });
        },
        headerBuilder: (context, state) {
          return Container(
            height: 56,
            width: double.infinity,
            padding: EdgeInsets.only(top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 4,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Comments",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    decoration: TextDecoration.none,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: 1,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        },
        footerBuilder: (context, state) => Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  "http://192.168.43.57:8000${widget.profileImageUrl}"),
              radius: 20,
            ),
            Expanded(
              child: Card(
                child: Container(
                  color: Color(0xFF262626),
                  child: TextField(
                    autofocus: true,
                    controller: _commentController,
                    onSubmitted: (value) {
                      BlocProvider.of<PostBloc>(context).add(
                        CommentPostEvent(
                          postId: widget.postId,
                          content: value,
                        ),
                      );
                      _commentController.clear();
                    },
                    decoration: InputDecoration(
                      hintText: "Add a comment",
                      hintStyle: TextStyle(color: Colors.white10, fontSize: 14),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  size: 30,
                  widget.isIliked
                      ? Icons.favorite_rounded
                      : Icons.favorite_outline_rounded,
                  color: widget.isIliked ? Colors.red : Colors.white,
                ),
                onPressed: () {
                  if (!widget.isIliked) {
                    BlocProvider.of<PostBloc>(context).add(
                      LikePostEvent(postId: widget.postId),
                    );
                  } else {
                    BlocProvider.of<PostBloc>(context).add(
                      UnLikePostEvent(
                        postId: widget.postId,
                        likeId: widget.likeId!,
                      ),
                    );
                  }
                },
              ),
              IconButton(
                onPressed: () => commentBottomSheet(),
                icon: Icon(
                  Icons.chat_bubble_outline_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              IconButton(
                onPressed: () => context.go(
                  "/message/chat",
                  extra: widget.author,
                ),
                icon: Transform.rotate(
                  angle: -45 * 3.141592653589793 / 180,
                  child: Icon(
                    size: 30,
                    Icons.send_outlined,
                    color: Colors.white,
                  ),
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
