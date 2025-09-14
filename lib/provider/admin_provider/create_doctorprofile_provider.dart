import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class CreateDoctorProfileProvider extends ChangeNotifier{

  final _nameController = TextEditingController();
  final _genderController = TextEditingController();
  final _ageController = TextEditingController();
  final _heightController = TextEditingController();

  TextEditingController get nameController => _nameController;
  TextEditingController get genderController => _genderController;
  TextEditingController get ageController => _ageController;
  TextEditingController get heightController => _heightController;
}