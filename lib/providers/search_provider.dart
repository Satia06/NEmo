import 'package:flutter/foundation.dart';

class SearchProvider with ChangeNotifier{
  bool? _isExpanded = false;
  bool? get isExpanded => _isExpanded;
  
  set isExpanded(bool? newValue){
    _isExpanded = newValue;
    notifyListeners();
  }
}