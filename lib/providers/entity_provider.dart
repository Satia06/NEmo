// import 'package:flutter/cupertino.dart';
// import 'package:nemo/model/entity.dart';
// import 'package:googleapis/drive/v3.dart' as drive;
//
// class EntityProvider extends ChangeNotifier {
//   List<Entity>? _listOfEntities  = [];
//   List<String>? _listOfNames = [];
//
//   List<Entity>? get listOfEntities => _listOfEntities;
//   List<String>? get listOfNames => _listOfNames;
//
//   set listOfEntities(List<Entity>? newList){
//     _listOfEntities = newList;
//     notifyListeners();
//   }
//
//   void addEntity(Entity? newEntity) {
//     _listOfEntities!.add(newEntity ?? Entity());
//     _listOfNames!.add(newEntity?.name ?? "");
//     notifyListeners();
//   }
//   void setDescription(Entity entity, String? desc){
//     entity.description = desc;
//     notifyListeners();
//   }
//
//   void setVideoList(Entity entity, List<drive.File>? videos) {
//     entity.videoFiles = videos;
//     notifyListeners();
//   }
//
//   void setImageList(Entity entity, List<drive.File>? images) {
//     entity.imageFiles = images;
//     notifyListeners();
//   }
//
//   int? findEntityName(String? name){
//     int index = 0;
//     for(var entity in _listOfEntities!){
//       if(name?.trim().compareTo(entity.name!) == 0){
//         return index;
//       }
//       index++;
//     }
//   }
// }
