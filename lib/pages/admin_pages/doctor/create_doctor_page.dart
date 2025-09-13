import 'package:flutter/material.dart';
import 'package:semester_project/widgets/container/custom_container.dart';

import '../../../routes/admin_route_generator.dart';
import '../../../widgets/colors/custom_colors.dart';

class CreateDoctorPage extends StatefulWidget {
  const CreateDoctorPage({super.key});

  @override
  State<CreateDoctorPage> createState() => _CreateDoctorPageState();
}

class _CreateDoctorPageState extends State<CreateDoctorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text("Add New Doctor ",style: TextStyle(color: Colors.white),),
            leading: IconButton(
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).pop(AdminConstants.adminDashboard);
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
            backgroundColor: CustomColors.primaryColor,
            expandedHeight: 60,
            floating: true,
            stretch: true,
          ),
          SliverToBoxAdapter(
            child: CustomContainer(
                child: Column(
                  children: [

                  ],
                )),
          ),
        ],
      ),
    );
  }
}
