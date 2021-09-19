// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:nemo/getsearchlist.dart';
// import 'package:nemo/providers/search_provider.dart';
// import 'package:nemo/Widgets/custom_expansion_tile.dart';
// import 'package:nemo/Widgets/searchBar.dart';
// import 'package:provider/provider.dart';
// import 'package:nemo/screens/list_of_entities.dart';
//
// class ExpansionSearchBar extends StatefulWidget {
//   final String? tooltip;
//   ExpansionSearchBar({Key? key, this.tooltip}) : super(key: key);
//   @override
//   _ExpansionSearchBarState createState() => _ExpansionSearchBarState();
// }
//
// class _ExpansionSearchBarState extends State<ExpansionSearchBar> {
//   bool _isExpanded = false;
//   TextEditingController? _controller;
//   FocusNode? _focusNode;
//   List<String>? _searchSuggestions = [];
//   List<String>? dumyData = searchdata;
//   void _buildSuggestions() {
//     if (_controller!.text.isEmpty) {
//       _searchSuggestions = [];
//       return;
//     }
//     _searchSuggestions = dumyData!
//         .where((element) =>
//             element.toLowerCase().contains(_controller!.text.toLowerCase()))
//         .toList();
//   }
//
//   @override
//   void initState() {
//     _controller = TextEditingController(text: "");
//     _controller?.addListener(_buildSuggestions);
//     _focusNode = FocusNode();
//     //print(searchdata);
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _focusNode?.dispose();
//     _controller?.removeListener(_buildSuggestions);
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Shortcuts(
//       shortcuts: <LogicalKeySet, Intent>{
//         LogicalKeySet(LogicalKeyboardKey.enter): SubmitIntent(),
//         LogicalKeySet(LogicalKeyboardKey.space): EmptyIntent(),
//       },
//       child: Actions(
//         actions: <Type, Action<Intent>>{
//           SubmitIntent:
//               SubmitAction(controller: _controller, focusNode: _focusNode),
//           EmptyIntent: EmptyAction(controller: _controller),
//         },
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(8.0),
//                 bottomRight: Radius.circular(10.0)),
//           ),
//           clipBehavior: Clip.antiAlias,
//           child: Consumer<SearchProvider>(
//             builder: (context, searchProvider, child) => CustomExpansionTile(
//                 title: child!,
//                 expansionStatus: searchProvider.isExpanded!,
//                 tilePadding: EdgeInsets.zero,
//                 trailing: Icon(Icons.search),
//                 children: _searchSuggestions!
//                     .map((e) => SearchItem(
//                           item: e,
//                         ))
//                     .toList()),
//             child: SearchBar(
//               tooltip: widget.tooltip ?? "",
//               controller: _controller,
//               focusNode: _focusNode,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class SubmitIntent extends Intent {
//   const SubmitIntent();
// }
//
// class EmptyIntent extends Intent {
//   const EmptyIntent();
// }
//
// class SubmitAction extends Action<SubmitIntent> {
//   final TextEditingController? controller;
//   final FocusNode? focusNode;
//   SubmitAction({this.controller, this.focusNode});
//   @override
//   Object? invoke(covariant SubmitIntent intent) {
//     //TODO: call onSubmittedCallback
//     if (focusNode?.hasFocus == true) {
//       focusNode?.unfocus();
//     }
//   }
// }
//
// class EmptyAction extends Action<EmptyIntent> {
//   final TextEditingController? controller;
//   EmptyAction({this.controller});
//   @override
//   Object? invoke(covariant EmptyIntent intent) {
//     String? str = controller?.text;
//     if (controller?.selection.textInside(controller!.text).length != 0) {
//       final String? selectedString =
//           controller?.selection.textInside(controller!.text);
//       final int? startPos = controller?.selection.start;
//       controller?.text =
//           str!.replaceRange(startPos!, startPos + selectedString!.length, " ");
//     } else {
//       controller?.text = str! + " ";
//     }
//     controller?.selection = TextSelection.fromPosition(
//         TextPosition(offset: controller!.text.length));
//   }
// }
//
// class SearchItem extends StatelessWidget {
//   final String? item;
//   const SearchItem({Key? key, this.item}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white.withOpacity(0.16),
//       child: ListTile(
//         dense: true,
//         // onTap: () => Navigator.of(context)
//         //     .push(MaterialPageRoute(builder: (context) => ListOfEntities())),
//         title: Text(
//           item ?? "Invalid Data",
//           //style: Theme.of(context).primaryTextTheme.headline4,
//         ),
//       ),
//     );
//   }
// }
