import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semester_project/widgets/colors/custom_colors.dart';
import 'package:semester_project/widgets/container/custom_container.dart';
import 'package:semester_project/widgets/drawer/admin_drawer.dart';

import '../../provider/customer_provider/customer_provider.dart';
import '../../widgets/text/custom_text.dart';
import '../../widgets/textfield/custom_textfield.dart';

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
                backgroundColor: Colors.deepPurple,
                expandedHeight: 200,
                floating: true,
                // flexibleSpace: FlexibleSpaceBar(
                //   background: Container(
                //     color: Colors.white,
                //   ),
                // ),
              ),
              SliverToBoxAdapter(
                child:  CustomContainer(
                  verticalMargin: 16,
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
              ),
              SliverToBoxAdapter(
                child: SizedBox(
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
              ),


              SliverToBoxAdapter(
                child: CustomContainer(
                    verticalMargin: 16,
                    height: 0.2,
                    child: CustomText(text: 'Upcoming Appointment',size: 20,fontWeight: FontWeight.w600,)),
              ),
              SliverToBoxAdapter(
                child: CustomContainer(
                    verticalMargin: 16,
                    height: 0.2,
                    child: CustomText(text: 'Upcoming Appointment',size: 20,fontWeight: FontWeight.w600,)),
              ),
              SliverToBoxAdapter(
                child: CustomContainer(
                    verticalMargin: 16,
                    height: 0.2,
                    child: CustomText(text: 'Upcoming Appointment',size: 20,fontWeight: FontWeight.w600,)),
              ),
              SliverToBoxAdapter(
                child: CustomContainer(
                    verticalMargin: 16,
                    height: 0.2,
                    child: CustomText(text: 'Upcoming Appointment',size: 20,fontWeight: FontWeight.w600,)),
              ),
              SliverToBoxAdapter(
                child: CustomContainer(
                    verticalMargin: 16,
                    height: 0.2,
                    child: CustomText(text: 'Upcoming Appointment',size: 20,fontWeight: FontWeight.w600,)),
              ),
            ],
          );
        }
    );
  }
}
