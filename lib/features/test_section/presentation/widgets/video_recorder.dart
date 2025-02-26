import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:dapple/core/theme/app_palette.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'dart:math';

import 'package:speech_to_text/speech_to_text.dart';

class VideoRecorder extends StatefulWidget {
  const VideoRecorder({super.key, required this.onDataReceived});
  final Function(String,String) onDataReceived;

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

  void _toggleCapture() {
    if (isCapturing) {
      _stopCapture();
      _stopListening();
      widget.onDataReceived(_lastWords+" "+_currentWords,_photoDir!.path);
      _currentWords="";
      _lastWords="";
      // print("$_lastWords $_currentWords");
    } else {
      _startCapture();
      _startListening();
    }
  }

  void _startCapture() {
    setState(() => isCapturing = true);
    _timer = Timer.periodic(Duration(seconds: 1), (timer) => _takePhoto());
  }

  void _stopCapture() {
    setState(() => isCapturing = false);
    _timer?.cancel();
    _loadCapturedPhotos();
  }

  Future<void> _takePhoto() async {
    if (_cameraController != null && _cameraController!.value.isInitialized) {
      final file = await _cameraController!.takePicture();
      final path =
          "${_photoDir!.path}/${DateTime.now().millisecondsSinceEpoch}.jpg";
      await file.saveTo(path);
      setState(() {
        capturedPhotos.add(File(path));
      });
    }
  }

  Future<void> _retry() async {
    print(_lastWords);
    final dir = Directory(_photoDir!.path);
    for (var file in dir
        .listSync()
        .whereType<File>()
        .where((file) => file.path.endsWith('.jpg'))) {
      file.deleteSync();
    }
    setState(() {
      capturedPhotos.clear();
    });

    if (isCapturing) {
      _stopCapture();
      _stopListening();
      widget.onDataReceived(_lastWords+" "+_currentWords,_photoDir!.path);
      _currentWords="";
      _lastWords="";
      // print("$_lastWords $_currentWords");
    }
  }

  Future<void> _loadCapturedPhotos() async {
    final dir = Directory(_photoDir!.path);
    List<File> photos = dir
        .listSync()
        .where((file) => file.path.endsWith(".jpg"))
        .map((file) => File(file.path))
        .toList();
    setState(() {
      capturedPhotos = photos;
    });
  }

  //speech to text logic

  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  bool _speechAvailable = false;
  String _lastWords = '';
  String _currentWords = '';

  void errorListener(SpeechRecognitionError error)async {
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
    double width=MediaQuery.of(context).size.width - 48;
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
                          size:  Size(width, width*4/3), // aspect is 1:1
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
                                  aspectRatio: 4/3,
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
              if (!isCapturing && capturedPhotos.isNotEmpty)
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0,
                    ),
                    itemCount: capturedPhotos.length,
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(capturedPhotos[index],
                            fit: BoxFit.cover),
                      );
                    },
                  ),
                ),
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
                      child: ElevatedButton(
                        onPressed: _toggleCapture,
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
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _retry,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppPalette.secondaryColor,
                            padding: EdgeInsets.symmetric(vertical: 14)),
                        child: Text(
                          "Retry".toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(color: AppPalette.white),
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
