import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:paytel/repositories/dio.dart';
import 'package:paytel/style/theme.dart' as Style;
import 'package:paytel/widgets/profile/record-animation.dart';
import 'package:video_player/video_player.dart';
import '../../const.dart';

class VideoRecorderWidget extends StatefulWidget {
  final List<CameraDescription> cameras;

  const VideoRecorderWidget({Key? key, required this.cameras})
      : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _VideoRecorderWidgetState createState() => _VideoRecorderWidgetState();
}

class _VideoRecorderWidgetState extends State<VideoRecorderWidget> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  bool _isRecording = false;
  String? videoPath;
  int _timerValue = 20;
  Timer? _timer;
  VoidCallback? videoPlayerListener;
  VideoPlayerController? videoController;
  double uploadProgress = 0.0;
  @override
  void initState() {
    super.initState();

    initCameraController();
  }

  Future<void> initCameraController() async {
    final CameraDescription frontCamera = widget.cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
    );
    final CameraDescription selectedCamera = frontCamera;
    _controller = CameraController(selectedCamera, ResolutionPreset.medium);
    _initializeControllerFuture = _controller!.initialize();
  }

  @override
  void dispose() {
    _controller?.dispose();
    videoController?.dispose();
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _startRecording() async {
    if (!_controller!.value.isInitialized) {
      return;
    }

    await _controller!.startVideoRecording();
    await videoController?.dispose();
    setState(() {
      videoController = null;
    });
    _startRecordingTimer();
  }

  Future<void> _stopRecording() async {
    if (!_controller!.value.isRecordingVideo) {
      return;
    }
    _controller?.stopVideoRecording().then((XFile? file) {
      if (mounted) {
        setState(() {});
      }
      if (file != null) {
        setState(() {
          videoPath = file.path;
        });
        _startVideoPlayer();
      }
      setState(() {
        _isRecording = false;
        _timerValue = 20;
      });
      _timer?.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Style.Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Style.Colors.primary),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SizedBox.expand(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
              child: Image.asset("assets/icons/selfie.png"),
            ),
            const Center(
              child: Text("یک فایل ویدئویی با خواندن متن زیر ارسال نمایید",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(
              height: 10,
            ),
            const Center(
              child:
                  Text("(اینحانب..... تمامی مدارک ارسالی را تائید می‌نمایم)"),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: 200,
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(
                    color: Style.Colors.primary, style: BorderStyle.solid),
              ),
              child: Stack(
                children: [
                  FutureBuilder<void>(
                    future: _initializeControllerFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          _controller != null) {
                        return CameraPreview(_controller!);
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                  videoController != null
                      ? Container(
                          width: 200,
                          height: 300,
                          decoration: BoxDecoration(
                              border: Border.all(color: Style.Colors.primary)),
                          child: Center(
                            child: AspectRatio(
                                aspectRatio: videoController!.value.size != null
                                    ? videoController!.value.aspectRatio
                                    : 1.0,
                                child: VideoPlayer(videoController!)),
                          ),
                        )
                      : const SizedBox.shrink(),
                  _isRecording
                      ? const Positioned(
                          left: 10, top: 5, child: RecordingIcon())
                      : const SizedBox.shrink(),
                ],
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                _isRecording ? _stopRecording() : _startRecording();
              },
              child: Container(
                width: _isRecording ? 60 : 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(_isRecording ? 10 : 30),
                  color:
                      _isRecording ? Style.Colors.fail : Style.Colors.primary,
                ),
                child: _isRecording
                    ? Center(
                        child: Text(
                          '$_timerValue',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : const Icon(Icons.video_camera_front,
                        color: Colors.white, size: 30),
              ),
            ),
            videoController != null 
                ? Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              uploadMP4Video();
                            },
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    _isRecording ? 10 : 30),
                                color: Style.Colors.success,
                              ),
                              child: uploadProgress > 0
                                  ? Center(
                                      child: CircularProgressIndicator(
                                         value: uploadProgress,
                                        color: Style.Colors.white, //<-- SEE HERE
                                        backgroundColor:Style.Colors.success, 
                                          ),
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(Icons.arrow_upward,
                                            color: Colors.white, size: 30),
                                        Text(
                                          "ارسال",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Style.Colors.white),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                        ]),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  void _startRecordingTimer() {
    if (!_isRecording) {
      setState(() {
        _isRecording = true;
      });

      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        print(9);
        if (_timerValue > 0) {
          setState(() {
            _timerValue--;
          });
        }
      });
    } else {
      setState(() {
        _isRecording = false;
        _timerValue = 20;
      });
    }
  }

  Future<void> _startVideoPlayer() async {
    if (videoPath == null) {
      return;
    }

    final VideoPlayerController vController =
        VideoPlayerController.file(File(videoPath!));

    videoPlayerListener = () {
      if (videoController != null && videoController!.value.size != null) {
        // Refreshing the state to update video player with the correct ratio.
        if (mounted) {
          setState(() {});
        }
        videoController!.removeListener(videoPlayerListener!);
      }
    };
    vController.addListener(videoPlayerListener!);
    await vController.setLooping(false);
    await vController.initialize();
    await videoController?.dispose();
    if (mounted) {
      setState(() {
        videoController = vController;
      });
    }
    await vController.play();
  }

  Future<void> uploadMP4Video() async {
    try {
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(videoPath!, filename: "fileName"),
      });

      final Dio _dio = DioSingleton.dio;
      Response response = await _dio.post(
        '/users/upload-selfie-video',
        data: formData,
        onSendProgress: (int sent, int total) {
          double progress = sent / total;
          setState(() {
            uploadProgress = progress;
          });
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data);
        if (response.data["status"] == true) {
          setState(() {
            uploadProgress = 1;
          });
          if (!mounted) {
            return;
          }
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("ویدئو با موفقیت اپدیت شد",
                  style: TextStyle(color: Style.Colors.gray2)),
              backgroundColor: Style.Colors.success,
            ),
          );
          Navigator.pushReplacementNamed(context, "/register");
        } else {
          setState(() {
            uploadProgress = 0;
          });
        }
      } else {
        setState(() {
            uploadProgress = 0;
          });
      }
    } catch (e) {
      setState(() {
        uploadProgress = 0;
      });
    }
  }
}
