import 'dart:ui';

import 'package:flutter/material.dart';
import '../colors/custom_colors.dart';

class TextFromFieldWithPrefixSuffix extends StatefulWidget {
  const TextFromFieldWithPrefixSuffix({
    super.key,
    required this.controller,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    required this.validator,
    this.keyboardType = TextInputType.text,
    this.obscure = false,
    this.applyPrefix = true,
    this.applySuffixIcon = false,
    this.suffixIcon,
    this.fillColor,
    this.borderRadius = 8.0,
    this.borderColor, // Add this new parameter
    this.focusedBorderColor, // Add this new parameter
    this.enabledBorderColor, // Add this new parameter
    this.errorBorderColor,
    this.autoFocus = false,
    this.readOnly = false,
    this.minLine = 1,
    this.maxLines = 1,
    this.onChange,
    this.onChanged,
    this.onTap,
    this.focusNode,
    this.glassEffect = false, // New parameter for glassmorphism
    this.blurAmount = 5.0, // Blur intensity
    this.glassOpacity = 0.2,
    // Opacity level
  });

  // ... (keep all your existing parameters)

  final bool glassEffect; // New: Enable/disable glass effect
  final double blurAmount; // New: Controls blur intensity
  final double glassOpacity; // New: Controls transparency
  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final bool obscure;
  final bool applyPrefix;
  final Widget? prefixIcon;
  final bool applySuffixIcon;
  final Widget? suffixIcon;
  final Color? fillColor;
  final double borderRadius;
  final Color? borderColor; // Default border color
  final Color? focusedBorderColor; // Color when focused
  final Color? enabledBorderColor; // Color when enabled but not focused
  final Color? errorBorderColor;
  final String? Function(String?) validator;
  final bool autoFocus;
  final bool readOnly;
  final TextInputType keyboardType;
  final int minLine;
  final int maxLines;
  final Function(String?)? onChange;
  final Function(String?)? onChanged;
  final Function()? onTap;
  final FocusNode? focusNode; // Optional FocusNode

  @override
  _TextFromFieldWithPrefixSuffixState createState() =>
      _TextFromFieldWithPrefixSuffixState();
}

class _TextFromFieldWithPrefixSuffixState
    extends State<TextFromFieldWithPrefixSuffix> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // The glassmorphism container
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
              : ImageFilter.blur(sigmaX: 0, sigmaY: 0), // No blur when disabled
          child: TextFormField(
            textCapitalization: TextCapitalization.sentences,
            keyboardType: widget.keyboardType,
            controller: widget.controller,
            obscureText: widget.obscure,
            validator: widget.validator,
            autofocus: widget.autoFocus,
            readOnly: widget.readOnly,
            minLines: widget.minLine,
            maxLines: widget.maxLines,
            focusNode: _focusNode,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onTap: widget.onTap,
            onChanged: widget.onChanged,
            decoration: InputDecoration(
              filled: true,
              fillColor: widget.glassEffect
                  ? Colors.white.withOpacity(widget.glassOpacity)
                  : widget.fillColor ?? CustomColors.primaryWhite,
              focusColor: CustomColors.primaryWhite,
              labelText: widget.labelText,
              hintText: widget.hintText,
              prefixIcon: widget.applyPrefix ? widget.prefixIcon : null,
              suffixIcon: widget.applySuffixIcon ? widget.suffixIcon : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: widget.glassEffect
                    ? BorderSide.none // Remove border for glass effect
                    : BorderSide(
                  color: widget.borderColor ?? Colors.grey, // Default border color
                  width: 1.0,
                ), // Default border

              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: widget.glassEffect
                    ? BorderSide.none
                    :  BorderSide(
                  color: widget.enabledBorderColor ?? widget.borderColor ?? Colors.grey,
                  width: 1.0,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide(
                  color: widget.errorBorderColor ?? Colors.red,
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: widget.glassEffect
                    ? BorderSide(
                    color: Colors.white.withOpacity(0.3), width: 1.5)
                    :  BorderSide(
                  color: widget.focusedBorderColor ?? widget.borderColor ?? Colors.grey,
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