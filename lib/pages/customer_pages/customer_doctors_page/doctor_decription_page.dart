import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:semester_project/widgets/buttons/custom_elevatedbutton.dart';
import 'package:semester_project/widgets/text/custom_text.dart';

import '../../../provider/customer_provider/customer_doctorsdetail_provider.dart';
import '../../../provider/customer_provider/customer_hospitaidetail_provider.dart';
import '../../../widgets/appbar/custom_appbar.dart';
import '../../../widgets/colors/custom_colors.dart';
import '../../../widgets/container/custom_container.dart';
import '../../../widgets/dropdown/custom_dropdown.dart';
import '../../../widgets/textfield/custom_textfield.dart';

class CustomersDoctorDescriptionPage extends StatefulWidget {
  const CustomersDoctorDescriptionPage({super.key});

  @override
  State<CustomersDoctorDescriptionPage> createState() => _CustomersDoctorDescriptionPageState();
}

class _CustomersDoctorDescriptionPageState extends State<CustomersDoctorDescriptionPage> {

  final _confirmBookingFormKey = GlobalKey<FormState>();
  String dateString = '';
  String formattedDate = '';
  String formattedTime = '';
  DateTime _dateTime = DateTime.now();

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
    CustomerHospitalDetailProvider customerHospitalDetailProvider = Provider.of<CustomerHospitalDetailProvider>(context,listen: false);
    return SafeArea(
      child: Consumer<CustomerHospitalDetailProvider>(
        builder: (context,customerHospitalDetailProvider,_) {
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
                        CustomText(text: customerHospitalDetailProvider.doctorName,isContent: true,),
                        SizedBox(height: 8,),
                        CustomText(text: customerHospitalDetailProvider.doctorCategory,),
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
                      text: customerHospitalDetailProvider.doctorDescription,
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
                  text: "Tuesday/Thursday:${customerHospitalDetailProvider.doctorStartTime}/${customerHospitalDetailProvider.doctorEndTime}",
                  maxLines: 3,
                  textOverflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: CustomText(text: 'Schedule',isHeading: true,),
              ),
              SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomElevatedButton(
                    width: 0.8,
                    backgroundColor: CustomColors.lightBlue,
                      onPressed: (){
                      openAlertDialog(context);
                      },
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
  //---------------------------------------------------------------------------Alert Dialog------------------------------------------------------------------------------------------------------------//

  void openAlertDialog(context){
    showDialog(context: context,
        builder: (BuildContext context){
        return AlertDialog(
          backgroundColor: CustomColors.primaryWhite,
          elevation: 10,
          title: Center(
              child: CustomText(
                text: 'Details',
                size: 24,
                fontWeight: FontWeight.w600,
              )),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: SingleChildScrollView(
              child: Consumer<CustomersDoctorDetailProvider>(
                builder: (context,customersDoctorDetailProvider,_) {
                  dateString = customersDoctorDetailProvider.selectedDate.toString().split(" ")[0];
                  DateTime dateTime = DateTime.parse(dateString);
                  formattedDate = DateFormat('EEEE d MMMM').format(dateTime);
                  return Form(
                    key: _confirmBookingFormKey,
                    child: Column(
                      children: [
                        TextFromFieldWithPrefixSuffix(
                          controller: customersDoctorDetailProvider.nameController,
                          hintText: 'Enter your name', // Default border color
                          borderRadius: 8,
                          applySuffixIcon: true,
                          suffixIcon: Icon(
                            Icons.person,
                            color: Colors.grey.shade600,
                          ),
                          validator: (Value) {
                            return null;
                          },
                        ),
                        SizedBox(height: 8,),
                        CustomDropdown(
                          borderRadius: 8,
                            labelText: 'Select Gender',
                            items: customersDoctorDetailProvider.gender,
                            value: customersDoctorDetailProvider.defaultGenderValue,
                            onChanged: (selectedGender) {
                              customersDoctorDetailProvider.setGender(selectedGender);
                            }),
                        SizedBox(height: 8,),
                        TextFromFieldWithPrefixSuffix(
                          controller: customersDoctorDetailProvider.ageController,
                          hintText: 'Enter your Age', // Default border color
                          borderRadius: 8,
                          applySuffixIcon: true,
                          validator: (Value) {
                            return null;
                          },
                        ),
                        SizedBox(height: 8,),
                        TextFromFieldWithPrefixSuffix(
                          controller: customersDoctorDetailProvider.heightController,
                          hintText: 'Enter your Height', // Default border color
                          borderRadius: 8,
                          applySuffixIcon: true,
                          suffixIcon: Icon(Icons.height),
                          validator: (Value) {
                            return null;
                          },
                        ),
                        SizedBox(height: 8,),
                        TextFromFieldWithPrefixSuffix(
                          controller: customersDoctorDetailProvider.dateController,
                          hintText: 'Select Date', // Default border color
                          borderRadius: 8,
                          applySuffixIcon: true,
                          suffixIcon: InkWell(
                            onTap: (){
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2040),
                              ).then((value){
                                customersDoctorDetailProvider.setDate(value);
                                customersDoctorDetailProvider.setDatetime(formattedDate);
                                print(formattedDate);
                              });
                            },
                            child: Icon(
                              Icons.calendar_month,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          validator: (Value) {
                            return null;
                          },
                        ),
                        SizedBox(height: 8,),
                        TextFromFieldWithPrefixSuffix(
                          controller: customersDoctorDetailProvider.timeController,
                          hintText: 'Select Time', // Default border color
                          borderRadius: 8,
                          applySuffixIcon: true,
                          suffixIcon: InkWell(
                            onTap: (){
                              showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                              ).then((value){
                                customersDoctorDetailProvider.setTime(value);
                                customersDoctorDetailProvider.setTimeController(customersDoctorDetailProvider.todaysTime.format(context));
                              });
                            },
                            child: Icon(
                              Icons.watch_later_outlined,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          validator: (Value) {
                            return null;
                          },
                        ),
                        SizedBox(height: 8,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomElevatedButton(
                                onPressed: (){

                                },
                                backgroundColor: CustomColors.lightRed,
                                widget: CustomText(text: 'Back',isContent: true,),
                            ),
                            CustomElevatedButton(
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                                backgroundColor: CustomColors.lightBlue,
                                widget: CustomText(text: 'Ok',isContent: true,),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                }
              ),
            ),
          ),
        );
        },
    );
  }
}
