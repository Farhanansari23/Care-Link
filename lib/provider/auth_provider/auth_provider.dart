import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class AuthenticationProvider extends ChangeNotifier {
  bool _obscure = true;
  bool _obscureForPwd = true;
  String _userName = '';
  List<String> _gender = ["Male", "Female", "Others"];
  String _selectedGender = '';
  String _defaultGenderValue = 'Male';

  final _userEmailTextEditingController = TextEditingController();
  final _userPasswordTextEditingController = TextEditingController();

  final _signUpNameTextEditingController = TextEditingController();
  final _signUpEmailTextEditingController = TextEditingController();
  final _signUpPasswordTextEditingController = TextEditingController();
  final _signUpUserTypeTextEditingController = TextEditingController();
  final _signUpUserGenderTextEditingController = TextEditingController();
  final _signUpUserHeightTextEditingController = TextEditingController();
  final _signUpUserWeightTextEditingController = TextEditingController();
  final _signUpUserDobTextEditingController = TextEditingController();
  final _signUpUserPhoneTextEditingController = TextEditingController();
  final _signUpUserAddressTextEditingController = TextEditingController();


  final _emailRecoveryTextEditingController = TextEditingController();



  TextEditingController get userEmailTextEditingController => _userEmailTextEditingController;
  TextEditingController get userPasswordTextEditingController => _userPasswordTextEditingController;

  TextEditingController get signUpEmailTextEditingController => _signUpEmailTextEditingController;
  TextEditingController get signUpPasswordTextEditingController => _signUpPasswordTextEditingController;
  TextEditingController get signUpNameTextEditingController => _signUpNameTextEditingController;
  TextEditingController get signUpUserTypeTextEditingController => _signUpUserTypeTextEditingController;
  TextEditingController get signUpUserGenderTextEditingController => _signUpUserGenderTextEditingController;
  TextEditingController get signUpUserHeightTextEditingController => _signUpUserHeightTextEditingController;
  TextEditingController get signUpUserWeightTextEditingController => _signUpUserWeightTextEditingController;
  TextEditingController get signUpUserDobTextEditingController => _signUpUserDobTextEditingController;
  TextEditingController get signUpUserPhoneTextEditingController => _signUpUserPhoneTextEditingController;
  TextEditingController get signUpUserAddressTextEditingController => _signUpUserAddressTextEditingController;


  TextEditingController get emailRecoveryTextEditingController => _emailRecoveryTextEditingController;

  bool get obscure => _obscure;
  bool get obscureForPwd => _obscureForPwd;

  String get userName => _userName;

  List<String> get gender => _gender;
  String get selectedGender => _selectedGender;
  String get defaultGenderValue => _defaultGenderValue;


  void toggleObscure() {
    _obscure = !_obscure;
    notifyListeners();
  }

  void setToggle(){
    _obscureForPwd = !_obscureForPwd;
    notifyListeners();
  }
  void setName(name){
    _userName = name;
    notifyListeners();
  }

  void setGender(gender) {
    _selectedGender = gender;
    notifyListeners();
  }

}