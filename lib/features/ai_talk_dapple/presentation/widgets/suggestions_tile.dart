import 'package:dapple/core/theme/app_palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SuggestionsTile extends StatelessWidget {
  const SuggestionsTile(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.description});

  final String imageUrl;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          color: AppPalette.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                title,
                style: GoogleFonts.inter(
                    color: Color(0xE6000000),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    height: 1.5),
              ),
              Text(
                description,
                style: GoogleFonts.inter(
                    color: Color(0xE6000000),
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                    letterSpacing: 0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
