import 'package:dapple/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class BackButtonHandler extends StatelessWidget {
  const BackButtonHandler({super.key, required this.child});

  final Widget child;

  Future<bool?> _showBackDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppPalette.white,
          title: Text(
            textAlign: TextAlign.center,
            'Are you sure?',
            style: TextStyle(
              color: AppPalette.blackColor,
            ),
          ),
          content: const Text(
            'Are you sure you want to leave this page?',
            style: TextStyle(color: AppPalette.blackColor),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Nevermind'),
              onPressed: () => Navigator.pop(context, false),
            ),
            TextButton(
              child: const Text('Leave'),
              onPressed: () => Navigator.pop(context, true),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) return;
        final bool shouldPop = await _showBackDialog(context) ?? false;
        if (context.mounted && shouldPop) {
          Navigator.pop(context);
        }
      },
      child: child,
    );
  }
}
