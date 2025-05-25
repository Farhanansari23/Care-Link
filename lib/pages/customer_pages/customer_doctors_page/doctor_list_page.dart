import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:semester_project/widgets/colors/custom_colors.dart';
import '../../provider/customer_doctorsdetail_provider.dart';
import '../../provider/customer_hospitaidetail_provider.dart';
import '../../widgets/container/custom_container.dart';
import '../../widgets/glass_box/custom_glassbox.dart';
import '../../widgets/text/custom_text.dart';
import '../../widgets/textfield/custom_textfield.dart';

class CustomerDoctorListPage extends StatefulWidget {
  const CustomerDoctorListPage({super.key});

  @override
  State<CustomerDoctorListPage> createState() => _CustomerDoctorListPageState();
}

class _CustomerDoctorListPageState extends State<CustomerDoctorListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroudColor,
      body: body(context),
    );
  }

  Widget body(context){
    return SafeArea(
      child: Consumer<CustomersDoctorDetailProvider>(
        builder: (context,customersDoctorDetailProvider,_) {
          return Column(
            children: [
              CustomContainer(
                color:  CustomColors.backgroudColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                    SizedBox(width: MediaQuery.of(context).size.width * 0.24,),
                    CustomText(text: 'Doctors', size: 24),
                  ],
                ),
              ),
              CustomContainer(
                verticalPad: 0,
                color: CustomColors.backgroudColor,
                child: TextFromFieldWithPrefixSuffix(
                  hintText: 'Search Doctor',
                  borderColor: Colors.white,
                  fillColor: Colors.white,// Default border color
                  borderRadius: 16,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade600,
                  ),
                  controller: customersDoctorDetailProvider.searchController,
                  validator: (value) {
                    null;
                  },
                ),
              ),
              SizedBox(height: 16,),
             Expanded(
                 child: ListView.builder(
                   itemCount: 3,
                   itemBuilder: (context,index){
                     return Column(
                       children: [
                         CustomContainer(
                           horizontalMargin: 16,
                           color: CustomColors.lightBlue,
                           child: Column(
                             children: [
                               Row(
                                 children: [
                                   CircleAvatar(radius: 48,backgroundColor: Colors.white,),
                                   SizedBox(width: 16,),
                                   Expanded(
                                     child: Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         CustomText(text: 'Dr.Dhanshyam Jha',fontWeight: FontWeight.w600,size: 20,color: Colors.white,),
                                         ConstrainedBox(
                                           constraints: BoxConstraints(maxWidth:  MediaQuery.of(context).size.width * 0.6),
                                           child: CustomText(
                                             text: 'Orthopedic Consultation (Foot & Ankle)',
                                             size: 14,color: Colors.white,
                                             textOverflow: TextOverflow.ellipsis,
                                             maxLines: 3,
                                             textAlign: TextAlign.start,
                                           ),
                                         ),
                                         SizedBox(height: 16,),
                                         Container(
                                           child: GlassBox(
                                               height: MediaQuery.of(context).size.height * 0.056,
                                               width: MediaQuery.of(context).size.width * 0.50,
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
                                               width: MediaQuery.of(context).size.width * 0.50,
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
          );
        }
      ),
    );
  }
}
