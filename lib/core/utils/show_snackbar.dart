import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message, {double margin = 100}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(message),
        margin: EdgeInsets.symmetric(horizontal: 18, vertical: margin),
      ),
    );
}
