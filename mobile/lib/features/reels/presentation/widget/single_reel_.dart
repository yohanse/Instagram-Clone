import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final String videoUrl;
  const CustomVideoPlayer({super.key, required this.videoUrl});

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    _controller.play();
  }

  @override
  void dispose() {
    super.dispose();
    _controller
        .dispose(); // Dispose the VideoPlayerController to release resources.
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
                    onPressed: () {},
                    icon: Icon(
                      Icons.favorite_outline_rounded,
                      color: Colors.white,
                      size: 30,
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
                  IconButton(
                    onPressed: () {},
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
                  IconButton(
                    onPressed: () {},
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
            ],
          ),
          right: 20,
          bottom: 90,
        ),
      ],
    );
  }
}
