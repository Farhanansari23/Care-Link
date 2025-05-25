import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../colors/custom_colors.dart';


class CustomListTile extends StatelessWidget {
  CustomListTile({
    required this.onTap,
    required this.isTabActive,
    this.tabColor,
    this.icon,
    this.iconSize,
    this.iconColor,
    required this.text,
    this.textSize,
    this.textColor,
    this.textFontWeight,
    this.isIcon = true,
    this.imgName,
    this.imgWidth,
    this.imgHeigt,
    this.imgBoxFit,
    this.imgColor,
    super.key,
  });

  Function() onTap;
  final bool isTabActive;
  final Color? tabColor;
  final IconData? icon;
  final double? iconSize;
  final Color? iconColor;
  final String text;
  final double? textSize;
  final Color? textColor;
  final FontWeight? textFontWeight;
  final bool isIcon;
  final String? imgName;
  final double? imgWidth;
  final double? imgHeigt;
  final BoxFit? imgBoxFit;
  final Color? imgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0),
      decoration: BoxDecoration(
          color: isTabActive ? CustomColors.primaryWhite : Colors.transparent),
      child: ListTile(
        leading: isIcon
            ? FaIcon(
          icon ?? null,
          size: iconSize ?? 18,
          color: iconColor ?? Colors.black,
        )
            : Image.asset(
          imgName ?? '',
          width: imgWidth ?? 40,
          height: imgHeigt ?? 40,
          fit: imgBoxFit ?? BoxFit.none,
          color: imgColor ?? null,
        ),
        title: Text(
          text,
          style: TextStyle(
            color: textColor ?? Colors.black,
            fontWeight: textFontWeight ?? FontWeight.w500,
            fontSize: textSize ?? 16,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
