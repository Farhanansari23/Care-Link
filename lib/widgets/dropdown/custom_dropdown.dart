import 'dart:ui';
import 'package:flutter/material.dart';
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
    this.glassEffect = false, // New parameter for glassmorphism
    this.blurAmount = 5.0, // Blur intensity
    this.glassOpacity = 0.2, // Opacity level
    this.borderColor, // Border color
    this.focusedBorderColor, // Focused border color
    this.enabledBorderColor, // Enabled border color
  });

  final Color? color;
  final String labelText;
  final String value;
  final List<String> items;
  final Function(String?) onChanged;
  final bool withPrefixIcon;
  final bool applyCountryFlag;
  final double borderRadius;
  final bool glassEffect;
  final double blurAmount;
  final double glassOpacity;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? enabledBorderColor;

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: widget.glassEffect
          ? BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: widget.blurAmount,
          ),
        ],
      )
          : null,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: BackdropFilter(
          filter: widget.glassEffect
              ? ImageFilter.blur(
            sigmaX: widget.blurAmount,
            sigmaY: widget.blurAmount,
          )
              : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
          child: DropdownButtonFormField(
            value: widget.value,
            isExpanded: true,
            dropdownColor: widget.glassEffect
                ? Colors.white.withOpacity(widget.glassOpacity)
                : Colors.white,
            items: widget.items.map((item) {
              return DropdownMenuItem(
                value: item,
                child: widget.withPrefixIcon
                    ? Row(
                  mainAxisSize: MainAxisSize.min,
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
                  mainAxisSize: MainAxisSize.min,
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
              filled: true,
              fillColor: widget.glassEffect
                  ? Colors.white.withOpacity(widget.glassOpacity)
                  : widget.color ?? CustomColors.primaryWhite,
              focusColor: CustomColors.primaryWhite,
              labelText: widget.labelText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: widget.glassEffect
                    ? BorderSide.none
                    : BorderSide(
                  color: widget.borderColor ?? Colors.grey,
                  width: 1.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: widget.glassEffect
                    ? BorderSide.none
                    : BorderSide(
                  color: widget.enabledBorderColor ??
                      widget.borderColor ?? Colors.grey,
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: widget.glassEffect
                    ? BorderSide(
                  color: Colors.white.withOpacity(0.3),
                  width: 1.5,
                )
                    : BorderSide(
                  color: widget.focusedBorderColor ??
                      widget.borderColor ?? Colors.grey,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}