import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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

  List<Map<String,dynamic>> healthCenter = [
    {
      'Organization Name':'Koshi Hospital',
      'Number':0714707986,
      'Location':'Biratnagar-10',
      'Details':'Best Hospital Near you for every concern and with the best facilities'
    },
    {
      'Organization Name':'Nobel Hospital',
      'Number':0724907986,
      'Location':'Biratnagar,AirportRoad',
      'Details':'Best Hospital Near you for every concern and with the best facilities'
    },
    {
      'Organization Name':'Birat Teaching Hospital',
      'Number':0722307986,
      'Location':'Biratnagar-8',
      'Details':'Best Hospital Near you for every concern and with the best facilities'
    },
    {
      'Organization Name':'Birta Nursing Hospital',
      'Number':0623407986,
      'Location':'Biratnagar,Bargachhi',
      'Details':'Best Hospital Near you for every concern and with the best facilities'
    },
    {
      'Organization Name':'Neuro Hospital',
      'Number':0214707865,
      'Location':'Biratnagar-15',
      'Details':'Best Hospital Near you for every concern and with the best facilities'
    },
  ];

   void deleteOrganization(int index){
     setState(() { // ← Added setState
       healthCenter.removeAt(index);
     });
  }
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
            "Health center Details",
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
                Slidable(
                  endActionPane: ActionPane(
                      motion: StretchMotion(),
                      children: [
                          SlidableAction(
                            onPressed: (context) => deleteOrganization(index),
                          icon: Icons.delete,
                          borderRadius: BorderRadius.circular(8),
                          backgroundColor: Colors.red.shade800,
                          ),
                      ]),
                  child: CustomContainer(
                    verticalMargin: 0,
                    verticalPad: 16,
                    horizontalPad: 8,
                    horizontalMargin: 16,
                    // height: 0.16,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CustomText(text: 'Organization Name: ', isContent: true),
                            CustomText(text: healthCenter[index]['Organization Name'], isContent: true),
                          ],
                        ),
                        Row(
                          children: [
                            CustomText(text: 'Number: ', isContent: true),
                            CustomText(text: healthCenter[index]['Number'].toString(), isContent: true),
                          ],
                        ),
                        Row(
                          children: [
                            CustomText(text: 'Location: ', isContent: true),
                            CustomText(text: healthCenter[index]['Location'], isContent: true),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                                child: CustomText(
                                  text: 'Details: ',
                                    isContent: true,
                                  textOverflow: TextOverflow.ellipsis,
                                ),
                            ),
                            Expanded(
                              flex: 3,
                              child: CustomText(
                                text: healthCenter[index]['Details'],
                                isContent: true,
                                textOverflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
            childCount: healthCenter.length,
          ),
        ),
      ],
    );
  }
}
