import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class CustomerProfileProvider extends ChangeNotifier {

  String? _imageUrl;

  final _nameTextController = TextEditingController();
  final _ageTextController = TextEditingController();
  final _dobTextController = TextEditingController();
  final _heightTextController = TextEditingController();
  final _weightTextController = TextEditingController();
  final _emailTextController = TextEditingController();

  String? get imageUrl => _imageUrl;

  TextEditingController get nameTextController => _nameTextController;
  TextEditingController get ageTextController => _ageTextController;
  TextEditingController get dobTextController => _dobTextController;
  TextEditingController get heightTextController => _heightTextController;
  TextEditingController get weightTextController => _weightTextController;
  TextEditingController get emailTextController => _emailTextController;

  void setImageUrl(String url) {
    _imageUrl = url;
    notifyListeners();
  }

  void clearImage() {
    _imageUrl = null;
    notifyListeners();
  }
}