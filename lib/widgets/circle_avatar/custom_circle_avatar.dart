import 'dart:ui';
import 'package:flutter/material.dart';

class GlassCircleAvatar extends StatelessWidget {
  final ImageProvider? image;
  final double radius;
  final double blurStrength;
  final Color overlayColor;

  const GlassCircleAvatar({
    super.key,
    this.image,
    this.radius = 40,
    this.blurStrength = 5,
    this.overlayColor = Colors.white10,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        width: radius * 2,
        height: radius * 2,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: image != null
              ? DecorationImage(image: image!, fit: BoxFit.cover)
              : null,
        ),
        child: Stack(
          children: [
            // Blur effect
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: blurStrength,
                sigmaY: blurStrength,
              ),
              child: Container(
                color: Colors.transparent,
              ),
            ),
            // Color overlay
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    overlayColor.withOpacity(0.3),
                    overlayColor.withOpacity(0.1),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}