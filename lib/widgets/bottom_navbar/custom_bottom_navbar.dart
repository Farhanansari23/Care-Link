import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:semester_project/widgets/colors/custom_colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    super.key,
    required this.onTap,
    this.selectedIndex = 0,
  });

  final Function(int) onTap;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 18.0),
        child: GNav(
          gap: 8,
          backgroundColor: Colors.white,
          color: Colors.black,
          activeColor: Colors.white,
          tabBackgroundColor: CustomColors.lightBlue,
          padding: EdgeInsets.all(16),
          tabs: [
            GButton(
                icon: FontAwesomeIcons.house,
                text: 'Home',
            ),
            GButton(
                icon: FontAwesomeIcons.stethoscope,
                text: 'Treatment',
            ),
            GButton(
                icon: FontAwesomeIcons.hospital,
                text: 'Hospitals',
            ),
            GButton(icon: Icons.person, text: 'Profile'),
          ],
        ),
      ),
    );
  }
}
