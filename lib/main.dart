import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semester_project/pages/auth_pages/splash_screen.dart';
import 'package:semester_project/pages/customer_pages/customer_dashboard.dart';
import 'package:semester_project/provider/auth_provider.dart';
import 'package:semester_project/provider/customer_provider.dart';
import 'package:semester_project/routes/route_generator.dart';
import 'package:semester_project/routes/route_generator_constants.dart';

void main(){
  // WidgetsFlutterBinding.ensureInitialized(); // Required for async init
  // await Firebase.initializeApp();// Add this line
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (context) => CustomerProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: UserConstants.homePage,
        onGenerateRoute: RouteGenerator.generateRoutes,
        home: const MyHomePage(),
      ),
    );
  }
}


