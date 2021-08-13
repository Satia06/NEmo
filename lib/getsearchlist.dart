import 'package:nemo/drivenew/googledrive.dart';

List<String> searchdata = [];

Future getsearchitems(var _list) async {
  searchdata.clear();
  for (var j = 0; j < _list.length; j++) {
    searchdata.add(_list[j]["name"]);
  }
}
