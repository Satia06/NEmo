import 'package:flutter/cupertino.dart';
import 'package:nemo/drivenew/googledrive.dart';

class FolderData {
  String id;
  String kind;
  String name;
  String mineType;

  FolderData(
      {required this.id,
      required this.kind,
      required this.name,
      required this.mineType});

  factory FolderData.fromJson(Map<String, dynamic> json) {
    return FolderData(
        id: json["id"],
        kind: json["kind"],
        name: json["name"],
        mineType: json["mineType"]);
  }
}
// var list = mainFolderList["files"] as List;
// List<FolderData> actualsomeList =
// list.map((i) => FolderData.fromJson(i)).toList();
// print(actualsomeList);
