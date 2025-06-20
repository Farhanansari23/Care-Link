import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:semester_project/const.dart';
import 'package:semester_project/widgets/drawer/Custom_drawer.dart';

import '../../../provider/customer_provider/customer_profile_provider.dart';
import '../../../routes/route_generator_constants.dart';
import '../../../widgets/bottom_navbar/custom_bottom_navbar.dart';
import '../../../widgets/colors/custom_colors.dart';
import '../../../widgets/container/custom_container.dart';
import '../../../widgets/text/custom_text.dart';

class CustomerTreatmentPage extends StatefulWidget {
  const CustomerTreatmentPage({super.key});

  @override
  State<CustomerTreatmentPage> createState() => _CustomerTreatmentPageState();
}

class _CustomerTreatmentPageState extends State<CustomerTreatmentPage> {

  String userName = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadUserName();
    _loadImage();
  }
  Future<void> _loadUserName() async {
    final FlutterSecureStorage secureStorage = FlutterSecureStorage();
    String? name = await secureStorage.read(key: 'user_name');
    setState(() {
      userName = name ?? 'Guest'; // Fallback if null
    });
  }

  Future<void>_loadImage()async{
    final customerProfileProvider = Provider.of<CustomerProfileProvider>(context, listen: false);
    final secureStorage = FlutterSecureStorage();
    final imageUrl = await secureStorage.read(key: 'profile_image_url');
    if(imageUrl != null){
      customerProfileProvider.setImageUrl(imageUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroudColor,
      body: body(context),
      drawer: CustomDrawer(
        isTreatmentActive: true,
      ),
    );
  }

  Widget body(context) {
    final customerProfileProvider = Provider.of<CustomerProfileProvider>(context, listen: false);
    return SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                     Navigator.pop(context);
                    },
                    child: CircleAvatar(
                      child: Icon(Icons.arrow_back_ios_new),
                      radius: 24,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  CustomText(text: 'Treatment', size: 24),
                  CircleAvatar(
                    child: Icon(FontAwesomeIcons.ellipsisVertical),
                    radius: 24,
                    backgroundColor: Colors.white,
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),
            // Patient Info Card
            CustomContainer(
              horizontalMargin: 24,
              width: 0.9,
              child: Row(
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(text: userName, isHeading: true),
                          CustomText(text: 'Male, 23 y.o', isSubHeading: true),
                          CustomText(text: 'Height: 5\'7', isContent: true),
                          SizedBox(height: 16),
                          CustomContainer(
                            verticalPad: 8,
                            borderRadius: 32,
                            color: CustomColors.lightBlue,
                            child: CustomText(
                              text: '3 Treatment Plan\'s',
                              color: Colors.white,
                              isContent: true,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(width: 24,),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: CustomColors.lightBlue,
                        radius: 64,
                        backgroundImage: customerProfileProvider.imageUrl != null
                            ? NetworkImage(customerProfileProvider.imageUrl!)
                            : null,
                        child: customerProfileProvider.imageUrl == null
                            ? Icon(Icons.person, color: Colors.white)
                            : null,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            // Checkup Schedule Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Row(
                children: [
                  CustomText(
                    text: 'My Checkup Schedule',
                    size: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  Spacer(),
                  CustomText(
                    text: 'See All',
                    size: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            // Horizontal Appointments List
            SizedBox(
              height: MediaQuery.of(context).size.height *0.24,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      SizedBox(width: 24,),
                      CustomContainer(
                            width: 0.8,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Date + Calendar Icon
                                Row(
                                  children: [
                                    CircleAvatar(
                                      child: Icon(
                                        FontAwesomeIcons.calendar,
                                        color: Colors.white,
                                      ),
                                      radius: 24,
                                      backgroundColor: CustomColors.lightBlue,
                                    ),
                                    Spacer(),
                                    CustomText(
                                      text: 'Sep 07',
                                      size: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                CustomText(
                                  text: 'Clinical Visit Appointment',
                                  isHeading: true,
                                  textOverflow: TextOverflow.visible,
                                  maxLines: 2,
                                ),
                                SizedBox(height: 16),
                                Row(
                                  children: [
                                    CustomContainer(
                                      borderColor: Colors.grey.shade400,
                                      borderRadius: 32,
                                      verticalPad: 4,
                                      horizontalPad: 4,
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 16,
                                            backgroundColor: CustomColors.lightBlue,
                                          ),
                                          SizedBox(width: 8),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              right: 8.0,
                                            ),
                                            child: CustomText(
                                              text: 'Dr.Cherian',
                                              color: CustomColors.lightBlue,
                                              isContent: true,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 24),
                                    CircleAvatar(
                                      backgroundColor: CustomColors.lightBlue,
                                      child: Icon(
                                        FontAwesomeIcons.phone,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              height: MediaQuery.of(context).size.height *0.40,
              child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      CustomContainer(
                        width: 0.9,
                        horizontalMargin: 24,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Date + Calendar Icon
                            Row(
                              children: [
                                CircleAvatar(
                                  child: Icon(
                                    FontAwesomeIcons.calendar,
                                    color: Colors.white,
                                  ),
                                  radius: 24,
                                  backgroundColor: CustomColors.lightBlue,
                                ),
                                Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: 'Dr.Aarti Anand Rouniyar',
                                      size: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    CustomText(
                                      text: 'Pulmonoligst',
                                      size: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    CustomText(
                                      text: '5 Years experience',
                                      size: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    SizedBox(height: 8,),
                                    CustomContainer(
                                        child: CustomText(
                                          text: 'Visit Now',
                                          color: Colors.white,
                                          isContent: true,
                                        ),
                                      color: CustomColors.lightBlue,
                                      borderRadius: 32,
                                      verticalPad: 8,
                                      horizontalPad: 24,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16,),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
