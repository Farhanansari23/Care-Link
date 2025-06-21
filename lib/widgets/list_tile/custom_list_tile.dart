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
    this.networkImageUrl,
    this.imgWidth,
    this.imgHeigt,
    this.imgBoxFit,
    this.imgColor,
    this.tileHeight, // New parameter for tile height
    this.tileWidth,
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
  final String? networkImageUrl;
  final double? imgWidth;
  final double? imgHeigt;
  final BoxFit? imgBoxFit;
  final Color? imgColor;
  final double? tileHeight;
  final double? tileWidth;

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

  Widget _buildLeadingWidget() {
    if (!isIcon) {
      if (networkImageUrl != null) {
        // Network image case
        return _buildNetworkImage();
      } else if (imgName != null) {
        // Asset image case
        return _buildAssetImage();
      }
    }
    // Default icon case
    return _buildIcon();
  }

  Widget _buildNetworkImage() {
    return Image.network(
      networkImageUrl!,
      width: imgWidth ?? 40,
      height: imgHeigt ?? 40,
      fit: imgBoxFit ?? BoxFit.cover,
      color: imgColor,
      errorBuilder: (context, error, stackTrace) => _buildErrorWidget(),
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return _buildLoadingWidget();
      },
    );
  }

  Widget _buildAssetImage() {
    return Image.asset(
      imgName!,
      width: imgWidth ?? 40,
      height: imgHeigt ?? 40,
      fit: imgBoxFit ?? BoxFit.none,
      color: imgColor,
    );
  }

  Widget _buildIcon() {
    return FaIcon(
      icon,
      size: iconSize ?? 18,
      color: iconColor ?? Colors.black,
    );
  }

  Widget _buildErrorWidget() {
    return Icon(
      Icons.error_outline,
      size: iconSize ?? 18,
      color: Colors.red,
    );
  }

  Widget _buildLoadingWidget() {
    return SizedBox(
      width: imgWidth ?? 40,
      height: imgHeigt ?? 40,
      child: CircularProgressIndicator(),
    );
  }
}
