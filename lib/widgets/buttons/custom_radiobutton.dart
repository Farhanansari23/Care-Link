import 'package:flutter/material.dart';
import '../colors/custom_colors.dart';
import '../text/custom_text.dart';

class CustomRadioButton extends StatelessWidget {
  const CustomRadioButton({
    super.key,
    required this.radioGroupValue,
    required this.radioValue,
    required this.radioTitle,
    required this.onChange,
    this.showTrailingWidget = false,
    this.trailingWidgetTitle = '0',
  });

  final String radioGroupValue;
  final String radioValue;
  final String radioTitle;
  final Function(String? value) onChange;
  final bool showTrailingWidget;
  final String trailingWidgetTitle;

  @override
  Widget build(BuildContext context) {
    return RadioMenuButton(
      value: radioValue,
      groupValue: radioGroupValue,
      onChanged: onChange,
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        elevation: WidgetStatePropertyAll(2),
        backgroundColor: WidgetStatePropertyAll(Colors.white),
        overlayColor: WidgetStatePropertyAll(
            CustomColors.primaryColor.withOpacity(0.3)), // Active overlay color
        foregroundColor: WidgetStatePropertyAll(
            CustomColors.primaryColor), // Active icon color
      ),
      child: CustomText(
        text: radioTitle,
        fontWeight: FontWeight.w500,
      ),
      trailingIcon: showTrailingWidget
          ? CustomText(
        text: trailingWidgetTitle,
        fontWeight: FontWeight.w500,
      )
          : null,
    );
  }
}
