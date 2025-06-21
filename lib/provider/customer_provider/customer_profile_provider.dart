import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomerProfileProvider extends ChangeNotifier {

  String? _imageUrl;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

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

  Future<void> loadImage() async {
    final url = await _storage.read(key: 'profile_image_url');
    if (url != null) {
      _imageUrl = url;
      notifyListeners();
    }
  }

  Future<void> setImageUrl(String url) async {
    _imageUrl = url;
    await _storage.write(key: 'profile_image_url', value: url);
    notifyListeners();
  }


  Future<void> clearImage() async {
    _imageUrl = null;
    await _storage.delete(key: 'profile_image_url');
    notifyListeners();
  }
}