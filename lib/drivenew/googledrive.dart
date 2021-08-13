import 'package:googleapis/drive/v3.dart' as ga;
import 'package:googleapis_auth/auth_io.dart';
import 'package:path/path.dart' as p;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:nemo/temp.dart';
import 'secureStorage.dart';

List<File> items = [];

const _clientId =
    "1021501379065-b8c7887vlg68p96sn28cbavrjbcrdg15.apps.googleusercontent.com";
const _clientSecret = "nFBunrhWMklWeuuysPM4JNOJ";
const _scopes = [ga.DriveApi.driveReadonlyScope];

class GoogleDrive {
  //final storage = SecureStorage();
  Future<http.Client> getHttpClient() async {
    //Get Credentials
    //Needs user authentication
    var authClient = await clientViaUserConsent(
        ClientId(_clientId, _clientSecret), _scopes, (url) {
      //Open Url in Browser
      launch(url);
    });

    return authClient;
    //Save Credentials
  }

  //file upload code
  Future fileListFuntion(String parentid, var clientin) async {
    var client = clientin;
    var drive = ga.DriveApi(client);
    //print(client);

    var folderList = await drive.files.list(q: "'${parentid}' in parents");

    var mainFolderList = folderList.toJson();
    //print(mainFolderList["files"][3]["name"]);
    var list = mainFolderList["files"] as List;
    return list;
    //print(list[4]["name"]);
    //print(mainFolderList);
  }

  Future fileImageFuntion(String fileid, var clientin1) async {
    var client = clientin1;
    var drive = ga.DriveApi(client);
    //print(client);
    var image =
        drive.files.get(fileid, downloadOptions: ga.DownloadOptions.fullMedia);
    //await drive.files.get('1S0GGubJjr1G54JJ9JTPGpZ2e82u8lh4f',
    //  downloadOptions: ga.DownloadOptions.fullMedia);
    //files.get('1nTG7uDqPrDNsRKQKMUN76xYMeaaZkiMT');

    //print(mainFolderList["files"][3]["name"]);
    //print(image);
    return image;
    //print(list[4]["name"]);
    //print(mainFolderList);
  }
}

// Future<http.Client> getHttpClient() async {
//   //Get Credentials
//   var credentials = await storage.getCredentials();
//   if (credentials == null) {
//     //Needs user authentication
//     var authClient = await clientViaUserConsent(
//         ClientId(_clientId, _clientSecret), _scopes, (url) {
//       //Open Url in Browser
//       launch(url);
//     });
//     //Save Credentials
//     await storage.saveCredentials(authClient.credentials.accessToken,
//         authClient.credentials.refreshToken.toString());
//     return authClient;
//   } else {
//     print(credentials["expiry"]);
//     //Already authenticated
//     return authenticatedClient(
//         http.Client(),
//         AccessCredentials(
//             AccessToken(credentials["type"], credentials["data"],
//                 credentials["expiry"]),
//             credentials["refreshToken"],
//             _scopes));
//   }
// }
