import 'package:flutter/material.dart';

import '../theme/app_palette.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({super.key, required this.hintText, this.keyboardType, required this.controller});

  final String hintText;
  final TextInputType? keyboardType;
  final TextEditingController controller;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    bool isPassword = widget.hintText == "Password";
    Widget icon = IconButton(
      onPressed: () {
        setState(() {
          isVisible = !isVisible;
        });
      },
      icon: !isVisible ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
    );
    return TextFormField(
      scrollPadding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 100,
      ),
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: isPassword ? icon : null,
      ),
      keyboardType: widget.keyboardType,
      style: Theme.of(
        context,
      ).textTheme.labelSmall!.copyWith(color: AppPalette.blackColor),
      obscureText: isPassword && !isVisible,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '${widget.hintText} cannot be empty';
        }
        return null;
      },
      controller: widget.controller,
    );
  }
}
