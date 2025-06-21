import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloudinary_url_gen/transformation/region.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:semester_project/widgets/circle_avatar/custom_circle_avatar.dart';
import 'package:semester_project/widgets/colors/custom_colors.dart';
import 'package:semester_project/widgets/drawer/Custom_drawer.dart';
import 'package:semester_project/widgets/glass_box/custom_glassbox.dart';
import '../../../const.dart';
import '../../../provider/auth_provider/auth_provider.dart';
import '../../../provider/customer_provider/customer_profile_provider.dart';
import '../../../provider/customer_provider/customer_provider.dart' show CustomerProvider;
import '../../../routes/route_generator_constants.dart';
import '../../../widgets/bottom_navbar/custom_bottom_navbar.dart';
import '../../../widgets/container/custom_container.dart';
import '../../../widgets/text/custom_text.dart';
import '../../../widgets/textfield/custom_textfield.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomerDashboard extends StatefulWidget {
  const CustomerDashboard({super.key});

  @override
  State<CustomerDashboard> createState() => _CustomerDashboardState();
}

class _CustomerDashboardState extends State<CustomerDashboard> {
  String userName = '';

  @override
  void initState() {
    super.initState();
    _loadUserName();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadImage();
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

  Future<void> _loadUserName() async {
    final FlutterSecureStorage secureStorage = FlutterSecureStorage();
    String? name = await secureStorage.read(key: 'user_name');
    setState(() {
      userName = name ?? 'Guest'; // Fallback if null
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroudColor,
      body: _body(context),
      drawer: CustomDrawer(
        isHomeActive: true,
      ),
    );
  }

  Widget _body(context){
    return Consumer<CustomerProvider>(
        builder: (context,customerProvider,_) {
          CustomerProfileProvider customerProfileProvider = Provider.of<CustomerProfileProvider>(context,listen: false);
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomContainer(
                      color: CustomColors.backgroudColor,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: (){
                              Scaffold.of(context).openDrawer();
                            },
                            child: CircleAvatar(
                              backgroundColor: CustomColors.lightBlue,
                              radius: 32,
                              backgroundImage: customerProfileProvider.imageUrl != null
                                  ? NetworkImage(customerProfileProvider.imageUrl!)
                                  : null,
                              child: customerProfileProvider.imageUrl == null
                                  ? Icon(Icons.person, color: Colors.white)
                                  : null,
                            ),
                          ),
                          SizedBox(width: 16,),
                          Consumer<AuthenticationProvider>(
                              builder: (context,authProvider,_) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(text: 'Hello,',size: 24,fontWeight: FontWeight.w400,),
                                    // CustomText(text: 'Farhan Ansari',size: 24,fontWeight: FontWeight.w600,),
                                    CustomText(text:userName,size: 24,fontWeight: FontWeight.w600,)
                                  ],);
                              }
                          ),
                          Spacer(),
                          CircleAvatar(
                              radius: 28,
                              backgroundColor: Colors.white,
                              child: Icon(FontAwesomeIcons.bell,size: 26,)),
                        ],
                      ),
                    ),
                    CustomContainer(
                      verticalPad: 0,
                      color: CustomColors.backgroudColor,
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.14,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: customerProvider.doctorList.length,
                        itemBuilder: (context,index){
                          return  Row(
                            children: [
                              SizedBox(width: 16,),
                              CustomContainer(
                                width: 0.40,
                                height: 0.13,
                                child: Column(
                                  children: [
                                    Image.asset(customerProvider.doctorList[index]['categoryImg'],width: 56,height: 56,),
                                    SizedBox(height: 8,),
                                    CustomText(text: customerProvider.doctorList[index]['categoryName'],isContent: true,)
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.20,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (context,index){
                          return Row(
                            children: [
                              SizedBox(width: 8,),
                              CustomContainer(
                                horizontalMargin: 8,
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
                            ],
                          );
                        },
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