import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:vibration/vibration.dart';

class SoundManager {
  static final AudioPlayer _audioPlayer = AudioPlayer();

  /// Play success sound
  static Future<void> playSuccessSound() async {
    try {
      await _audioPlayer.setAsset('assets/sound_effects/success.mp3'); // Load sound
      _audioPlayer.play(); // Play sound
    } catch (e) {
      if (kDebugMode) {
        print("Error playing sound: $e");
      }
    }
  }

  /// Play success sound
  static Future<void> playFailureSound() async {
    try {
      await _audioPlayer.setAsset('assets/sound_effects/failure.mp3'); // Load sound
      _audioPlayer.play(); // Play sound
    } catch (e) {
      if (kDebugMode) {
        print("Error playing sound: $e");
      }
    }
  }

  /// Gradually increasing vibration
  static Future<void> vibrateGradually() async {
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(
          pattern: [0, 50, 100, 100, 150, 150, 200, 200, 250],
          intensities: [50, 80, 100, 120, 150]);
    }
  }

  /// Call both sound and vibration together
  static void playSuccessEffect() {
    playSuccessSound();
    vibrateGradually();
  }
}
