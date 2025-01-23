import 'package:dapple/core/theme/app_palette.dart';
import 'package:dapple/features/onboarding/presentation/bloc/option/option_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class OptionsButton extends StatefulWidget {
  const OptionsButton({
    super.key,
    required this.optionText,
    this.icon,
    required this.questionIndex,
    required this.optionIndex, required this.maxSelection,
  });

  final String optionText;
  final IconData? icon;
  final int questionIndex;
  final int optionIndex;
  final int maxSelection;

  @override
  State<OptionsButton> createState() => _OptionsButtonState();
}

class _OptionsButtonState extends State<OptionsButton> {
  @override
  Widget build(BuildContext context) {
    final optionBloc = BlocProvider.of<OptionBloc>(context);
    bool isSelected = optionBloc.state.selectedOptions[widget.questionIndex]
        .contains(widget.optionIndex);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: ElevatedButton.icon(
        onPressed: () {
          if(optionBloc.state.selectedOptions[widget.questionIndex].length >= widget.maxSelection && !isSelected){
            return;
          }
          if(!isSelected){
            optionBloc.add(
              SelectOption(
                questionIndex: widget.questionIndex,
                optionIndex: widget.optionIndex,
              ),
            );
          } else {
            optionBloc.add(
              UnSelectOption(
                questionIndex: widget.questionIndex,
                optionIndex: widget.optionIndex,
              ),
            );
          }
          setState(() {
            isSelected = !isSelected;
          });
        },
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 60),
          foregroundColor:
              !isSelected
                  ? AppPalette.primaryColor.withValues(alpha: 0.2)
                  : Colors.white,
          backgroundColor:
              isSelected
                  ? AppPalette.primaryColor.withValues(alpha: 0.2)
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
          style: GoogleFonts.montserrat(
            color: AppPalette.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
