import 'package:dapple/core/cubits/app_user/app_user_cubit.dart';
import 'package:dapple/features/profile/presentation/widgets/contact_tile.dart';
import 'package:dapple/features/profile/presentation/widgets/options_tile.dart';
import 'package:encrypt_shared_preferences/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_palette.dart';
import '../../../../core/widgets/indicators/xp_indicator_orange.dart';
import '../../../../core/widgets/text/custom_text_rubik.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // return ElevatedButton(onPressed: (){
    //
    // }, child: Text("Log Out"));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppPalette.transparent,
        title: Row(
          children: [
            Spacer(),
            Center(
              child: CustomTextRubik(
                  text: "My Profile",
                  weight: FontWeight.w600,
                  size: 20,
                  color: AppPalette.blackColor),
            ),
            Spacer(),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  "assets/avatar/1.svg",
                  height: 100,
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ContactTile(
                        iconUrl: "assets/profile_page_icons/profile.svg",
                        contact: "Parth Revanwar"),
                    ContactTile(
                        iconUrl: "assets/profile_page_icons/email.svg",
                        contact: "parthrevanwar@gmail.com"),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                  color: AppPalette.primaryColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Spacer(),
                  Image.asset(
                    'assets/icons/xp.png',
                    height: 30,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  CustomTextRubik(
                      text: "100 XP",
                      weight: FontWeight.w700,
                      size: 16,
                      color: AppPalette.secondaryColor),
                  Spacer(),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Options",
              style: GoogleFonts.inter(
                  color: AppPalette.blackColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  height: 1.4),
            ),
            SizedBox(
              height: 10,
            ),
            OptionsTile(
              iconUrl: "assets/profile_page_icons/purchase.svg",
              title: 'Purchases / Subscription',
            ),
            OptionsTile(
              iconUrl: "assets/profile_page_icons/language.svg",
              title: 'Language',
            ),
            OptionsTile(
              iconUrl: "assets/profile_page_icons/edit_profile.svg",
              title: 'Edit Profile',
            ),
            OptionsTile(
              iconUrl: "assets/profile_page_icons/refer_earn.svg",
              title: 'Refer and Earn',
            ),
            OptionsTile(
              iconUrl: "assets/profile_page_icons/help.svg",
              title: 'Help & Support',
            ),
            GestureDetector(
              onTap: () {
                // Log out
                EncryptedSharedPreferences.getInstance().remove("token");
                final authCubit =
                    BlocProvider.of<AppUserCubit>(context).updateUser(null);
              },
              child: Padding(
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
                          "assets/profile_page_icons/logout.svg",
                          height: 30,
                          colorFilter: ColorFilter.mode(AppPalette.primaryColor,
                              BlendMode.srcIn), // You can adjust the size
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Log Out',
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.rubik(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppPalette.primaryColor,
                              letterSpacing: 0),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
