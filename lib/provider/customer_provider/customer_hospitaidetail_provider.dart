import 'dart:convert';
import 'package:cloudinary_url_gen/transformation/region.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../const.dart';
import '../../services/custom_services.dart';

class CustomerHospitalDetailProvider extends ChangeNotifier {

  final _searchController = TextEditingController();
  final String _Url = 'http://localhost:3000/api/healthcenters';
  List<dynamic> _hospitalList = [];
  List<dynamic> _searchResult = [];

  TextEditingController get searchController => _searchController;
  String get Url => _Url;
  List<dynamic> get hospitalList => _hospitalList;
  List<dynamic> get searchResult => _searchResult;


  void getHospitalList()async {
    Map<String, String> header = {
      'Content-Type': 'Application/json',
      'Authorization': 'Bearer $accessToken',
    };
    var response = await http.get(Uri.parse(_Url),headers: header);
    print(response.statusCode);
    // print('response= ${response.body}');
    if (response.statusCode == 200) {
     List<dynamic> body = jsonDecode(response.body);
      // print('response= ${response.body}');
      _hospitalList = body;
     _searchResult = body;
      print(_hospitalList);
     notifyListeners();
    }
  }


  void filterHospitals(String keyword) {
    String normalize(String text) => text.toLowerCase().replaceAll(RegExp(r'\s+'), ' ').trim();
    String normalizedKeyword = normalize(keyword);
    if (keyword.isEmpty) {
      _searchResult = _hospitalList;
    } else {
      _searchResult = _hospitalList.where((hospital) {
        String name = hospital['name']?.toString().toLowerCase() ?? '';
        return name.contains(normalizedKeyword);
      }).toList();
    }
    // print('Search Result = $_searchResult');
    notifyListeners();
  }


}



