import 'package:flutter/material.dart';
import 'package:semester_project/routes/route_generator_constants.dart';
import '../pages/auth_pages/forgot_passwordscreen.dart';
import '../pages/auth_pages/login_screen.dart';
import '../pages/auth_pages/signup_page.dart';
import '../pages/auth_pages/splash_screen.dart';
import '../pages/customer_pages/customer_dashboard/customer_dashboard.dart';
import '../pages/customer_pages/customer_doctors_page/doctor_decription_page.dart';
import '../pages/customer_pages/customer_doctors_page/doctor_list_page.dart';
import '../pages/customer_pages/customer_profile_page/profile_page.dart';
import '../pages/customer_pages/hospital_page_list/hospital_list_page.dart';
import '../pages/customer_pages/customer_treatment_page/treatment_page.dart';
import '../pages/error_page/error_page.dart';

class RouteGenerator{
  static Route<dynamic> generateRoutes(RouteSettings setting){
    final args = setting.arguments;
    switch(setting.name){
      case UserConstants.homePage :
        return MaterialPageRoute(
          builder: (_) => const MyHomePage(),
        );
      case UserConstants.logInPage :
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
        );
      case UserConstants.signUpPage :
        return MaterialPageRoute(
          builder: (_) => const SignupPage(),
        );
      case UserConstants.userDashboard :
        return MaterialPageRoute(
          builder: (_) => const CustomerDashboard(),
        );
      case UserConstants.forgotPasswordPage :
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordPage(),
        );
      case UserConstants.userTreatmentPage :
        return MaterialPageRoute(
          builder: (_) => const CustomerTreatmentPage(),
        );
      case UserConstants.userHospitalListPage :
        return MaterialPageRoute(
          builder: (_) => const CustomerHospitalSearchingPage(),
        );
      case UserConstants.userDoctorListPage :
        return MaterialPageRoute(
          builder: (_) => const CustomerDoctorListPage(),
        );
      case UserConstants.userProfilePage :
        return MaterialPageRoute(
          builder: (_) => const CustomerProfilePage(),
        );
      case UserConstants.userDoctorDescriptionPage :
        return MaterialPageRoute(
          builder: (_) => const CustomersDoctorDescriptionPage(),
        );


      default:
        return MaterialPageRoute(builder: (_) => ErrorPage());
    }
  }
}