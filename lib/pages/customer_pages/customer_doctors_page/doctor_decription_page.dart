import 'package:cloudinary_url_gen/transformation/region.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:semester_project/widgets/buttons/custom_elevatedbutton.dart';
import 'package:semester_project/widgets/text/custom_text.dart';

import '../../../provider/customer_doctorsdetail_provider.dart';
import '../../../widgets/appbar/custom_appbar.dart';
import '../../../widgets/colors/custom_colors.dart';
import '../../../widgets/container/custom_container.dart';

class CustomersDoctorDescriptionPage extends StatefulWidget {
  const CustomersDoctorDescriptionPage({super.key});

  @override
  State<CustomersDoctorDescriptionPage> createState() => _CustomersDoctorDescriptionPageState();
}

class _CustomersDoctorDescriptionPageState extends State<CustomersDoctorDescriptionPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroudColor,
      body: body(context),
    );
  }

  // PreferredSize _appBar(context) {
  //   return PreferredSize(
  //     preferredSize: Size.fromHeight(kToolbarHeight),
  //     child: AppBar(
  //       backgroundColor: CustomColors.backgroudColor,
  //      title: CustomText(text: 'Doctors',isHeading: true,),
  //       centerTitle: true,
  //       leading: CircleAvatar(
  //         radius: 24,
  //         backgroundColor: Colors.white,
  //         child: Icon(Icons.chevron_left,size: 32,),
  //       ),
  //       actionsPadding: EdgeInsets.symmetric(horizontal: 8),
  //     ),
  //   );
  // }
  
  Widget body(context){
    return SafeArea(
      child: Consumer<CustomersDoctorDetailProvider>(
        builder: (context,customersDoctorDetailProvider,_) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    SizedBox(width: MediaQuery.of(context).size.width * 0.20,),
                    CustomText(text: 'About Doctor', size: 24),
                  ],
                ),
              ),
              SizedBox(height: 16,),
              CustomContainer(
                horizontalMargin: 16,
                color: CustomColors.backgroudColor,
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 64,
                    ),
                    SizedBox(width: 16,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(text: "Dr.Dhnasyam Jha",isContent: true,),
                        SizedBox(height: 8,),
                        CustomText(text: "Orthopedic",),
                        SizedBox(height: 8,),
                        CustomText(text: "Biratnagar-10, Nepal",),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: CustomText(text: 'About',isHeading: true,),
              ),
              CustomContainer(
                horizontalMargin: 32,
                horizontalPad: 0,
                verticalPad: 8,
                color: CustomColors.backgroudColor,
                  child: CustomText(
                      text: "Dr. Ahmed Mahmoud is dedicated to providing compassionate, patient-centered care. With a focus on preventative cardiology, she works with patients to achieve long-term heart health and overall wellness",
                     maxLines: 3,
                     textOverflow: TextOverflow.ellipsis,
                  ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: CustomText(text: 'Available',isHeading: true,),
              ),
              CustomContainer(
                horizontalMargin: 32,
                horizontalPad: 0,
                verticalPad: 8,
                color: CustomColors.backgroudColor,
                child: CustomText(
                  text: "Tuesday/Thursday:9:00/12:30",
                  maxLines: 3,
                  textOverflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: CustomText(text: 'Schedule',isHeading: true,),
              ),
              SizedBox(height: 16,),
              // CustomContainer(
              //   horizontalMargin: 32,
              //   horizontalPad: 0,
              //   verticalPad: 8,
              //   color: CustomColors.backgroudColor,
              //   child: CustomText(
              //     text: "Tuesday/Thursday:9:00/12:30",
              //     maxLines: 3,
              //     textOverflow: TextOverflow.ellipsis,
              //   ),
              // ),
              CustomContainer(
            color: Colors.white,
            height: 0.16,
            horizontalMargin: 16,
            child: DatePicker(
              DateTime.now(),
              initialSelectedDate: DateTime.now(),
              width: 60,
              selectionColor:CustomColors.lightBlue,
              dateTextStyle: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 24
              ),
              onDateChange: (date){
                customersDoctorDetailProvider.setDateTime(date);
                print(customersDoctorDetailProvider.selectedDate);
              },
            ),
          ),
              SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomElevatedButton(
                    width: 0.8,
                    backgroundColor: CustomColors.lightBlue,
                      onPressed: (){},
                      widget: CustomText(
                        text: 'Book Now',isContent: true,color: Colors.white,
                      ),
                  ),
                ],
              ),
          ],
              );
        }
      ),
    );
  }
}
