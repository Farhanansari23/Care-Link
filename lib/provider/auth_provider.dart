import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class AuthenticationProvider extends ChangeNotifier {
  bool _obscure = true;
  bool _obscureForPwd = true;

  final _userEmailTextEditingController = TextEditingController();
  final _userPasswordTextEditingController = TextEditingController();

  final _signUpNameTextEditingController = TextEditingController();
  final _signUpEmailTextEditingController = TextEditingController();
  final _signUpPasswordTextEditingController = TextEditingController();

  final _emailRecoveryTextEditingController = TextEditingController();



  TextEditingController get userEmailTextEditingController => _userEmailTextEditingController;
  TextEditingController get userPasswordTextEditingController => _userPasswordTextEditingController;

  TextEditingController get signUpEmailTextEditingController => _signUpEmailTextEditingController;
  TextEditingController get signUpPasswordTextEditingController => _signUpPasswordTextEditingController;
  TextEditingController get signUpNameTextEditingController => _signUpNameTextEditingController;


  TextEditingController get emailRecoveryTextEditingController => _emailRecoveryTextEditingController;

  bool get obscure => _obscure;
  bool get obscureForPwd => _obscureForPwd;


  void toggleObscure() {
    _obscure = !_obscure;
    notifyListeners();
  }

  void setToggle(){
    _obscureForPwd = !_obscureForPwd;
    notifyListeners();
  }


}