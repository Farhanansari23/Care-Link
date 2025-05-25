import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class CustomerHospitalDetailProvider extends ChangeNotifier {

  final _searchController = TextEditingController();

  TextEditingController get searchController => _searchController;
}