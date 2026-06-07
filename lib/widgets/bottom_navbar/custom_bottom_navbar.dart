import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:semester_project/routes/route_generator_constants.dart';
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
          backgroundColor: Colors.white,
          color: Colors.black,
          activeColor: Colors.white,
          selectedIndex: selectedIndex,
          onTabChange: onTap,
          tabBackgroundColor: CustomColors.lightBlue,
          padding: EdgeInsets.all(16),
          tabs: [
            GButton(
              onPressed: (){
                Navigator.of(context).pushNamed(UserConstants.userDashboard);
              },
                icon: FontAwesomeIcons.house.data,
                text: 'Home',
                gap: 8,
            ),
            GButton(
              onPressed: (){
                Navigator.of(context).pushNamed(UserConstants.userTreatmentPage);
              },
                icon: FontAwesomeIcons.stethoscope.data,
                text: 'Treatment',
                gap: 8,
            ),
            GButton(
                icon: FontAwesomeIcons.hospital.data,
                text: 'Hospitals',
                gap: 8,
            ),
            GButton(icon: Icons.person, text: 'Profile',gap: 8,),
          ],
        ),
      ),
    );
  }
}
