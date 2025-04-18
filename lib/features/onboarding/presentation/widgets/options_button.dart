import 'package:dapple/core/theme/app_palette.dart';
import 'package:dapple/features/onboarding/presentation/bloc/option/option_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class OptionsButton extends StatefulWidget {
  const OptionsButton(
      {super.key,
      required this.optionText,
      this.icon,
      required this.questionIndex,
      required this.optionIndex,
      required this.maxSelection,
      this.isCorrect});

  final String optionText;
  final IconData? icon;
  final int questionIndex;
  final int optionIndex;
  final int maxSelection;
  final bool? isCorrect;

  @override
  State<OptionsButton> createState() => _OptionsButtonState();
}

class _OptionsButtonState extends State<OptionsButton> {
  Color? color;

  @override
  Widget build(BuildContext context) {
    if (widget.isCorrect != null) {
      widget.isCorrect!
          ? color = Color(0xFF1DFF5D).withValues(alpha: 0.4)
          : color = Color(0xFFFF1D1D).withValues(alpha: 0.4);
    }
    final optionBloc = BlocProvider.of<OptionBloc>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: BlocBuilder<OptionBloc, OptionState>(builder: (context, state) {
        final isSelected = state.selectedOptions[widget.questionIndex]
            .contains(widget.optionIndex);
        return ElevatedButton.icon(
          onPressed: () {
            optionBloc.add(
              SelectOption(
                questionIndex: widget.questionIndex,
                optionIndex: widget.optionIndex,
                maxSelection: widget.maxSelection,
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 60),
            foregroundColor: !isSelected
                ? AppPalette.primaryColor.withValues(alpha: 0.2)
                : Colors.white,
            backgroundColor: isSelected
                ? (color ?? AppPalette.primaryColor.withValues(alpha: 0.2))
                : (widget.isCorrect != null && widget.isCorrect!)
                    ? color
                    : Colors.white,
            shape: ContinuousRectangleBorder(
              side: BorderSide(
                color: AppPalette.primaryColor.withValues(alpha: 0.2),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            shadowColor: Colors.transparent,
            alignment: Alignment.centerLeft,
          ),
          icon: Icon(widget.icon),
          label: Text(
            widget.optionText,
            style: GoogleFonts.rubik(
              color: AppPalette.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        );
      }),
    );
  }
}
