import 'dart:convert';
import 'package:dapple/core/theme/app_palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class AITalkHome extends StatefulWidget {
  const AITalkHome({super.key});

  @override
  State<AITalkHome> createState() => _AITalkHomeState();
}

class _AITalkHomeState extends State<AITalkHome> {
  bool isPaused = true;
  final String phoneNumber = "+918262958707";
  final String API_BASE_URL = 'http://65.0.97.51:5120';

  Future<void> makeCall(String phoneNumber) async {
    final String url = '$API_BASE_URL/api/call';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'to_number': phoneNumber}),
      );

      if (response.statusCode == 200) {
        print('Call initiated successfully: ${response.body}');
      } else {
        print('Failed to make call: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error making call: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.blackColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Center(
            child: Text(
              "Call Dapple",
              style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  color: AppPalette.white),
            ),
          ),
          Image.asset(
            "assets/dapple-girl/hi.png",
            height: 300,
          ),
          Spacer(),
          GestureDetector(
            onTap: () async {
              await makeCall(phoneNumber);
            },
            child: Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.phone,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
