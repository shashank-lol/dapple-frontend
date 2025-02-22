import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../../../../core/theme/app_palette.dart';

class SpeechToTextWidget extends StatefulWidget {
  const SpeechToTextWidget({super.key, required this.onTextChanged});

  final Function(String) onTextChanged;

  @override
  State<SpeechToTextWidget> createState() => _SpeechToTextWidgetState();
}

class _SpeechToTextWidgetState extends State<SpeechToTextWidget> with SingleTickerProviderStateMixin{
  final stt.SpeechToText _speechToText = stt.SpeechToText();
  bool _isListening = false;
  String _transcribedText = "";

  late AnimationController _controller;


  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2), // Duration of one full ripple
    )..repeat();
    // _controller.stop();
    _controller.reset();
    super.initState();
    _initializeSpeech();
  }

  /// Initialize Speech-to-Text
  Future<void> _initializeSpeech() async {
    bool available = await _speechToText.initialize(
      options: [
      ],
      onStatus: (status) {
        if (status == "notListening" || status == "done") {
          _isListening = false;
          _controller.reset();
          setState(() {});
        }
      },
      onError: (error) {
        debugPrint("Speech Error: $error");
        _isListening = false;
        setState(() {});
      },
    );

    if (!available) {
      debugPrint("Speech recognition not available.");
    }
  }

  /// Request microphone permission
  Future<bool> _requestPermission() async {
    var status = await Permission.microphone.request();
    return status.isGranted;
  }

  @override
  void dispose() {
    _speechToText.stop();
    _speechToText.cancel();
    _controller.dispose();
    super.dispose();
  }

  /// Start or Stop Speech Recognition
  void _toggleListening() async {
    if (!_isListening) {
      if (!await _requestPermission()) {
        debugPrint("Microphone permission not granted.");
        return;
      }
      _controller.repeat();

      setState(() => _isListening = true);

      _speechToText.listen(
        onResult: (result) {
          if (result.finalResult && mounted) {
            // ✅ Append only finalized results
            setState(() {
              _transcribedText += " ${result.recognizedWords}";
              widget.onTextChanged(_transcribedText);
            });
            setState(() => _isListening = _speechToText.isListening);
            _controller.reset();
          }
        },
        listenFor: const Duration(seconds: 60),
        // Auto-stop after 60s
        pauseFor: const Duration(seconds: 6),
        // Stops when silent
        localeId: "en_US",
        onSoundLevelChange: (level) {},
      );
    } else {
      _stopListening();
      _controller.reset();
    }
  }

  /// Stop Listening
  void _stopListening() {
    _speechToText.stop();
    if (mounted) {
      setState(() => _isListening = false);
    }
  }

  /// Reset Transcribed Text
  void _resetText() {
    setState(() {
      _transcribedText = "Tap the mic to start speaking";
      widget.onTextChanged("");
      _controller.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        children: [
          for (int i = 0; i < 2; i++)
            SizedBox(
              height: 130,
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
                          color: AppPalette.secondaryColor,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          SizedBox(
            height: 130,
            width: double.infinity,
            child: Row(
              children: [
                Spacer(),
                ElevatedButton(
                  onPressed: _resetText,
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
                  child: SvgPicture.asset('assets/section/retry.svg'),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: _toggleListening,
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    elevation: 0,
                    backgroundColor: AppPalette.secondaryColor,
                    foregroundColor: AppPalette.blackColor, // Icon color
                  ),
                  child: SizedBox(
                    height: 80,
                    width: 80,
                    child: _isListening
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
                    onPressed: _resetText,
                    style: ElevatedButton.styleFrom(
                        shape: CircleBorder(
                          side: BorderSide(
                              color: AppPalette.blackColor,
                              width: 1), // Black border
                        ),
                        elevation: 0,
                        backgroundColor: AppPalette.white,
                        foregroundColor: AppPalette.secondaryColor // Icon color
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
    );
  }
}
