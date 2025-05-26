import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semester_project/pages/auth_pages/splash_screen.dart';
import 'package:semester_project/pages/customer_pages/customer_dashboard/customer_dashboard.dart';
import 'package:semester_project/provider/auth_provider.dart';
import 'package:semester_project/provider/customer_doctorsdetail_provider.dart';
import 'package:semester_project/provider/customer_hospitaidetail_provider.dart';
import 'package:semester_project/provider/customer_provider.dart';
import 'package:semester_project/routes/route_generator.dart';
import 'package:semester_project/routes/route_generator_constants.dart';

void main(){
  // WidgetsFlutterBinding.ensureInitialized(); // Required for async init
  // await Firebase.initializeApp();// Add this line
  runApp(MyApp());
}

// class AppInitializer extends StatelessWidget {
//   // Create the initialization Future outside of build
//   final Future<FirebaseApp> _initialization = Firebase.initializeApp();
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       // Initialize FlutterFire:
//       future: _initialization,
//       builder: (context, snapshot) {
//         // Check for errors
//         if (snapshot.hasError) {
//           // You can return a more sophisticated error widget here
//           return MaterialApp(
//             home: Scaffold(
//               body: Center(
//                 child: Text('Error initializing Firebase: ${snapshot.error}'),
//               ),
//             ),
//           );
//         }
//
//         // Once complete, show your application
//         if (snapshot.connectionState == ConnectionState.done) {
//           return MyApp(); // Your main application
//         }
//
//         // Otherwise, show something whilst waiting for initialization to complete
//         // This could be your SplashScreen if it doesn't depend on Firebase,
//         // or a simple CircularProgressIndicator.
//         return MaterialApp(
//           home: Scaffold(
//             body: Center(
//               child: CircularProgressIndicator(), // Or your SplashScreen
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (context) => CustomerProvider()),
        ChangeNotifierProvider(create: (context) => CustomerHospitalDetailProvider()),
        ChangeNotifierProvider(create: (context) => CustomersDoctorDetailProvider()),
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


