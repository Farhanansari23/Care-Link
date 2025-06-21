import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../classes/secure_storage.dart';
import '../../const.dart';
import '../../provider/customer_provider/customer_profile_provider.dart';
import '../../routes/route_generator_constants.dart';
import '../buttons/custom_elevatedbutton.dart';
import '../colors/custom_colors.dart';
import '../list_tile/custom_list_tile.dart';
import '../text/custom_text.dart'; // Ensure this import is correct

class CustomDrawer extends StatefulWidget {
  CustomDrawer({
    super.key,
    this.isLogoutActive = false,
    this.isHomeActive = false,
    this.isTreatmentActive = false,
    this.isHospitalActive = false,
    this.isProfileActive = false,
  });

  final bool isLogoutActive;
  final bool isHomeActive;
  final bool isTreatmentActive;
  final bool isHospitalActive;
  final bool isProfileActive;

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {

  String userName = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final FlutterSecureStorage secureStorage = FlutterSecureStorage();
    String? name = await secureStorage.read(key: 'user_name');
    setState(() {
      userName = name ?? 'Guest'; // Fallback if null
    });
  }

  @override
  Widget build(BuildContext context) {
    CustomerProfileProvider customerProfileProvider = Provider.of<CustomerProfileProvider>(context,listen: false);
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Container(
        color: Colors.white,
        child: ListView(
          children: [
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.only(
                top: 40.0,
                left: 16.0,
                bottom: 16.0,
              ),
              child: Container(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      backgroundImage: customerProfileProvider.imageUrl != null
                          ? NetworkImage(customerProfileProvider.imageUrl!)
                          : null,
                      child: customerProfileProvider.imageUrl == null
                          ? Icon(FontAwesomeIcons.user, size: 20)
                          : null,
                    ),
                    SizedBox(width: 16,),
                    CustomText(text:userName,isContent: true,)
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 0.8,
              color: CustomColors.primaryBlack,
            ),
            CustomListTile(
              onTap: (){
                Navigator.of(context).pushNamed(UserConstants.userDashboard);
              },
              isTabActive: widget.isHomeActive,
             icon: FontAwesomeIcons.home,
              iconSize: 18,
              text: 'Home',
              textColor: Colors.black,
              tabColor: CustomColors.lightBlue,
            ),
            CustomListTile(
              onTap: (){
                Navigator.of(context).pushNamed(UserConstants.userTreatmentPage);
              },
              isTabActive: widget.isTreatmentActive,
              icon: FontAwesomeIcons.stethoscope,
              tabColor: CustomColors.lightBlue,
              iconSize: 20,
              imgColor: Colors.black,
              text: 'Treatment',
              textColor: Colors.black,
            ),
            CustomListTile(
              onTap: (){
                Navigator.of(context).pushNamed(UserConstants.userHospitalListPage);
              },
              isTabActive: widget.isHospitalActive,
              icon: FontAwesomeIcons.hospital,
              iconSize: 20,
              text: 'Hospital',textColor: Colors.black,
            ),
            InkWell(
              onTap: (){
                Navigator.of(context).pushNamed(UserConstants.userProfilePage);
              },
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 0.0,
                  left: 10.0,
                  bottom: 8.0,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      backgroundImage: customerProfileProvider.imageUrl != null
                          ? NetworkImage(customerProfileProvider.imageUrl!)
                          : null,
                      child: customerProfileProvider.imageUrl == null
                          ? Icon(FontAwesomeIcons.user, size: 20)
                          : null,
                    ),
                    SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(text: 'Profile',isContent: true,),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            CustomListTile(
              onTap: (){
                openAlertDialog(context);
              },
              isTabActive: widget.isLogoutActive,
              icon: FontAwesomeIcons.arrowRightFromBracket,
              iconSize: 20,
              text: 'Log Out',textColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}

//-------------------------------------------------------------Alert Dialog---------------------------------------------------------------------------------------------------------------------------//
void openAlertDialog(context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: CustomText(
            text: 'Logout',
            fontWeight: FontWeight.w600,
            size: 24,
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomText(text: 'Are you sure you want to logout?')
                ],
              ),
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomElevatedButton(onPressed: ()async{
                  Navigator.pop(context);
                }, widget:  CustomText(text:'Cancel'),backgroundColor:CustomColors.lightRed,),
                CustomElevatedButton(
                  onPressed: ()async{
                    SessionController.instance.clearSession();
                    Navigator.of(context).pushNamed(UserConstants.logInPage);
                },
                  widget: CustomText(text: 'Yes'),backgroundColor: CustomColors.lightBlue,)
              ],
            )

          ],
        );
      });
}

