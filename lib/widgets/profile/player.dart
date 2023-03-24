import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';


class LocalVideoPlayer extends StatefulWidget {
  final String path ; 
  const LocalVideoPlayer({super.key ,  required this.path });

  @override
  _LocalVideoPlayerState createState() => _LocalVideoPlayerState();
}

class _LocalVideoPlayerState extends State<LocalVideoPlayer> {
  VideoPlayerController? _controller;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.path);
    _chewieController = ChewieController(
      videoPlayerController: _controller!,
      autoInitialize: true,
      looping: true,
      aspectRatio: 9 / 16,
      autoPlay: true,
      allowFullScreen: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Center(
        child: Chewie(
          controller: _chewieController!,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }
}
