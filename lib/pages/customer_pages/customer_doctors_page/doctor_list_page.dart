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
    customerHospitalDetailProvider.getHospitalList();
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
             // if(customerHospitalDetailProvider.hospitalID == doctorID)
             Expanded(
                 child: ListView.builder(
                   itemCount:  customerHospitalDetailProvider.hospitalList.length,
                   itemBuilder: (context,index){
                     final hospital = customerHospitalDetailProvider.hospitalList[index];
                     String id = customerHospitalDetailProvider.hospitalList[index]['_id'];
                     final doctors = hospital['doctor_id'] as List<dynamic>? ?? [];
                     final doctorID = hospital['doctor_id'][0]['_id'];


                     if (doctors.isEmpty) return SizedBox(); // Skip if no doctors

                     // Get the first doctor (or loop if multiple)
                     final doctor = doctors[0];
                     final name = doctor['name'] ?? 'N/A';
                     final description = doctor['description'] ?? 'No Description';

                     // final hospital = customerHospitalDetailProvider.hospitalList[index];
                     // final name = hospital['doctor_id'][index]['name'];
                     // final description = hospital['doctor_id'][index]['description'];

                     final schedules = doctor['schedule'] as List<dynamic>? ?? [];
                     if (schedules.isEmpty) return SizedBox(); // No schedule? Skip.

                     final firstSchedule = schedules[0];
                     final timeSlots = firstSchedule['time_slots'] as List<dynamic>? ?? [];

                     if (timeSlots.isEmpty) return SizedBox(); // No time slots? Skip.

                     final firstTimeSlot = timeSlots[0];
                     final startTime = firstTimeSlot['startTime'] ?? 'N/A'; // Already in "09:00 AM" format
                     final endTime = firstTimeSlot['endTime'] ?? 'N/A';

                     // final firstTime = hospital['doctor_id'][index]['schedule'][index]['time_slots'][index]['startTime'].toString().split('.')[0]; // already in "09:00 AM" format
                     // final  lastTime = hospital['doctor_id'][index]['schedule'][index]['time_slots'][index]['endTime'].toString().split('.')[0];
                     // customerHospitalDetailProvider.hospitalID ??
                     return Column(
                       children: [
                         InkWell(
                           onTap: (){
                             print(doctorID);
                             // Navigator.of(context).pushNamed(UserConstants.userDoctorDescriptionPage);
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
