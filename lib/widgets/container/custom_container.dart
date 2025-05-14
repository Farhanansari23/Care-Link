import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.child,
    this.borderRadius = 16.0,
    this.width = 0.0,
    this.height = 0.0,
    this.color = Colors.white,
    this.borderColor,
    this.applyShadow = false,
    this.verticalPad = 16.0,
    this.horizontalPad = 16.0,
    this.verticalMargin = 0,
    this.horizontalMargin = 0,
    this.glassEffect = false, // New: Enable glassmorphism
    this.glassOpacity = 0.2, // New: Opacity level (0-1)
    this.blurAmount = 5.0, // New: Blur intensity
    this.glassBorderWidth = 1.0, // New: Border width for glass effect
  });

  final Widget child;
  final double width;
  final double height;
  final double borderRadius;
  final Color color;
  final Color? borderColor;
  final bool applyShadow;
  final double verticalPad;
  final double horizontalPad;
  final double verticalMargin;
  final double horizontalMargin;

  // Glassmorphism parameters
  final bool glassEffect;
  final double glassOpacity;
  final double blurAmount;
  final double glassBorderWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width != 0.0 ? MediaQuery.of(context).size.width * width : null,
      height: height != 0.0 ? MediaQuery.of(context).size.height * height : null,
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPad, vertical: verticalPad),
      margin: EdgeInsets.symmetric(
          vertical: verticalMargin, horizontal: horizontalMargin),
      decoration: glassEffect
          ? _buildGlassDecoration(context)
          : _buildRegularDecoration(context),
      child: child,
    );
  }

  BoxDecoration _buildRegularDecoration(BuildContext context) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
        color: borderColor ?? Colors.transparent,
        width: 1.0,
      ),
      boxShadow: applyShadow
          ? [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          spreadRadius: 2.0,
          blurRadius: 1.0,
          offset: const Offset(3, 3),
        )
      ]
          : null,
    );
  }

  BoxDecoration _buildGlassDecoration(BuildContext context) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
        color: borderColor?.withOpacity(0.3) ?? Colors.white.withOpacity(0.3),
        width: glassBorderWidth,
      ),
      color: color.withOpacity(glassOpacity),
      boxShadow: [
        if (applyShadow)
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2.0,
            blurRadius: 1.0,
            offset: const Offset(3, 3),
          ),
        BoxShadow(
          color: Colors.white.withOpacity(0.2),
          spreadRadius: -5.0,
          blurRadius: blurAmount,
        ),
      ],
    );
  }
}