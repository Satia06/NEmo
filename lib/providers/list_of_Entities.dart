// import 'package:flutter/material.dart';
// import 'package:nemo/providers/drive_provider.dart';
// import 'package:nemo/providers/entity_provider.dart';
// import 'package:nemo/widgets/image_list.dart';
// import 'package:nemo/widgets/video_list.dart';
// import 'package:provider/provider.dart';
//
// class ListOfEntities extends StatefulWidget {
//   ListOfEntities({Key? key}) : super(key: key);
//
//   @override
//   _ListOfEntitiesState createState() => _ListOfEntitiesState();
// }
//
// class _ListOfEntitiesState extends State<ListOfEntities> {
//   String? description = "";
//   int? _selectedIndex;
//   late DriveProvider driveProvider;
//   // String? _selectedEntityName = "";
//
//   Future _triggerVideoDownloads(int? index) async {
//     await driveProvider.driveUtils.downloadEntityVideos(index, context);
//   }
//
//   void _triggerImageDownloads(int? index) {
//     driveProvider.driveUtils.downloadEntityImages(index, context);
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     driveProvider = Provider.of<DriveProvider>(context, listen: false);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//     body: Row(
//       children: [
//         Container(
//           height: double.infinity,
//           decoration: BoxDecoration(
//             border: Border(right: BorderSide())
//           ),
//           // color: Colors.grey,
//           width: MediaQuery.of(context).size.width * 0.25,
//           child: Column(
//             children: [
//               Container(
//                 alignment: Alignment.topLeft,
//                 child: IconButton(
//                   icon: Icon(Icons.arrow_back),
//                   onPressed: () => Navigator.pop(context),
//                 ),
//                 height: 30,
//               ),
//               Hero(
//                 tag: 'LOE',
//                 child: Container(
//                   padding: EdgeInsets.all(15.0),
//                   child: Text(
//                     "List Of Entities",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 20,
//                     ),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Consumer<EntityProvider>(
//                   builder: (context, entityProvider, _){
//                     return ListTileTheme(
//                       selectedColor: Colors.white,
//                       child: ListView.builder(
//                         itemCount: entityProvider.listOfEntities?.length,
//                         itemBuilder: (context, index) {
//                           return ListTile(
//                             key: ValueKey(entityProvider.listOfEntities?[index].name),
//                             title: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(entityProvider.listOfEntities?[index].name ?? "EMPTY"),
//                             ),
//                             onTap: (){
//                               setState(() {
//                                 description = entityProvider.listOfEntities?[index].description;
//                                 _selectedIndex = index;
//                                 // _selectedEntityName = entityProvider.listOfEntities?[index].name;
//                               });
//                               _triggerVideoDownloads(index);
//                               _triggerImageDownloads(index);
//                             },
//                             selectedTileColor: Colors.blueGrey[300],
//                             selected: index == _selectedIndex,
//                           );
//                         },
//                       ),
//                     );
//                   }
//                 )
//               )
//             ],
//           )
//         ),
//         Container(
//           height: double.infinity,
//           color: Colors.transparent,
//           width: MediaQuery.of(context).size.width * 0.75,
//           child: Flex(
//             direction: Axis.horizontal,
//             children: [
//               Flexible(
//                 flex: 1,
//                 child: Container(
//                   margin: EdgeInsets.all(10.0),
//                   padding: EdgeInsets.all(10.0),
//                   decoration: BoxDecoration(
//                     color: Colors.amberAccent,
//                     borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                     border: Border.all(
//                       color: Colors.black,
//                     )
//                   ),
//                   child: Center(
//                     child: Text(
//                       description ?? "NO DESCRIPTION AVAILABLE!",
//                     ),
//                   ),
//                 ),
//               ),
//               Flexible(
//                 flex: 1,
//                 child: Flex(
//                   direction: Axis.vertical,
//                   children: [
//                     Flexible(
//                       flex: 1,
//                       child: Container(
//                         margin: EdgeInsets.all(10.0),
//                         decoration: BoxDecoration(
//                           color: Colors.transparent,
//                           borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                           border: Border.all(
//                             color: Colors.black,
//                           )
//                         ),
//                         child: ImageList(
//                           entityIndex: _selectedIndex
//                         ),
//                       ),
//                     ),
//                     Flexible(
//                       flex: 1,
//                       child: Container(
//                         margin: EdgeInsets.all(10.0),
//                         decoration: BoxDecoration(
//                           color: Colors.transparent,
//                           borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                           border: Border.all(
//                             color: Colors.black,
//                           )
//                         ),
//                         child: VideoList(
//                           entityIndex: _selectedIndex,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ],
//     ));
//   }
// }
