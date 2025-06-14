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
   String _doctorName = '';
   String _doctorCategory = '';
   String _doctorDescription = '';
   String _doctorStartTime = '';
   String _doctorEndTime = '';


  List<dynamic> _hospitalList = [];
  List<dynamic> _searchResult = [];
  Map<String,dynamic> _doctorListResult = {};
  List<dynamic> _doctorList = [];

  TextEditingController get searchController => _searchController;

  String get Url => _Url;
  String get name => _name;
  String get description => _description;
  String get startTime => _startTime;
  String get endTime => _endTime;
  String get hospitalID => _hospitalID;

  String get doctorName => _doctorName;
  String get doctorCategory => _doctorCategory;
  String get doctorDescription => _doctorDescription;
  String get doctorStartTime => _doctorStartTime;
  String get doctorEndTime => _doctorEndTime;

  List<dynamic> get hospitalList => _hospitalList;
  List<dynamic> get searchResult => _searchResult;
  List<dynamic> get doctorList => _doctorList;
  Map<String,dynamic> get doctorListResult => _doctorListResult;


  void getHospitalList()async {
    Map<String, String> header = {
      'Content-Type': 'Application/json',
      'Authorization': 'Bearer $accessToken',
    };
    var response = await http.get(Uri.parse(_Url),headers: header);
    // print(response.statusCode);
    // print('response= ${response.body}');
    if (response.statusCode == 200) {
     List<dynamic> body = jsonDecode(response.body);
      _hospitalList = body;
     _searchResult = body;
     notifyListeners();
    }
  }

  void geDoctorByHospitalList()async {
    Map<String, String> header = {
      'Content-Type': 'Application/json',
      'Authorization': 'Bearer $accessToken',
    };
    var response = await http.get(Uri.parse('http://localhost:3000/api/healthcenters/$_hospitalID'),headers: header);
    print(response.statusCode);
    // print('response= ${response.body}');
    if (response.statusCode == 200) {
      Map<String,dynamic> body = jsonDecode(response.body);
      _doctorListResult = body;
      _doctorList = body['doctor_id'];
      print('Doctor List: $_doctorList');
      // print('response= ${_doctorList}');
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
  void setDoctorDetails(String name,String category,String description,String startTime,String endTime){
     _doctorName = name;
     _doctorCategory  = category;
     _doctorDescription = description;
     _doctorStartTime = startTime;
     _doctorEndTime = endTime;
     notifyListeners();
  }


}



