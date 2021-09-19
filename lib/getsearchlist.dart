import 'package:nemo/drivenew/googledrive.dart';
import 'package:googleapis/sheets/v4.dart' as SheetsV4;
import 'package:nemo/homepage.dart';

List<List<String>> searchdata = [];
List<List<String>> entitydata = [];

Future getsearchitems(var _client) async {
  entitydata.clear();
  final sheetsApi = SheetsV4.SheetsApi(_client);
  //final gsheets = GSheets(widget._client);
  final ss = await sheetsApi.spreadsheets
      .get('1Y6XyOT-5-LjgzDLLxCRqi3uf6kZUDTB43gTh_qd1Ve0',
          //'10bE_foyxylAfJ07lLeB6-ezLoR1wLrRNVUxg1Ard6sM',
          includeGridData: true);
  List<String> traitdata = [];
  traitdata.clear();
  for (var i = 0; i < ss.sheets![0].data![0].rowData!.length; i++) {
    for (var j = 0;
        j < ss.sheets![0].data![0].rowData![i].values!.length;
        j++) {
      // print(ss.sheets![0].data![0].rowData![i].values![j].formattedValue
      //     .toString());
      if (ss.sheets![0].data![0].rowData![i].values![j].formattedValue !=
          null) {
        traitdata.add(ss
            .sheets![0].data![0].rowData![i].values![j].formattedValue
            .toString());
      }
    }
    //print(traitdata);
    entitydata.add(traitdata.toList());
    traitdata.clear();
  }

  entitydata.reversed;
  //print(entitydata);
}

void searchOperation(String searchText) {
  searchdata.clear();
  if (isSearching != null) {
    for (int i = 0; i < entitydata.length; i++) {
      if (entitydata[i][0].toLowerCase().contains(searchText.toLowerCase())) {
        List<String> _temp = [];
        _temp.add(entitydata[i][0].toString());
        _temp.add(entitydata[i][0].toString()); //the actual string here
        searchdata.add(_temp.toList());
        //print(_temp);
        _temp.clear(); //or just take the number
      }
      for (int j = 1; j < entitydata[i].length; j++) {
        String data = entitydata[i][j];
        if (data.toLowerCase().contains(searchText.toLowerCase())) {
          List<String> _temp = [];
          _temp.add(entitydata[i][0].toString());
          _temp.add(entitydata[i][j] +
              " ( " +
              entitydata[i][0] +
              " )"); //the actual string here
          searchdata.add(_temp.toList());
          //print(_temp);
          _temp.clear(); //or just take the number
        }
      }
    }
  }
  //print(searchdata.toList);
  //searchdata remove dublicate
}
