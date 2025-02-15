import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import '../theme/app_palette.dart';
import '../utils/show_snackbar.dart';

class AudioRecorderWidget extends StatefulWidget {
  const AudioRecorderWidget(
      {super.key, required this.onRecordingComplete, required this.height});

  final Function(String?) onRecordingComplete;
  final double height;

  @override
  State<AudioRecorderWidget> createState() => _AudioRecorderWidgetState();
}

class _AudioRecorderWidgetState extends State<AudioRecorderWidget>
    with SingleTickerProviderStateMixin {
  final AudioRecorder audioRecorder = AudioRecorder();
  bool isRecording = false;
  String? recordingPath;
  bool isPlaying = false;

  final AudioPlayer audioPlayer = AudioPlayer();
  late AnimationController _controller;

  Future<void> reset() async {
    if (isRecording) {
      String? filepath = await audioRecorder.stop();
    }
    if (audioPlayer.playing) {
      await audioPlayer.stop();
    }
    setState(() {
      isRecording = false;
      isPlaying = false;
      recordingPath = null;
      _controller.reset();
    });
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2), // Duration of one full ripple
    )..repeat();
    // _controller.stop();
    _controller.reset();
    super.initState();
  }

  Future<void> _playPause() async {
    if (recordingPath == null) {
      showSnackBar(context, "Record audio first");
      return;
    }

    // Check if already playing
    if (isPlaying) {
      setState(() {
        isPlaying = false;
      });
      await audioPlayer.pause();
    } else {
      setState(() {
        isPlaying = true;
      });
      await audioPlayer.setFilePath(recordingPath!);
      await audioPlayer.play();

      // Ensure there's only one active listener
      audioPlayer.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed) {
          setState(() {
            isPlaying = false; // Stop playback after completion
          });
        }
      });
    }
  }

  Future<void> _recordPause() async {
    if (isRecording) {
      String? filepath = await audioRecorder.stop();
      if (filepath != null) {
        setState(() {
          isRecording = false;
          _controller.reset();
          recordingPath = filepath;
        });
        // debugPrint(recordingPath);
        widget.onRecordingComplete(recordingPath);
      }
    } else {
      if (await audioRecorder.hasPermission()) {
        final Directory appDocumentsDir = await getApplicationCacheDirectory();
        final String filePath = p.join(appDocumentsDir.path, "recording.wav");
        await audioRecorder.start(RecordConfig(), path: filePath);
        setState(() {
          isRecording = true;
          _controller.repeat();
          recordingPath = null;
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        for (int i = 0; i < 2; i++)
          SizedBox(
            height: widget.height,
            width: double.infinity,
            child: Center(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  double progress = (_controller.value + (i * 0.3)) % 1.0;
                  double scale = progress * 2.5; // Start from small to big
                  return Opacity(
                    opacity: (1 - progress).clamp(0.0, 1.0),
                    // Fade effect
                    child: Container(
                      width: 100 * scale,
                      height: 100 * scale,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppPalette.primaryColor,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        SizedBox(
          height: widget.height,
          width: double.infinity,
          child: Row(
            children: [
              Spacer(),
              ElevatedButton(
                onPressed: _playPause,
                style: ElevatedButton.styleFrom(
                    shape: CircleBorder(
                      side: BorderSide(
                          color: AppPalette.blackColor,
                          width: 1), // Black border
                    ),
                    elevation: 0,
                    backgroundColor: Colors.white,
                    foregroundColor: AppPalette.primaryColor // Icon color
                    ),
                child: SvgPicture.asset('assets/section/headphone.svg'),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: _recordPause,
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  elevation: 0,
                  backgroundColor: AppPalette.primaryColor,
                  foregroundColor: AppPalette.blackColor, // Icon color
                ),
                child: SizedBox(
                  height: 80,
                  width: 80,
                  child: isRecording
                      ? Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: SvgPicture.asset(
                            'assets/section/stop_rec.svg',
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: SvgPicture.asset(
                            'assets/section/mic.svg',
                          ),
                        ),
                ),
              ),
              Spacer(),
              ElevatedButton(
                  onPressed: reset,
                  style: ElevatedButton.styleFrom(
                      shape: CircleBorder(
                        side: BorderSide(
                            color: AppPalette.blackColor,
                            width: 1), // Black border
                      ),
                      elevation: 0,
                      backgroundColor: AppPalette.white,
                      foregroundColor: AppPalette.primaryColor // Icon color
                      ),
                  child: SvgPicture.asset(
                    'assets/section/retry.svg',
                  )),
              Spacer(),
            ],
          ),
        ),
      ],
    );
  }
}
