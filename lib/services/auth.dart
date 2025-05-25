import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../pages/customer_pages/customer_dashboard/customer_dashboard.dart';
import '../routes/route_generator_constants.dart';
import 'database.dart';

class AuthMethods{
  final FirebaseAuth auth = FirebaseAuth.instance;

  getCurrentUser()async{
    return await auth.currentUser;
  }

  signInWithGoogle(BuildContext context)async{
    final FirebaseAuth firebaseAuth = await FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication? googleSignInAuthentication = await googleSignInAccount?.authentication;
    final AuthCredential? credential = await GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication?.idToken,
      accessToken: googleSignInAuthentication?.accessToken,
    );

    UserCredential result = await firebaseAuth.signInWithCredential(credential!);
    User? usersDetails = result.user;
    if(result != null){
      Map<String,dynamic> userInfoMap = {
        "email":usersDetails!.email,
        "name": usersDetails.displayName,
        'imageUrl':usersDetails.photoURL,
        "id": usersDetails.uid,
      };
      await DataBaseMethod().addUser(usersDetails.uid, userInfoMap).then((value){
        Navigator.of(context).pushNamed(UserConstants.userDashboard);
      });
    }
  }

}