// import 'dart:async';
// import 'dart:convert';
// import 'dart:io' as io;
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:googleapis/cloudbuild/v1.dart';
// import 'package:googleapis/drive/v3.dart' as drive;
// import 'package:googleapis_auth/auth_io.dart' as auth;
// import 'package:excel/excel.dart';
// import 'package:nemo/model/entity.dart';
// import 'package:nemo/providers/entity_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:path/path.dart' as path;
//
// var byteList;
//
// class DriveUtils {
//   final accountCredentials = auth.ServiceAccountCredentials.fromJson(r'''
//     {
//       "private_key_id": "6c8a5720bef1c5c31fbd5bb03affe91db590d57e",
//       "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCwU2n7NlceTGjf\nEbi5uVuf14h8LJmMhWYjAWeJbFVNMVUnUTJ0gTCsnWhPvzLPQNNwcUFRq/Z5vJE2\nqNPIaWNvey3BpZ7KadRYOVu5AqgX5GppXuVi6TGmdE9ckvW4NLCNuIE0dKnxB+E1\nMqhuzl3DO5NyVuHYilYtPukWf3yyBOXnqpUL7oxG+k/wHWk+/YXX9o2ADvEUflM9\nhwKJqu1rHhKFrCIwEik9oNYTQyyDUpLx1Xh6TNSvVnh1iQo+Jva6ANG7sO+5f66t\ngLZ4s3bva9y71C+vs2NXIRj6uY0BalxWMwOMXeMVSnEusLGQwWnHn2+L0K0QgmWy\nIjyJkI6VAgMBAAECggEACQx60Z7ICUDEGACFkZhq1JDfyvmR9rVo2K6LhPCnjwLT\nWyVuWK7Bk/YvAnquLZcm0qwpPTr9NuGftSWkWrJX3UJ9xmSMudgFAvMMmznA7Rr2\ngApT7MfJWcC5yucqz4V6swcvMEU1bG5qVwvOu4MBKlH+Ht3JEM8GnaNPHG219T+3\npVsRge61DK5Y2oJvguB3aggA0oZt2fN9UYr5yxcnNp0RQ78yCZvnxkWTr8zDUbYr\nySnLb4A1FbgGUOzbfRyjJ21TQa+9EqzUwvTg5QlhcijoXA1WdUnSpOEcJf6BZmBu\nV6bNWeADxbgvCUXxoNnwX4wH3zWPIwN+yMDJIApBqQKBgQDusLc28E7gU0Djthm1\nMeNqF86kQcG34M5w/CjAVq8hIEcHuWvqZjHc0fMq9bCfYJ3LESIJYbm51HiPHqoz\nRoFhDhqREIV0GT15ficDdd5BfPskcAC3IK/tpRA87Ikr43v1NDRu2kDbf1c90b3E\nnRebQL6PQUgxq0F0nDC79GVsPQKBgQC9HOcCT5hdp8R+wMHhM+d80ZyqnbbJsygl\nncVLk1Ui1f+QjJ7FfrcSMl+ru9x9YZ4UQSxDDxZS5s8Q56aJ8IBTAdsgJZXMZH7D\ndqlFj74DdEc8GHhgl11vXMuvsL5r5XwFRz4egsdn7o2pCwK6Moy7Z1D24SxzDiC9\nnKB3VCeZOQKBgGhwonpDg//b7dS1ZWJHRf6yFBUDQMQ4dZwyeZJPW6ne+bWDiJiz\nxrWcmA4AGxxhpimogYAhZqbNNUNKY6az/wB8r1syI3K9aIy0ilWVSX7WNP2olGeM\nwe31/7jotsyhaSfNg/PNQ/vHKGFAWQyiwCWKmtcL9Y7mJGnlvd0//vDxAoGAU4mu\n6jBq6AQyIqPXgTnCajrV7/BXTGYdt/AntSjSFN9fU2UqxaciC6HA7UXBMomqoNvh\nR4YkoF5g3eDWilx48zIAsASqVW2XKZUDVT0X/MKirQNKObDjj0v4lhWHKHZpAJPl\n9uhiWaDhZuj8PXATBr2u4D+7uN9myxujLtM34tECgYEAosHdlfIJ5woSDYYFtnql\nhDuds1IbCKrdJm2kqVSXu1ROLp3mIAqfqLD+XM5gJNLB3NMds/nOYj75XK8ZrBS+\ndurfPlXOAxXKlFbv35cYkeX/jxfH2PSR0Vydx0BDowMinNWEqSIW/Q46KrqtgI6N\neH/FUhfXkUpePpuTm4zce/U=\n-----END PRIVATE KEY-----\n",
//       "client_email": "nemo-877@nemo-319716.iam.gserviceaccount.com",
//       "client_id": "106715066592464437986",
//       "type": "service_account"
//     }
//   ''');
//
//   final scopes = [drive.DriveApi.driveReadonlyScope];
//   static late var client;
//   late drive.DriveApi driveApi;
//
//   final Map queryMapping = const {
//     'pdf': "mimeType = 'application/pdf'",
//     'text': "mimeType = 'text/plain'",
//     'docs': "mimeType = 'application/vnd.google-apps.document'",
//     'spreadsheets': "mimeType = 'application/vnd.google-apps.spreadsheet'",
//     'slides': "mimeType = 'application/vnd.google-apps.presentation'",
//     'folders': "mimeType = 'application/vnd.google-apps.folder'",
//     'docx':
//         "mimeType = 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'",
//     'docxNoExt': "mimeType = 'application/vnd.google-apps.document'",
//     'xlsx':
//         "mimeType = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'",
//     'mp4': "mimeType = 'video/mp4'",
//     'img': "mimeType = 'image/jpeg'",
//     'all': null,
//   };
//
//   Future<Null> init(BuildContext context) async {
//     auth.clientViaServiceAccount(accountCredentials, scopes).then((value) {
//       client = value;
//       driveApi = drive.DriveApi(value);
//       var query = queryMapping['spreadsheets'];
//       // var query = "name contains 'List of entities'";
//
//       List<String?> entityList = [];
//       _findSpreadsheet(driveApi).then((file) async {
//         print("File drive ID: ${file.driveId}");
//         print("File Mime Type: ${file.mimeType}");
//         print("File id: ${file.id}");
//         print("File web content link: ${file.webContentLink}");
//         print("File web view link: ${file.webViewLink}");
//         driveApi.files
//             .get(file.id!, downloadOptions: drive.DownloadOptions.fullMedia)
//             .then((response) {
//           Uint8List byteList;
//           final bytesBuilder = BytesBuilder();
//           var excel;
//           (response as drive.Media).stream.listen((data) {
//             bytesBuilder.add(data);
//           }).onDone(() {
//             byteList = bytesBuilder.toBytes();
//             excel = Excel.decodeBytes(byteList);
//             final table = excel.tables.keys.first;
//             for (List<Data?> row in excel.tables[table].rows) {
//               // if(row == excel.tables[table].rows.first)
//               //   continue;
//               if (row[1] != null) {
//                 if (row[2] != null) entityList.add(row[1]?.value ?? "EMPTY");
//               } else {
//                 entityList.removeAt(0);
//                 break;
//               }
//             }
//             _createEntities(entityList, context); // 1 api call here
//             _getEntityDescription(entityList, context, driveApi);
//             // _findEntityVideos(driveApi, "Dog");
//           });
//         });
//       });
//
//       // searchTextDocuments(driveApi, 100, query).then((List<drive.File> files) {
//       //   print('Here are the first ${files.length} documents:');
//       //   print('');
//       //   for (var file in files) {
//       //     print(' - ${file.name}');
//       //   }
//       // }).catchError((error) {
//       //   print('An error occured: $error');
//       // });
//     }).catchError((error) {
//       if (error is auth.UserConsentException) {
//         print("You did not grant access :(");
//       } else {
//         print("An unknown error occured: $error");
//       }
//     });
//   }
//
//   Future<List<drive.File>> searchTextDocuments(
//       drive.DriveApi api, int max, String query) {
//     List<drive.File> docs = [];
//
//     Future<List<drive.File>> next(String? token) {
//       return api.files
//           .list(q: query, pageToken: token, pageSize: max)
//           .then((results) {
//         docs.addAll(results.files!.toList());
//         if (docs.length < max && results.nextPageToken != null) {
//           return next(results.nextPageToken);
//         }
//         return docs;
//       });
//     }
//
//     return next(null);
//   }
//
//   Future<drive.File> _findSpreadsheet(drive.DriveApi api) {
//     final query = "name contains 'List of entities'";
//     print("query: $query");
//     drive.File file;
//     return api.files.list(q: query).then((results) {
//       file = results.files!.first;
//       print("Spreadsheet - ${file.name}");
//       return file;
//     });
//   }
//
//   void _createEntities(List<String?> entityList, BuildContext context) {
//     final entityProvider = Provider.of<EntityProvider>(context, listen: false);
//     for (String? entity in entityList) {
//       final newEntity = Entity(
//         name: entity?.trim(),
//       );
//       entityProvider.addEntity(newEntity);
//     }
//   }
//
//   Future<drive.File> _findEntityDoc(drive.DriveApi api, String? entityName) {
//     final query = "name = '$entityName' and ${queryMapping['docxNoExt']}";
//     // print(query);
//     drive.File file;
//     return api.files.list(q: query).then((results) {
//       file = results.files!.first;
//       // print(file.name);
//       return file;
//     });
//   }
//
//   Future<List<drive.File>> _findEntityVideos(
//       drive.DriveApi api, String? entityName) {
//     final query = "name contains '$entityName' and ${queryMapping['mp4']}";
//     print(query);
//     List<drive.File> files;
//     return api.files.list(q: query).then((results) {
//       files = results.files!;
//       for (var file in files) {
//         print(file.name);
//       }
//       return files;
//     });
//   }
//
//   List<drive.File> _filterVideoList(
//       String? entityName, List<drive.File>? videos) {
//     List<drive.File> filteredList = [];
//     for (drive.File video in videos ?? []) {
//       final videoName = video.name;
//       final searchPatterns = [
//         RegExp(entityName! + " ", caseSensitive: false),
//         RegExp(" " + entityName, caseSensitive: false),
//         RegExp(entityName + "s", caseSensitive: false)
//       ];
//       if (videoName!.contains(searchPatterns[0]) |
//           videoName.contains(searchPatterns[1]) |
//           videoName.contains(searchPatterns[2])) {
//         filteredList.add(video);
//       }
//     }
//     return filteredList;
//   }
//
//   Future<List<drive.File>> _findEntityImages(
//       drive.DriveApi api, String? entityName) {
//     final query = "name contains '$entityName' and ${queryMapping['img']}";
//     List<drive.File> files;
//     return api.files.list(q: query).then((result) {
//       files = result.files!;
//       for (var file in files) {
//         print(file.name);
//       }
//       return files;
//     });
//   }
//
//   List<drive.File> _filterImageList(
//       String? entityName, List<drive.File>? images) {
//     List<drive.File> filteredList = [];
//     for (drive.File image in images ?? []) {
//       final imageName = image.name;
//       final searchPatterns = [
//         RegExp(entityName! + " ", caseSensitive: false),
//         RegExp(" " + entityName, caseSensitive: false),
//         RegExp(entityName + "s", caseSensitive: false)
//       ];
//       if (imageName!.contains(searchPatterns[0]) |
//           imageName.contains(searchPatterns[1]) |
//           imageName.contains(searchPatterns[2])) {
//         filteredList.add(image);
//       }
//     }
//     return filteredList;
//   }
//
//   void _getEntityDescription(
//       List<String?> entityList, BuildContext context, drive.DriveApi api) {
//     final entityProvider = Provider.of<EntityProvider>(context, listen: false);
//     entityList = ["Cow", "Dog"];
//     for (String? entityName in entityList) {
//       final loc = entityProvider.findEntityName(entityName);
//       _findEntityDoc(api, entityName).then((file) {
//         driveApi.files
//             .export(file.id!, 'text/plain',
//                 downloadOptions: drive.DownloadOptions.fullMedia)
//             .then((response) {
//           Uint8List byteList;
//           final bytesBuilder = BytesBuilder();
//           (response as drive.Media).stream.listen((data) {
//             bytesBuilder.add(data);
//           }).onDone(() {
//             byteList = bytesBuilder.toBytes();
//             final decoder = Utf8Decoder();
//             final String? description = decoder.convert(byteList);
//             // print(description);
//             entityProvider.setDescription(
//                 entityProvider.listOfEntities![loc!], description);
//           });
//         });
//       });
//       _findEntityImages(api, entityName).then((images) {
//         final filteredList = _filterImageList(entityName ?? "", images);
//         entityProvider.setImageList(
//             entityProvider.listOfEntities![loc!], filteredList);
//       });
//
//       _findEntityVideos(api, entityName).then((videos) {
//         final filteredList = _filterVideoList(entityName ?? "", videos);
//         entityProvider.setVideoList(
//             entityProvider.listOfEntities![loc!], filteredList);
//       });
//     }
//   }
//
//   Future downloadEntityVideos(int? index, BuildContext context) async {
//     final entityProvider = Provider.of<EntityProvider>(context, listen: false);
//     final videoList = entityProvider.listOfEntities![index!].videoFiles;
//     print("This function is called");
//     for (drive.File? file in videoList!) {
//       print("in for loop");
//       // final pathContext = path.Context(style: path.Style.windows);
//       // final currentPath = path.current;
//       // final filePath = pathContext.join(currentPath, file?.name);
//       // if(await io.File(filePath).exists() == false){
//       await driveApi.files
//           .get(file?.id ?? "", downloadOptions: drive.DownloadOptions.fullMedia)
//           .then((response) {
//         print("response");
//         print(response);
//         final bytesBuilder = BytesBuilder();
//         (response as drive.Media).stream.listen((data) {
//           bytesBuilder.add(data);
//         }).onDone(() {
//           byteList = bytesBuilder.toBytes();
//           print("checking");
//           print(byteList);
//           final saveFile = io.File(filePath);
//           saveFile.writeAsBytes(byteList.toList());
//           print("File saved at ${saveFile.path}");
//         });
//       });
//       // }
//     }
//   }
//
//   void downloadEntityImages(int? index, BuildContext context) async {
//     final entityProvider = Provider.of<EntityProvider>(context, listen: false);
//     final imageList = entityProvider.listOfEntities![index!].imageFiles;
//
//     for (drive.File? file in imageList!) {
//       final pathContext = path.Context(style: path.Style.windows);
//       final currentPath = path.current;
//       final filePath = pathContext.join(currentPath, file?.name);
//       if (await io.File(filePath).exists() == false) {
//         driveApi.files
//             .get(file?.id ?? "",
//                 downloadOptions: drive.DownloadOptions.fullMedia)
//             .then((response) {
//           Uint8List byteList;
//           final bytesBuilder = BytesBuilder();
//           (response as drive.Media).stream.listen((data) {
//             bytesBuilder.add(data);
//           }).onDone(() {
//             byteList = bytesBuilder.toBytes();
//             final saveFile = io.File(filePath);
//             saveFile.writeAsBytes(byteList.toList());
//             print("File saved at ${saveFile.path}");
//           });
//         });
//       }
//     }
//   }
// }
