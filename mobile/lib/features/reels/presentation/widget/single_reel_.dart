import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import '../bloc/like reel/like_reel_bloc.dart';

class CustomVideoPlayer extends StatefulWidget {
  final String reelId;
  const CustomVideoPlayer(
      {super.key,
      required this.reelId});

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
                setState(() {});
      });
    _controller.play();
  }

  @override
  void dispose() {
    super.dispose();
    _controller
        .dispose(); 
  }

  @override
  Widget build(BuildContext context) {
    return ;
  }
}
