import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_palette.dart';

class OptionsTile extends StatelessWidget {
  const OptionsTile({super.key, required this.iconUrl, required this.title});

  final String iconUrl ;
  final String title;



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: AppPalette.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              SvgPicture.asset(
                iconUrl,
                height: 30,
                colorFilter: ColorFilter.mode(AppPalette.primaryColor,
                    BlendMode.srcIn), // You can adjust the size
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                title,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.rubik(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppPalette.blackColor,
                    letterSpacing: 0),
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                color: AppPalette.primaryColor,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
