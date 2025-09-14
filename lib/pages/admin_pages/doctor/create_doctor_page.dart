import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semester_project/widgets/container/custom_container.dart';
import 'package:semester_project/widgets/textfield/custom_textfield.dart';

import '../../../provider/admin_provider/create_doctorprofile_provider.dart';
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
            child: Consumer<CreateDoctorProfileProvider>(
              builder: (context,createDoctorProfileProvider,_) {
                return CustomContainer(
                    child: Column(
                      children: [
                          TextFromFieldWithPrefixSuffix(
                              controller: createDoctorProfileProvider.nameController,
                            glassEffect: true,
                            hintText: 'Enter your Name',
                            blurAmount: 4.0,
                            glassOpacity: 0.4,
                            borderColor: Colors.white, // Default border color
                            focusedBorderColor: Colors.blue, // Color when focused
                            enabledBorderColor: Colors.grey, // Color when enabled
                            errorBorderColor: Colors.red,
                            borderRadius: 16,
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.grey.shade600,
                            ),
                              validator: (value){
                                return null;
                              },
                          ),
                      ],
                    ));
              }
            ),
          ),
        ],
      ),
    );
  }
}
