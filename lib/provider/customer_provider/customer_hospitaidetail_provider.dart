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
   String _name = '';
   String _description = '';
   String _startTime = '';
   String _endTime = '';
   String _hospitalID = '';
  List<dynamic> _hospitalList = [];
  List<dynamic> _searchResult = [];

  TextEditingController get searchController => _searchController;

  String get Url => _Url;
  String get name => _name;
  String get description => _description;
  String get startTime => _startTime;
  String get endTime => _endTime;
  String get hospitalID => _hospitalID;

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
     // final hospital = body[0];
      // print('response= ${response.body}');
      _hospitalList = body;
     _searchResult = body;
     // _name = hospital['doctor_id'][0]['name'];
     // _description = hospital['doctor_id'][0]['description'];
     //  _startTime = hospital['doctor_id'][0]['schedule'][0]['time_slots'][0]['startTime'].toString();
     //  _endTime = hospital['doctor_id'][0]['schedule'][0]['time_slots'][0]['endTime'].toString();
      // print(_hospitalList);
      // print(_name);
      // print(_description);
      // print(_startTime);
      // print(_endTime);
     notifyListeners();
    }
  }

  void setHospitalId(String ID){
    _hospitalID = ID;
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

  void clearCache() {
    _hospitalList = []; // Reset to empty state
    notifyListeners(); // Trigger UI update
  }


}



