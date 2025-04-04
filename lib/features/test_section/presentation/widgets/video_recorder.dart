import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:dapple/core/theme/app_palette.dart';
import 'package:dapple/features/test_section/presentation/bloc/socket/socket_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'dart:math';

import 'package:speech_to_text/speech_to_text.dart';

class VideoRecorder extends StatefulWidget {
  VideoRecorder(
      {super.key,
      required this.onDataReceived,
      required this.questionId,
      required this.sessionId,
      this.reload = false,
      required this.child});

  final Function(String) onDataReceived;
  final String questionId;
  final String sessionId;
  bool reload;
  final Widget child;

  @override
  State<VideoRecorder> createState() => _VideoRecorderState();
}

class _VideoRecorderState extends State<VideoRecorder> {
  //recording logic

  CameraController? _cameraController;
  List<CameraDescription>? cameras;
  bool isCapturing = false;
  Timer? _timer;
  Directory? _photoDir;
  List<File> capturedPhotos = [];

  Future<void> _initCamera() async {
    cameras = await availableCameras();
    if (cameras != null && cameras!.isNotEmpty) {
      _cameraController = CameraController(
        cameras!.firstWhere(
            (cam) => cam.lensDirection == CameraLensDirection.front),
        ResolutionPreset.high,
        enableAudio: false,
      );
      await _cameraController!.initialize();
      if (mounted) {
        setState(() {});
      }
    }
    _photoDir = await getApplicationDocumentsDirectory();
  }

  String _answer = "";

  void _toggleCapture(String questionId, String sessionId) {
    if (isCapturing) {
      _stopCapture();
      _stopListening();
      setState(() {
        _answer = "$_lastWords $_currentWords";
      });
      widget.onDataReceived(_answer);
      setState(() {
        _currentWords = "";
        _lastWords = "";
      });
      // print("$_lastWords $_currentWords");
    } else {
      _startCapture(questionId, sessionId);
      _startListening();
    }
  }

  void _startCapture(String questionId, String sessionId) {
    setState(() => isCapturing = true);
    _timer = Timer.periodic(Duration(seconds: 2), (timer) async {
      await _takePhoto().then((path) {
        if (path.isNotEmpty) {
          context
              .read<SocketBloc>()
              .add(SendImageEvent(File(path), questionId, sessionId));
        }
      });
    });
  }

  void _stopCapture() {
    setState(() => isCapturing = false);
    _timer?.cancel();
    // _loadCapturedPhotos();
  }

  Future<String> _takePhoto() async {
    if (_cameraController != null && _cameraController!.value.isInitialized) {
      final file = await _cameraController!.takePicture();
      final path =
          "${_photoDir!.path}/${DateTime.now().millisecondsSinceEpoch}.jpg";
      await file.saveTo(path);
      setState(() {
        capturedPhotos.add(File(path));
      });
      return path;
    } else {
      return "";
    }
  }

  Future<void> _retry() async {
    widget.reload = false;
    print(_lastWords);
    final dir = Directory(_photoDir!.path);
    for (var file in dir
        .listSync()
        .whereType<File>()
        .where((file) => file.path.endsWith('.jpg'))) {
      file.deleteSync();
    }
    Future.delayed(Duration.zero, () async {
      setState(() {
        capturedPhotos.clear();
        _lastWords = "";
        _currentWords = "";
        _answer = "";
      });
    });

    if (isCapturing) {
      _stopCapture();
      _stopListening();
      widget.onDataReceived(_lastWords + " " + _currentWords);
      _currentWords = "";
      _lastWords = "";
      // print("$_lastWords $_currentWords");
    }
  }

  // Future<void> _loadCapturedPhotos() async {
  //   final dir = Directory(_photoDir!.path);
  //   List<File> photos = dir
  //       .listSync()
  //       .where((file) => file.path.endsWith(".jpg"))
  //       .map((file) => File(file.path))
  //       .toList();
  //   setState(() {
  //     capturedPhotos = photos;
  //   });
  // }

  //speech to text logic

  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  bool _speechAvailable = false;
  String _lastWords = '';
  String _currentWords = '';

  void errorListener(SpeechRecognitionError error) async {
    debugPrint(error.errorMsg.toString());
    await _startListening();
  }

  void statusListener(String status) async {
    debugPrint("status $status");
    if (status == "done" && _speechEnabled) {
      setState(() {
        _lastWords += " $_currentWords";
        _currentWords = "";
        _speechEnabled = false;
      });
      await _startListening();
    }
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechAvailable = await _speechToText.initialize(
        onError: errorListener, onStatus: statusListener);
    setState(() {});
  }

  /// Each time to start a speech recognition session
  Future _startListening() async {
    debugPrint("=================================================");
    await _stopListening();
    await Future.delayed(const Duration(milliseconds: 50));
    await _speechToText.listen(
      onResult: _onSpeechResult,
      listenOptions: SpeechListenOptions(
          cancelOnError: false,
          partialResults: true,
          listenMode: ListenMode.dictation),
    );
    setState(() {
      _speechEnabled = true;
    });
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  Future _stopListening() async {
    setState(() {
      _speechEnabled = false;
    });
    await _speechToText.stop();
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _currentWords = result.recognizedWords;
    });
  }

  @override
  void initState() {
    super.initState();
    _initCamera();
    _initSpeech();
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.reload) {
      _retry();
    }
    double width = MediaQuery.of(context).size.width - 48;
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Stack(
        children: [
          Column(
            children: [
              if (isCapturing &&
                  _cameraController != null &&
                  _cameraController!.value.isInitialized)
                Expanded(
                  child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        // Rounded corners
                        color: Colors
                            .black, // Background color when preview is unavailable
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Center(
                          child: ClipRRect(
                        child: SizedOverflowBox(
                          size: Size(width, width * 4 / 3), // aspect is 1:1
                          alignment: Alignment.center,
                          child: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(pi),
                            child: Transform.scale(
                              scale: 1.4,
                              child: Transform.rotate(
                                angle: 3 * pi / 2,
                                // Rotate preview to portrait mode
                                child: AspectRatio(
                                  aspectRatio: 4 / 3,
                                  child: CameraPreview(_cameraController!),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ))
                      // Ensures content respects borderRadius
                      ),
                ),
              // else
              //   Container(
              //     height: MediaQuery.of(context).size.width - 48,
              //     width: double.infinity,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(20),
              //       color: Colors.black, // Black screen when not capturing
              //     ),
              //   ),
              if (!isCapturing) widget.child
            ],
          ),
          Column(
            children: [
              Spacer(),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Row(
                  children: [
                    Spacer(),
                    Expanded(
                      child: BlocBuilder<SocketBloc, SocketState>(
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed: () {
                              if (state is SocketConnected) {
                                _toggleCapture(
                                    widget.questionId, widget.sessionId);
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("Socket not connected"),
                                ));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppPalette.secondaryColor,
                                padding: EdgeInsets.symmetric(vertical: 14)),
                            child: Text(
                              isCapturing
                                  ? "Stop".toUpperCase()
                                  : "Start".toUpperCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(color: AppPalette.white),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<SocketBloc>().add(AnswerRetryEvent(
                              widget.questionId, widget.sessionId));
                          _retry();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppPalette.secondaryColor,
                            padding: EdgeInsets.symmetric(vertical: 14)),
                        child: BlocBuilder<SocketBloc, SocketState>(
                          builder: (context, state) {
                            if (state is SocketLoading) {
                              return SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: AppPalette.white,
                                ),
                              );
                            }
                            return Text(
                              "Retry".toUpperCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(color: AppPalette.white),
                            );
                          },
                        ),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
