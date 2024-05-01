import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:video_player/video_player.dart';

import '../bloc/get all reel/get_all_reel_bloc.dart';

import 'package:snapping_bottom_sheet/snapping_bottom_sheet.dart';

class CustomVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final String profileImageurl;
  final String authorName;
  final String reelId;
  final int numberOfLike;
  final bool isLiked;
  const CustomVideoPlayer({
    super.key,
    required this.videoUrl,
    required this.profileImageurl,
    required this.authorName,
    required this.reelId,
    required this.numberOfLike,
    required this.isLiked,
  });

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerController _controller;
  bool isComment = false;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {});
      });
    _controller.play();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void setCommented() {
    setState(() {
      isComment = !isComment;
    });
  }

  void test() async {
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
          return Container(
            height: 500,
            child: Center(
              child: Text(
                'This is the content of the sheet',
              ),
            ),
          );
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
                    color: Colors.white,
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
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          );
        },
        footerBuilder: (context, state) => Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.profileImageurl),
              radius: 20,
            ),
            Expanded(
              child: Card(
                child: TextField(
                  onSubmitted: (value) => print(value),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.white, fontSize: 14),
                    hintText: "Add a comment",
                    hintStyle: TextStyle(color: Colors.white10, fontSize: 14),
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.send_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  void showAsBottomSheet() async {
    final result = await showSnappingBottomSheet(context, builder: (context) {
      return SnappingBottomSheetDialog(
        color: Color(0xFF262626),
        elevation: 8,
        cornerRadius: 25,
        snapSpec: const SnapSpec(
          snap: true,
          snappings: [112, 400, double.infinity],
          positioning: SnapPositioning.pixelOffset,
        ),
        headerBuilder: (context, state) => Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 4,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
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
            ],
          ),
        ),
        footerBuilder: (context, state) => Text("footer"),
        builder: (context, state) {
          return Container(
            height: 400,
            child: Center(
              child: Material(
                child: InkWell(
                  onTap: () => Navigator.pop(context, 'This is the result.'),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'This is the content of the sheet',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(),
        ),
        Positioned(
          child: Column(
            children: [
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      BlocProvider.of<GetAllReelBloc>(context).add(
                        GetAllLikeReelEvent(reelId: widget.reelId),
                      );
                    },
                    icon: Icon(
                      Icons.favorite_outline_rounded,
                      color: widget.isLiked ? Colors.red : Colors.white,
                      size: 30,
                    ),
                  ),
                  Text(
                    "${widget.numberOfLike}",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    onPressed: () => test(),
                    icon: Icon(
                      Icons.favorite_outline_rounded,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "608K",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              Column(
                children: [
                  Transform.rotate(
                    angle: -45 * 3.141592653589793 / 180,
                    child: IconButton(
                      icon: Icon(
                        Icons.send_outlined,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {}, // Adjust color as needed
                    ),
                  ),
                  Text(
                    "608K",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
          right: 20,
          bottom: 90,
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.profileImageurl),
                    radius: 20,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    widget.authorName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  SizedBox(
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
                  ),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                "If you think AI can replace you, then may be you are not a good...",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// class SingleReel extends StatelessWidget {
//   final String reelId;
//   final String videoUrl;
//   const SingleReel({required this.reelId, required this.videoUrl, super.key});

//   @override
//   Widget build(BuildContext context) {
//     print(
//         "-------------------------${reelId}----------------------------------");
//     BlocProvider.of<GetSingleReelBloc>(context).add(
//       GetSingleReel(reelId: reelId),
//     );
//     return BlocBuilder<GetSingleReelBloc, GetSingleReelState>(
//         builder: (context, state) {
//       if (state is GetSingleReelSuccess) {
//         return CustomVideoPlayer(
//           videoUrl: state.reel.video,
//           profileImageurl: state.reel.author!.profile_image,
//           authorName: state.reel.author!.name,
//           reelId: "${state.reel.id}",
//         );
//       } else if (state is GetSingleReelInProgress) {
//         return Text("Loading");
//       } else if (state is GetSingleReelFailure) {
//         return Text("${state.message}");
//       } else {
//         return Text("Initial State");
//       }
//     });
//   }
// }
