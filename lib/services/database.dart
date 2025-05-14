import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseMethod{
  Future addUser(String userId , Map<String ,dynamic> userInfoMap){
    return FirebaseFirestore.instance.collection("user").doc(userId).set(userInfoMap);
  }
}