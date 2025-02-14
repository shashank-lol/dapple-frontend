import 'dart:io';

import 'package:dapple/core/utils/show_snackbar.dart';
import 'package:dapple/features/question/presentation/widgets/questions_template_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import '../../../../core/theme/app_palette.dart';
import '../widgets/overlay_screens/loading.dart';
import '../widgets/question_template_screen.dart';

class AudioQuestionScreen extends StatefulWidget {
  const AudioQuestionScreen({super.key});

  @override
  State<AudioQuestionScreen> createState() => _AudioQuestionScreenState();
}

class _AudioQuestionScreenState extends State<AudioQuestionScreen>
    with SingleTickerProviderStateMixin {
  final AudioRecorder audioRecorder = AudioRecorder();
  bool isRecording = false;
  String? recordingpath;
  bool isPlaying = false;

  final AudioPlayer audioPlayer = AudioPlayer();

  late AnimationController _controller;
  bool _showOverlay = false;

  void _receivedResponse(context) {
    setState(() {
      _showOverlay = true;
    });

    // Wait for 5 seconds, then navigate to the next page
    Future.delayed(Duration(seconds: 1), () {
      if (_showOverlay == true) {}
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
      recordingpath = null;
      _controller.reset();
    });
  }

  Future<void> _playPause() async {
    if (recordingpath == null) {
      showSnackBar(context, "Record audio first");
    }
    await audioPlayer.setFilePath(recordingpath!);
    audioPlayer.play();
    setState(() {
      isPlaying = true;
    });
  }

  Future<void> _recordPause() async {
    if (isRecording) {
      String? filepath = await audioRecorder.stop();
      if (filepath != null) {
        setState(() {
          isRecording = false;
          _controller.reset();
          recordingpath = filepath;
        });
      }
    } else {
      if (await audioRecorder.hasPermission()) {
        final Directory appDocumentsDir = await getApplicationCacheDirectory();
        final String filePath = p.join(appDocumentsDir.path, "recording.wav");
        await audioRecorder.start(RecordConfig(), path: filePath);
        setState(() {
          isRecording = true;
          _controller.repeat();
          recordingpath = null;
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
        QuestionTemplateScreen(
          buttonText: "Answer",
          widgetTop: Padding(
            padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
            child: Text(
              textAlign: TextAlign.center,
              'Write the best response for a colleague asking about your weekend.',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppPalette.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ),
          widgetBottom: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QuestionsTemplateHeader(title: 'Speak answer', action: () {}),
              Stack(
                children: [
                  for (int i = 0; i < 2; i++)
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 2 / 5,
                      width: double.infinity,
                      child: Center(
                        child: AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            double progress =
                                (_controller.value + (i * 0.3)) % 1.0;
                            double scale =
                                progress * 2.5; // Start from small to big
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
                    height: MediaQuery.of(context).size.height * 2 / 5,
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
                              foregroundColor:
                                  AppPalette.primaryColor // Icon color
                              ),
                          child:
                              SvgPicture.asset('assets/section/headphone.svg'),
                        ),
                        Spacer(),
                        ElevatedButton(
                          onPressed: _recordPause,
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            elevation: 0,
                            backgroundColor: AppPalette.primaryColor,
                            foregroundColor:
                                AppPalette.blackColor, // Icon color
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
                                foregroundColor:
                                    AppPalette.primaryColor // Icon color
                                ),
                            child: SvgPicture.asset(
                              'assets/section/retry.svg',
                            )),
                        Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          onTap: () {
            _receivedResponse(context);
          },
          resizeToAvoidBottomInset: false,
        ),
        if (_showOverlay)
          GestureDetector(
              onTap: () {
                setState(() {});
              },
              child: LoadingOverlay(showOverlay: _showOverlay))
      ],
    );
  }
}
