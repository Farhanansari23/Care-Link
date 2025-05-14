import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class CustomerProvider extends ChangeNotifier{

  final _searchController = TextEditingController();

  TextEditingController get searchController => _searchController;

}