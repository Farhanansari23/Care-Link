import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:semester_project/const.dart';
import 'package:semester_project/routes/route_generator_constants.dart';
import 'package:semester_project/widgets/container/custom_container.dart';
import 'package:semester_project/widgets/drawer/Custom_drawer.dart';
import 'package:semester_project/widgets/text/custom_text.dart';
import '../../../provider/customer_provider/customer_hospitaidetail_provider.dart';
import '../../../widgets/colors/custom_colors.dart';
import '../../../widgets/glass_box/custom_glassbox.dart';
import '../../../widgets/textfield/custom_textfield.dart';

class CustomerHospitalSearchingPage extends StatefulWidget {
  const CustomerHospitalSearchingPage({super.key});

  @override
  State<CustomerHospitalSearchingPage> createState() => _CustomerHospitalSearchingPageState();
}

class _CustomerHospitalSearchingPageState extends State<CustomerHospitalSearchingPage> {

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
      drawer: CustomDrawer(isHospitalActive: true,),
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
                        Navigator.pop(context);
                      },
                      child: CircleAvatar(
                        child: Icon(Icons.arrow_back_ios_new),
                        radius: 24,
                        backgroundColor: Colors.white,
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.24,),
                    CustomText(text: 'Hospitals', size: 24),
                  ],
                ),
              ),
                CustomContainer(
                  verticalPad: 0,
                  color: CustomColors.backgroudColor,
                    child: TextFromFieldWithPrefixSuffix(
                      hintText: 'Search Hospital',
                      borderColor: Colors.white,
                      fillColor: Colors.white,// Default border color
                      borderRadius: 16,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey.shade600,
                      ),
                      controller: customerHospitalDetailProvider.searchController,
                      onChanged: (value){
                        customerHospitalDetailProvider.filterHospitals( value!);
                      },
                      validator: (value) => null,
                    ),
                ),
               Expanded(
                 child: ListView.builder(
                   itemCount: customerHospitalDetailProvider.searchResult.length,
                     itemBuilder: (context,index){
                     String name = customerHospitalDetailProvider.searchResult[index]['name'];
                     final hospital = customerHospitalDetailProvider.searchResult[index];
                     final selectedHospitalId = hospital['_id'];
                     String location = customerHospitalDetailProvider.searchResult[index]['location'].toString().split('.')[0];
                     String contact_detail = customerHospitalDetailProvider.searchResult[index]['contact_detail'].toString();
                   return  Column(
                     children: [
                       SizedBox(height: 16,),
                       InkWell(
                         onTap: (){
                           customerHospitalDetailProvider.setHospitalId(selectedHospitalId);
                           // print(selectedHospitalId);
                            Navigator.of(context).pushNamed(UserConstants.userDoctorListPage);
                         },
                         child: CustomContainer(
                           horizontalMargin: 16,
                           color: CustomColors.lightBlue,
                           child: Column(
                             children: [
                               Row(
                                 children: [
                                   CircleAvatar(radius: 48,backgroundColor: Colors.white,),
                                   SizedBox(width: 24,),
                                   Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       CustomText(text: name,size: 18,fontWeight: FontWeight.w600,color: Colors.white,),
                                       SizedBox(height: 16,),
                                       ConstrainedBox(
                                         constraints: BoxConstraints(maxWidth:  MediaQuery.of(context).size.width * 0.9),
                                         child: Container(
                                           child: GlassBox(
                                               height: MediaQuery.of(context).size.height * 0.032,
                                               width: MediaQuery.of(context).size.width * 0.56,
                                               borderRadius: 8,
                                               child: Row(
                                                 children: [
                                                  SizedBox(width: 8,),
                                                   Center(
                                                       child: CustomText(
                                                         text: location,
                                                         color: Colors.white,
                                                         size: 16,
                                                         fontWeight: FontWeight.w600,),
                                                   ),
                                                 ],
                                               )),
                                         ),
                                       ),
                                       SizedBox(height: 8,),
                                       Container(
                                         child: GlassBox(
                                             height: MediaQuery.of(context).size.height * 0.032,
                                             width: MediaQuery.of(context).size.width * 0.56,
                                             borderRadius: 8,
                                             child: Row(
                                               children: [
                                                 SizedBox(width: 8,),
                                                 Center(child: CustomText(text: 'Phone: ${contact_detail}',color: Colors.white,size: 16,fontWeight: FontWeight.w600,))
                                               ],
                                             )),
                                       ),
                                     ],
                                   ),
                                 ],
                               ),
                             ],
                           ),
                         ),
                       ),
                     ],
                   );
                 }),
               )

            ],
          );
        }
      ),
    );
  }
}
