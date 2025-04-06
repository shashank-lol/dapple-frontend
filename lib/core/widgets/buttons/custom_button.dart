import 'package:flutter/material.dart';
import '../../theme/app_palette.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onTap,
    required this.buttonText,
    this.child,
  });

  final void Function() onTap;
  final String buttonText;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(backgroundColor: AppPalette.primaryColor),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Center(
            child: child ??
                Text(
                  buttonText.toUpperCase(),
                  style: Theme.of(
                    context,
                  ).textTheme.labelMedium!.copyWith(color: Colors.white),
                ),
          ),
        ),
      ),
    );
  }
}
