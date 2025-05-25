import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class CustomersDoctorDetailProvider extends ChangeNotifier {

  late DateTime _selectedDate;
  final _searchController = TextEditingController();

  TextEditingController get searchController => _searchController;
  DateTime get selectedDate => _selectedDate;

  void setDateTime(date){
    _selectedDate = date;
  }
}