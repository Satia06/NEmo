// import 'package:flutter/material.dart';
// import 'package:nemo/model/entity.dart';
// import 'package:nemo/providers/entity_provider.dart';
// import 'package:nemo/Widgets/video_playera.dart';
// import 'package:provider/provider.dart';
//
// class VideoList extends StatefulWidget {
//   final int? entityIndex;
//
//   VideoList({Key? key, this.entityIndex}) : super(key: key);
//
//   @override
//   _VideoListState createState() => _VideoListState();
// }
//
// class _VideoListState extends State<VideoList> {
//   PageController? _pageController;
//
//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(initialPage: 0);
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _pageController?.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final entityProvider = Provider.of<EntityProvider>(context);
//     Entity? entity = entityProvider.listOfEntities![widget.entityIndex ?? 0];
//     return Stack(
//       children: [
//         widget.entityIndex == null
//             ? FittedBox(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Placeholder(),
//                     Padding(
//                       padding: EdgeInsets.symmetric(vertical: 5.0),
//                       child: Text("NO TITLE"),
//                     )
//                   ],
//                 ),
//               )
//             : PageView.builder(
//                 itemCount: entity.videoFiles?.length ?? 1,
//                 scrollDirection: Axis.horizontal,
//                 controller: _pageController,
//                 itemBuilder: (context, index) {
//                   return FittedBox(
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         VideoPlayer(
//                           playerId: index,
//                           videoName: entity.videoFiles?[index]?.name,
//                         ),
//                         Padding(
//                           padding: EdgeInsets.symmetric(vertical: 5.0),
//                           child: Text(
//                             entity.videoFiles?[index]?.name ?? "NO TITLE",
//                           ),
//                         )
//                       ],
//                     ),
//                   );
//                 },
//               ),
//         Container(
//           alignment: Alignment.centerRight,
//           child: OutlinedButton(
//             onPressed: () {
//               _pageController?.nextPage(
//                   duration: Duration(milliseconds: 400),
//                   curve: Curves.decelerate);
//             },
//             child: Icon(Icons.keyboard_arrow_right_rounded),
//             style: OutlinedButton.styleFrom(),
//           ),
//         ),
//         Container(
//           alignment: Alignment.centerLeft,
//           child: OutlinedButton(
//             onPressed: () => _pageController?.previousPage(
//                 duration: Duration(milliseconds: 400),
//                 curve: Curves.decelerate),
//             child: Icon(Icons.keyboard_arrow_left_rounded),
//             style: OutlinedButton.styleFrom(),
//           ),
//         ),
//       ],
//     );
//   }
// }
