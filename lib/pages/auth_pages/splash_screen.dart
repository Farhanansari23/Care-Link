import 'dart:async';

import 'package:flutter/material.dart';
import '../../classes/secure_storage.dart';
import '../../routes/route_generator_constants.dart';
import '../../widgets/buttons/custom_elevatedbutton.dart';
import '../../widgets/colors/custom_colors.dart';
import '../../widgets/text/custom_text.dart';
import '../customer_pages/customer_dashboard/customer_dashboard.dart';
import 'login_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkSessionAndNavigate();
  }

  Future<void> checkSessionAndNavigate() async {
    await SessionController.instance.loadSession();

    final hasToken = SessionController.instance.token != null;

    await SessionController.instance.loadSession();

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return; // Prevent errors if widget is disposed
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => hasToken
              ? const CustomerDashboard()
              : const LoginPage(),
        ),
      );
    });

    // Future.delayed(const Duration(seconds: 2), () {
    //   if (hasToken) {
    //     Navigator.of(context).pushReplacement(
    //       MaterialPageRoute(builder: (context) => const CustomerDashboard()),
    //     );
    //   } else {
    //     Navigator.of(context).pushReplacement(
    //       MaterialPageRoute(builder: (context) => const LoginPage()),
    //     );
    //   }
    // });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _appBar(context),
      body: _body(context),
    );
  }


  Widget _body(context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            CustomColors.primaryColor,
            CustomColors.midColor,
            CustomColors.primaryColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.topRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              CustomText(
                text: 'Welcome To Care Link',color: Colors.white,size: 32,fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 8,),
              CustomText(
                text:
                'Create you account to get started on your health and happiness journey.',
                color: Colors.white,
              ),
            ],
          ),
          Container(
            child: Image.asset(
              'assets/images/heart1.png',
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * 0.32,
            ),
          ),
          Column(
            children: [
              CustomElevatedButton(
                borderRadius: 32,
                width: 0.80,
                height: MediaQuery.of(context).size.height * 0.056,
                onPressed: () {
                  Navigator.of(context).pushNamed(UserConstants.logInPage);
                },
                widget: CustomText(
                  text: 'Login',
                  isContent: true,
                  color: Colors.white,
                ),
                borderColor: Colors.white,
              ),
              SizedBox(height: 24,),
              CustomElevatedButton(
                borderRadius: 32,
                width: 0.80,
                height: MediaQuery.of(context).size.height * 0.056,
                onPressed: () {
                  Navigator.of(context).pushNamed(UserConstants.signUpPage);
                },
                widget: CustomText(
                  text: 'Sign Up',
                  isContent: true,
                  color: Colors.white,
                ),
                borderColor: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}