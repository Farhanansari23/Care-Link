import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:semester_project/widgets/colors/custom_colors.dart';

import '../../../widgets/container/custom_container.dart';
import '../../../widgets/text/custom_text.dart';

class CustomerProfilePage extends StatefulWidget {
  const CustomerProfilePage({super.key});

  @override
  State<CustomerProfilePage> createState() => _CustomerProfilePageState();
}

class _CustomerProfilePageState extends State<CustomerProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroudColor,
      body: body(context),
    );
  }

  Widget body(context){
    return SafeArea(
      child: Column(
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
                CustomText(text: 'Profile', size: 24),
              ],
            ),
          ),
          SizedBox(height: 16,),
          CircleAvatar(
            radius: 64,
            backgroundColor: Colors.white,
          ),
          SizedBox(height: 24,),
          CustomContainer(
            horizontalMargin: 16,
              applyShadow: true,
              child: Column(
                children: [
                  Row(
                    children: [
                      CustomText(text: 'Name:',isContent: true,),
                      SizedBox(width: 8,),
                      CustomText(text: 'Farhan Ansari',isContent: true,),
                      Spacer(),
                      InkWell(
                        onTap: (){
                          showModalBottomSheet(
                              isScrollControlled: true,
                              useSafeArea: true,
                              context: context,
                              builder: (context) =>
                                  _profileBottomSheet(context));
                        },
                          child: FaIcon(FontAwesomeIcons.pen),
                      ),
                    ],
                  ),
                  SizedBox(height: 8,),
                  Row(
                    children: [
                      CustomText(text: 'Age:',isContent: true,),
                      SizedBox(width: 8,),
                      CustomText(text: '23 years',isContent: true,)
                    ],
                  ),
                  SizedBox(height: 8,),
                  Row(
                    children: [
                      CustomText(text: 'DOB: ',isContent: true,),
                      SizedBox(width: 8,),
                      CustomText(text: '2058-10-23',isContent: true,)
                    ],
                  ),
                  SizedBox(height: 8,),
                  Row(
                    children: [
                      CustomText(text: 'Height: ',isContent: true,),
                      SizedBox(width: 8,),
                      CustomText(text: '5\'7',isContent: true,)
                    ],
                  ),
                  SizedBox(height: 8,),
                  Row(
                    children: [
                      CustomText(text: 'Weight:',isContent: true,),
                      SizedBox(width: 8,),
                      CustomText(text: '82 kg',isContent: true,)
                    ],
                  ),
                  SizedBox(height: 8,),
                  Row(
                    children: [
                      CustomText(text: 'Email:',isContent: true,),
                      SizedBox(width: 8,),
                      CustomText(text: 'ansarifarhan2316@gmail.com',isContent: true,)
                    ],
                  ),
                ],
              ),
          ),
        ],
      ),
    );
  }
  //-------------------------------------------------------------------BottomSheet------------------------------------------------------------------------------------------------------------------------------------//

 Widget _profileBottomSheet(context){
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.90,
        child: Column(
          children: [
            CustomText(text: 'Name',isContent: true,)

          ],
        ),
      ),
    );
}
}
