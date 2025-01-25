import 'package:dapple/core/theme/app_palette.dart';
import 'package:dapple/core/widgets/custom_button.dart';
import 'package:dapple/core/widgets/custom_textfield.dart';
import 'package:dapple/features/auth/presentation/widgets/google_button.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  AuthPage({super.key, required this.isNewUser});

  bool isNewUser;

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  int ct=0;
  @override
  Widget build(BuildContext context) {
    final String heading = widget.isNewUser ? "Create Account" : "Welcome Back";
    final String buttonText = widget.isNewUser ? "Sign Up" : "Log in";
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: BackButton(
          onPressed: () {
            if(ct>0){
              setState(() {
              widget.isNewUser = !widget.isNewUser;
              --ct;
              });
              return;
            }
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset("assets/auth-bg.png", height: deviceHeight),
            SafeArea(
              minimum: EdgeInsets.symmetric(horizontal: 18),
              child: Form(
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Column(
                    children: [
                      Text(
                        heading,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      // SizedBox(height: 20),
                      Image.asset(
                        "assets/dapple-girl/sitting.png",
                        height: deviceHeight / 5,
                      ),
                      Visibility(
                        visible: widget.isNewUser,
                        child: Column(
                          children: [
                            CustomTextField(hintText: "First Name"),
                            SizedBox(height: 12),
                            CustomTextField(hintText: "Last Name"),
                            SizedBox(height: 12),
                          ],
                        ),
                      ),
                      CustomTextField(hintText: "Email", keyboardType: TextInputType.emailAddress,),
                      SizedBox(height: 12),
                      CustomTextField(hintText: "Password"),
                      SizedBox(height: 36),
                      CustomButton(onTap: () {}, buttonText: buttonText,),
                      SizedBox(height: 12),
                      GoogleButton(),
                      Visibility(
                        visible: widget.isNewUser,
                        child: Column(
                          children: [
                            SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Already have an account? ",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.labelSmall!.copyWith(
                                    color: AppPalette.blackColor,
                                    fontSize: 12,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      ct++;
                                      widget.isNewUser = !widget.isNewUser;
                                    });
                                  },
                                  child: Text(
                                    "LogIn".toUpperCase(),
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
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
