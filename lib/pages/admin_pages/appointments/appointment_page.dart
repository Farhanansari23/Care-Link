import 'package:flutter/material.dart';

import '../../../routes/admin_route_generator.dart';
import '../../../widgets/colors/custom_colors.dart';
import '../../../widgets/container/custom_container.dart';
import '../../../widgets/text/custom_text.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
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
          title: Text(
            "Appointment Details",
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pop(AdminConstants.adminDashboard);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          backgroundColor: CustomColors.primaryColor,
          expandedHeight: 80,
          floating: true,
          stretch: true,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return Column(
              children: [
                SizedBox(height: 16,),
                CustomContainer(
                  verticalMargin: 0,
                  verticalPad: 16,
                  horizontalPad: 24,
                  horizontalMargin: 16,
                  // height: 0.16,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CustomText(text: 'Organization Name: ', isContent: true),
                          CustomText(text: 'koshi Hospital', isContent: true),
                        ],
                      ),
                      Row(
                        children: [
                          CustomText(text: 'Doctors Name: ', isContent: true),
                          CustomText(text: 'Shyam Rouniyar', isContent: true),
                        ],
                      ),
                      Row(
                        children: [
                          CustomText(text: 'Number of Appointment: ', isContent: true),
                          CustomText(text: '3', isContent: true),
                        ],
                      ),
                      Row(
                        children: [
                          CustomText(text: 'Location: ', isContent: true),
                          CustomText(
                            text: 'Biratnagar, Mahendra Chowk',
                            isContent: true,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
            childCount: 6,
          ),
        ),
      ],
    );
  }
}
