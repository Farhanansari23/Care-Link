import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:semester_project/routes/route_generator_constants.dart';
import 'package:semester_project/widgets/colors/custom_colors.dart';
import '../../../provider/customer_provider/customer_doctorsdetail_provider.dart';
import '../../../provider/customer_provider/customer_hospitaidetail_provider.dart';
import '../../../widgets/container/custom_container.dart';
import '../../../widgets/glass_box/custom_glassbox.dart';
import '../../../widgets/text/custom_text.dart';
import '../../../widgets/textfield/custom_textfield.dart';

class CustomerDoctorListPage extends StatefulWidget {
  const CustomerDoctorListPage({super.key});

  @override
  State<CustomerDoctorListPage> createState() => _CustomerDoctorListPageState();
}

class _CustomerDoctorListPageState extends State<CustomerDoctorListPage> {
  // String _startTime = '';
  String _id = '';
  @override
  void initState() {
    // TODO: implement initState
    CustomerHospitalDetailProvider customerHospitalDetailProvider = Provider.of<CustomerHospitalDetailProvider>(context,listen: false);
    customerHospitalDetailProvider.geDoctorByHospitalList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroudColor,
      body: body(context),
    );
  }

  Widget body(context){
    return SafeArea(
      child: Consumer<CustomerHospitalDetailProvider>(
        builder: (context,customerHospitalDetailProvider,_) {
          return Column(
            children: [
              CustomContainer(
                color:  CustomColors.backgroudColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        // customerHospitalDetailProvider.clearCache();
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
                  controller: customerHospitalDetailProvider.searchController,
                  validator: (value) {
                    null;
                  },
                ),
              ),
              SizedBox(height: 16,),
             Expanded(
                 child: ListView.builder(
                   itemCount:  customerHospitalDetailProvider.doctorList.length,
                   itemBuilder: (context,index){
                     final doctor = customerHospitalDetailProvider.doctorList[index];
                     //
                     // String id = customerHospitalDetailProvider.doctorList[index]['_id'];
                     // String name = customerHospitalDetailProvider.doctorList[index]['name'];
                     // String description = customerHospitalDetailProvider.doctorList[index]['description'];
                     //
                     // String startTime = customerHospitalDetailProvider.doctorList[index]['schedule'][index]['time_slots'][index]['startTime'].toString().split(' ')[0];
                     // String endTime = customerHospitalDetailProvider.doctorList[index]['schedule'][index]['time_slots'][index]['endTime'].toString().split(' ')[0];
                     // Safe access to doctor details
                     String id = doctor['_id'] ?? '';
                     String name = doctor['name'] ?? 'No name';
                     String description = doctor['description'] ?? 'No description';

                     // Initialize with default values
                     String startTime = 'N/A';
                     String endTime = 'N/A';

                     // Safely access schedule and time slots
                     if (doctor['schedule'] != null &&
                         doctor['schedule'].isNotEmpty &&
                         doctor['schedule'][0]['time_slots'] != null &&
                         doctor['schedule'][0]['time_slots'].isNotEmpty) {

                       final timeSlot = doctor['schedule'][0]['time_slots'][0];
                       startTime = timeSlot['startTime'].toString().split(' ')[0];
                       endTime = timeSlot['endTime'].toString().split(' ')[0];
                     }

                     return Column(
                       children: [
                         InkWell(
                           onTap: (){
                             // print(name);
                             // print(description);
                             // print(startTime);
                             // print(endTime);
                             // print(id);
                             Navigator.of(context).pushNamed(UserConstants.userDoctorDescriptionPage);
                           },
                           child: CustomContainer(
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
                                           CustomText(text: name ,fontWeight: FontWeight.w600,size: 20,color: Colors.white,),
                                           ConstrainedBox(
                                             constraints: BoxConstraints(maxWidth:  MediaQuery.of(context).size.width * 0.6),
                                             child: CustomText(
                                               text: description,
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
                                                 width: MediaQuery.of(context).size.width * 0.56,
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
                                           SizedBox(height: 8,),
                                           Container(
                                             child: GlassBox(
                                                 height: MediaQuery.of(context).size.height * 0.056,
                                                 width: MediaQuery.of(context).size.width * 0.56,
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
                                                     Row(
                                                       children: [
                                                         CustomText(text: startTime,color: Colors.white,size: 16,fontWeight: FontWeight.w600,),
                                                         CustomText(text: endTime,color: Colors.white,size: 16,fontWeight: FontWeight.w600,),
                                                       ],
                                                     )
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
