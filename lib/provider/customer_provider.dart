import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class CustomerProvider extends ChangeNotifier{

  List<Map<String,dynamic>> _doctorList = [
    {"categoryName": "Neurologist","categoryImg": "assets/images/Neurologist.png"},
    {"categoryName": "Cardiologist","categoryImg": "assets/images/Cardiologist.png"},
    {"categoryName": "Orthopedist","categoryImg": "assets/images/orthopedist.png"},
  ];

  final _searchController = TextEditingController();

  List<Map<String,dynamic>> get doctorList => _doctorList;

  TextEditingController get searchController => _searchController;

}