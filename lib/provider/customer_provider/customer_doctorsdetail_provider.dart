import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class CustomersDoctorDetailProvider extends ChangeNotifier {

  late DateTime _selectedDate;
  final _searchController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();

  TextEditingController get searchController => _searchController;
  TextEditingController get dateController => _dateController;
  TextEditingController get timeController => _timeController;

}