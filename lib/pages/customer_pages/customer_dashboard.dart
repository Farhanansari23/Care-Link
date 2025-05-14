import 'package:cloudinary_url_gen/transformation/region.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:semester_project/widgets/circle_avatar/custom_circle_avatar.dart';
import 'package:semester_project/widgets/colors/custom_colors.dart';
import 'package:semester_project/widgets/glass_box/custom_glassbox.dart';
import '../../provider/customer_provider.dart' show CustomerProvider;
import '../../widgets/bottom_navbar/custom_bottom_navbar.dart';
import '../../widgets/container/custom_container.dart';
import '../../widgets/text/custom_text.dart';
import '../../widgets/textfield/custom_textfield.dart';

class CustomerDashboard extends StatefulWidget {
  const CustomerDashboard({super.key});

  @override
  State<CustomerDashboard> createState() => _CustomerDashboardState();
}

class _CustomerDashboardState extends State<CustomerDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroudColor,
      body: _body(context),
      bottomNavigationBar: CustomBottomNavBar(onTap: (int ) {  },),
    );
  }

  Widget _body(context){
    return Consumer<CustomerProvider>(
      builder: (context,customerProvider,_) {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 Row(
                   children: [
                     Padding(
                       padding: const EdgeInsets.only(left: 16.0),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                         CustomText(text: 'Hello,',size: 24,fontWeight: FontWeight.w400,),
                         CustomText(text: 'Farhan Ansari',size: 24,fontWeight: FontWeight.w600,)
                       ],),
                     ),
                     Spacer(),
                     Padding(
                       padding: const EdgeInsets.only(right: 16.0),
                       child: Container(
                         padding: EdgeInsets.symmetric(horizontal: 4,),
                         width: MediaQuery.of(context).size.width * 0.36,
                         height: MediaQuery.of(context).size.height * 0.070,
                         decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.circular(40),
                         ),
                         child: Row(
                           children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Icon(FontAwesomeIcons.bell,size: 26,),
                            ),
                             SizedBox(width: 48,),
                             CircleAvatar(
                               backgroundColor: Colors.blueAccent,
                               radius: 30,
                             )
                           ],
                         ),
                       ),
                     ),
                   ],
                 ),
                  SizedBox(height: 16,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFromFieldWithPrefixSuffix(
                      controller: customerProvider.searchController,
                      // fillColor: Colors.black,
                      hintText: 'Search Doctor',
                      borderColor: Colors.white,
                      fillColor: Colors.white,// Default border color
                      borderRadius: 16,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey.shade600,
                      ),
                      validator: (value) {
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 16,),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      padding: EdgeInsets.only(left: 16),
                      child: Row(
                        children: [
                         CustomContainer(
                           width: 0.40,
                             height: 0.13,
                             child: Column(
                               children: [
                                Image.asset('assets/images/Neurologist.png',width: 56,height: 56,),
                                 SizedBox(height: 8,),
                                 CustomText(text: 'Neurologist',isContent: true,)
                               ],
                             ),
                         ),
                          SizedBox(width: 16,),
                          CustomContainer(
                            width: 0.40,
                            height: 0.13,
                            child: Column(
                              children: [
                                Image.asset('assets/images/Cardiologist.png',width: 56,height: 56,),
                                SizedBox(height: 8,),
                                CustomText(text: 'Cardiologist',isContent: true,)
                              ],
                            ),
                          ),
                          SizedBox(width: 16,),
                          CustomContainer(
                            width: 0.40,
                            height: 0.13,
                            child: Column(
                              children: [
                                Image.asset('assets/images/orthopedist.png',width: 56,height: 56,),
                                SizedBox(height: 8,),
                                CustomText(text: 'Orthopedist',isContent: true,)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16,),
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: CustomText(text: 'Upcoming Appointment',size: 20,fontWeight: FontWeight.w600,),
                  ),
                  SizedBox(height: 16,),
                  CustomContainer(
                   horizontalMargin: 16,
                    color: CustomColors.lightBlue,
                    child: Column(
                      children: [
                         Row(
                           children: [
                             CircleAvatar(radius: 32,backgroundColor: Colors.white,),
                             SizedBox(width: 16,),
                             Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 CustomText(text: 'Dr.Dhanshyam Jha',fontWeight: FontWeight.w600,size: 20,color: Colors.white,),
                                 CustomText(text: 'Orthopedic Consultation (Foot & Ankle)',size: 14,color: Colors.white,)
                               ],
                             ),
                           ],
                         ),
                        SizedBox(height: 16,),
                        Container(
                          child: GlassBox(
                              height: MediaQuery.of(context).size.height * 0.056,
                              width: MediaQuery.of(context).size.width * 0.8,
                              borderRadius: 64,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 5,top: 3),
                                  child: CircleAvatar(
                                    radius: 24,
                                        child: Icon(FontAwesomeIcons.calendar,color: Colors.white,size: 24,),
                                        backgroundColor: CustomColors.lightBlue,
                                      ),
                                ),
                                  SizedBox(width: 8,),
                                  CustomText(text: 'Wed,13 May 2025',color: Colors.white,size: 16,fontWeight: FontWeight.w600,),
                                ],
                              )),
                        ),
                        SizedBox(height: 16,),
                        Container(
                          child: GlassBox(
                              height: MediaQuery.of(context).size.height * 0.056,
                              width: MediaQuery.of(context).size.width * 0.8,
                              borderRadius: 64,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5,top: 3),
                                    child: CircleAvatar(
                                      radius: 24,
                                      child: Icon(FontAwesomeIcons.clock,color: Colors.white,size: 24,),
                                      backgroundColor: CustomColors.lightBlue,
                                    ),
                                  ),
                                  SizedBox(width: 8,),
                                  CustomText(text: '10:30 11:30 AM',color: Colors.white,size: 16,fontWeight: FontWeight.w600,)
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16,),
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: CustomText(text: 'My Recent Visit',size: 20,fontWeight: FontWeight.w600,),
                  ),
                  SizedBox(height: 16,),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        CustomContainer(
                          horizontalMargin: 16,
                          color: CustomColors.lightBlue,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(radius: 32,backgroundColor: Colors.white,),
                                  SizedBox(width: 16,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomText(text: 'Dr.Dhanshyam Jha',fontWeight: FontWeight.w600,size: 20,color: Colors.white,),
                                      CustomText(text: 'Orthopedic Consultation (Foot & Ankle)',size: 14,color: Colors.white,),
                                      CustomText(text: '7 years experience',size: 14,color: Colors.white,)
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 16,),
                              Row(
                                children: [
                                  Container(
                                    child: GlassBox(
                                        height: MediaQuery.of(context).size.height * 0.056,
                                        width: MediaQuery.of(context).size.width * 0.5,
                                        borderRadius: 64,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 5,top: 3),
                                              child: CircleAvatar(
                                                radius: 24,
                                                child: Icon(FontAwesomeIcons.phone,color: Colors.white,size: 20,),
                                                backgroundColor: CustomColors.lightBlue,
                                              ),
                                            ),
                                            SizedBox(width: 8,),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
                                              child: CustomText(text: 'Book Now',color: Colors.white,size: 16,fontWeight: FontWeight.w600,),
                                            ),
                                          ],
                                        )),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        CustomContainer(
                          horizontalMargin: 16,
                          color: CustomColors.lightBlue,
                          width: 0.8,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(radius: 32,backgroundColor: Colors.white,),
                                  SizedBox(width: 16,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomText(text: 'Dr.Anju Dev',fontWeight: FontWeight.w600,size: 20,color: Colors.white,),
                                      CustomText(text: 'Gynecologist & Surgeon',size: 14,color: Colors.white,),
                                      CustomText(text: '5 years experience',size: 14,color: Colors.white,)
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 16,),
                              Row(
                                children: [
                                  Container(
                                    child: GlassBox(
                                        height: MediaQuery.of(context).size.height * 0.056,
                                        width: MediaQuery.of(context).size.width * 0.5,
                                        borderRadius: 64,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 5,top: 3),
                                              child: CircleAvatar(
                                                radius: 24,
                                                child: Icon(FontAwesomeIcons.phone,color: Colors.white,size: 20,),
                                                backgroundColor: CustomColors.lightBlue,
                                              ),
                                            ),
                                            SizedBox(width: 8,),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
                                              child: CustomText(text: 'Book Now',color: Colors.white,size: 16,fontWeight: FontWeight.w600,),
                                            ),
                                          ],
                                        )),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
