import 'package:flutter/material.dart';
import 'package:semester_project/widgets/container/custom_container.dart';
import '../colors/custom_colors.dart';
import '../text/custom_text.dart';

class CustomDropdown extends StatefulWidget {
  const CustomDropdown({
    super.key,
    required this.labelText,
    required this.items,
    required this.value,
    required this.onChanged,
    this.color,
    this.withPrefixIcon = false,
    this.applyCountryFlag = false,
    this.borderRadius = 16.0,
  });

  final Color? color;
  final String labelText;
  final String value;
  final List<String> items;
  final Function(String?) onChanged;
  final bool withPrefixIcon;
  final bool applyCountryFlag;
  final double borderRadius;

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.color ?? CustomColors.primaryWhite,
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: DropdownButtonFormField(
        value: widget.value,
        isExpanded: true,
        dropdownColor: Colors.white,
        items: widget.items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: widget.withPrefixIcon
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
                : widget.applyCountryFlag
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
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          fillColor: CustomColors.primaryWhite,
          focusColor: CustomColors.primaryWhite,
          labelText: widget.labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
