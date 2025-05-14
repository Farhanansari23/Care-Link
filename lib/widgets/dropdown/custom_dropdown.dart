import 'package:flutter/material.dart';
import '../colors/custom_colors.dart';
import '../text/custom_text.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown({
    super.key,
    required this.labelText,
    required this.items,
    required this.value,
    required this.onChanged,
    this.color,
    this.withPrefixIcon = false,
    this.applyCountryFlag = false,
  });

  final Color? color;
  final String labelText;
  final String value;
  final List<String> items;
  final Function(String?) onChanged;
  final bool withPrefixIcon;
  final bool applyCountryFlag;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: color ?? CustomColors.primaryWhite,
      child: DropdownButtonFormField(
        value: value,
        isExpanded: true,
        dropdownColor: Colors.white,
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: withPrefixIcon
                ? Row(
              mainAxisSize: MainAxisSize.min, // Prevent expanding
              children: [
                SizedBox(
                  height: 28,
                  width: 28,
                  child: Image.asset(
                    item == '+977'
                        ? 'assets/flag_img/nepal.png'
                        : 'assets/flag_img/india.png',
                    fit: BoxFit.scaleDown,
                  ),
                ),
                const SizedBox(width: 4),
                CustomText(
                  text: item,
                  maxLines: 1,
                  textOverflow: TextOverflow.ellipsis,
                ),
              ],
            )
                : applyCountryFlag
                ? Row(
              mainAxisSize: MainAxisSize.min, // Prevent expanding
              children: [
                SizedBox(
                  height: 28,
                  width: 28,
                  child: Image.asset(
                    item == 'Nepal' || item == 'Nepali'
                        ? 'assets/flag_img/nepal.png'
                        : 'assets/flag_img/india.png',
                    fit: BoxFit.scaleDown,
                  ),
                ),
                const SizedBox(width: 4),
                CustomText(
                  text: item,
                  maxLines: 1,
                  textOverflow: TextOverflow.ellipsis,
                ),
              ],
            )
                : CustomText(
              text: item,
              maxLines: 1,
              textOverflow: TextOverflow.ellipsis,
            ),
          );
        }).toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          fillColor: CustomColors.primaryWhite,
          focusColor: CustomColors.primaryWhite,
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
