import 'package:flutter/material.dart';
import 'package:semester_project/routes/admin_route_generator.dart';
import 'package:semester_project/widgets/colors/custom_colors.dart';
import 'package:semester_project/widgets/container/custom_container.dart';

import '../../../widgets/text/custom_text.dart';

class AdminHealthCenterList extends StatefulWidget {
  const AdminHealthCenterList({super.key});

  @override
  State<AdminHealthCenterList> createState() => _AdminHealthCenterListState();
}

class _AdminHealthCenterListState extends State<AdminHealthCenterList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroudColor,
      body: _body(context),
    );
  }

  Widget _body(context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text("Health center Details",style: TextStyle(color: Colors.white),),
          leading: IconButton(
            color: Colors.white,
            onPressed: () {
             Navigator.of(context).pop(AdminConstants.adminDashboard);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          backgroundColor: Colors.deepPurple,
          expandedHeight: 80,
          floating: true,
          stretch: true,
        ),
        SliverToBoxAdapter(
          child: CustomContainer(
            verticalMargin: 16,
            verticalPad: 8,
            horizontalMargin: 16,
            height: 0.16,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomText(text: 'Name: ', isContent: true),
                    CustomText(text: 'koshi Hospital', isContent: true),
                  ],
                ),
                Row(
                  children: [
                    CustomText(text: 'Name: ', isContent: true),
                    CustomText(text: 'Golden Hospital', isContent: true),
                  ],
                ),
                Row(
                  children: [
                    CustomText(text: 'Name: ', isContent: true),
                    CustomText(text: 'Nobel Hospital', isContent: true),
                  ],
                ),
                Row(
                  children: [
                    CustomText(text: 'Name: ', isContent: true),
                    CustomText(
                      text: 'Birat Teaching Hospital',
                      isContent: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
