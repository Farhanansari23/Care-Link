import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semester_project/routes/admin_route_generator.dart';
import 'package:semester_project/widgets/colors/custom_colors.dart';
import 'package:semester_project/widgets/container/custom_container.dart';
import 'package:semester_project/widgets/drawer/admin_drawer.dart';
import '../../../provider/customer_provider/customer_provider.dart';
import '../../../widgets/text/custom_text.dart';
import '../../../widgets/textfield/custom_textfield.dart';


class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: CustomColors.backgroudColor,
      body: _body(context),
      drawer: AdminDrawer(
        isHomeActive: true,
      ),
    );
  }


  Widget _body(context){
    return Consumer<CustomerProvider>(
        builder: (context,customerProvider,_) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                title: Text("Admin Dashboard",style: TextStyle(color: Colors.white),),
                leading: IconButton(
                  color: Colors.white,
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Icon(Icons.menu),
                ),
                backgroundColor: CustomColors.primaryColor,
                expandedHeight: 80,
                floating: true,
                stretch: true,
              ),
              // SizedBox(height: 8,),
              SliverToBoxAdapter(
                child: InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, AdminConstants.adminHealthCenterList);
                  },
                  child: CustomContainer(
                    verticalMargin:16,
                    verticalPad: 8,
                    horizontalMargin: 16,
                    color:Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(text: 'List of Hospitals',isHeading: true,),
                        SizedBox(height: 16,),
                        CustomText(text: 'koshi Hospital',),
                        CustomText(text: 'Golden Hospital',),
                        CustomText(text: 'Nobel Hospital',),
                        CustomText(text: 'Birat Teaching Hospital',),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child:  InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, AdminConstants.adminDoctorsAppointmentDetails);
                  },
                  child: CustomContainer(
                    verticalMargin: 8,
                    verticalPad: 8,
                    horizontalMargin: 16,
                    color:Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(text: 'Number of Appointments',isHeading: true,),
                        SizedBox(height: 16,),
                        Row(
                          children: [
                            CustomText(text: 'Dr Ghanshyam Jha: ',isContent: true,),
                            CustomText(text: '6',isContent: true,),
                          ],
                        ),
                        Row(
                          children: [
                            CustomText(text: 'Dr Chandrapal Jha: ',isContent: true,),
                            CustomText(text: '4',isContent: true,),
                          ],
                        ),
                        Row(
                          children: [
                            CustomText(text: 'Dr Rajesh Yadav: ',isContent: true,),
                            CustomText(text: '2',isContent: true,),
                          ],
                        ),
                        Row(
                          children: [
                            CustomText(text: 'Dr Sushil karna',isContent: true,),
                            CustomText(text: '3',isContent: true,),
                          ],
                        ),
                        Row(
                          children: [
                            CustomText(text: 'Dr Anju Dev: ',isContent: true,),
                            CustomText(text: '3',isContent: true,),
                          ],
                        ),
                        Row(
                          children: [
                            CustomText(text: 'Dr Anand Rouniyar: ',isContent: true,),
                            CustomText(text: '3',isContent: true,),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            ],
          );
        }
    );
  }
}
