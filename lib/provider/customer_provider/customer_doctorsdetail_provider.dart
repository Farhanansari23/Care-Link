import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:semester_project/services/custom_services.dart';

class CustomersDoctorDetailProvider extends ChangeNotifier {

  late DateTime _selectedDate = DateTime.now();
  TimeOfDay _todaysTime = TimeOfDay(hour: 8, minute: 30);

  List<String> _gender = ["Male", "Female", "Others"];
  String _selectedGender = '';
  String _defaultGenderValue = 'Male';

  final _nameController = TextEditingController();
  final _genderController = TextEditingController();
  final _ageController = TextEditingController();
  final _heightController = TextEditingController();
  final _searchController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();

  DateTime get selectedDate => _selectedDate;
  TimeOfDay get todaysTime => _todaysTime;

  List<String> get gender => _gender;
  String get selectedGender => _selectedGender;
  String get defaultGenderValue => _defaultGenderValue;

  TextEditingController get nameController => _nameController;
  TextEditingController get genderController => _genderController;
  TextEditingController get ageController => _ageController;
  TextEditingController get heightController => _heightController;

  TextEditingController get searchController => _searchController;
  TextEditingController get dateController => _dateController;
  TextEditingController get timeController => _timeController;

  void setDate(value){
    _selectedDate = value;
    notifyListeners();
  }
   void setDatetime(date){
     _dateController.text = date;
     notifyListeners();
   }

   void setTime(value){
     _todaysTime = value;
     notifyListeners();
   }

    void setTimeController(time){
      _timeController.text = time;
      notifyListeners();
    }

  void setGender(gender) {
    _selectedGender = gender;
    notifyListeners();
  }

}