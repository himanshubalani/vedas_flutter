import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:googleapis/drive/v3.dart' as drive;

class GoogleDriveApi {
  late drive.DriveApi _driveApi;

  Future<void> init(http.Client client, String apiKey) async {
  _driveApi = drive.DriveApi(client);
  }



  Future<List<drive.File>> getFiles(String folderId) async {
    final files = await _driveApi.files.list(
      q: "mimeType='application/pdf' and trashed = false and '$folderId' in parents",
      $fields: "files(id, name, parents)",
    );
    return files.files!;
  }

  Future<List<drive.File>> getFolders() async {
    final folders = await _driveApi.files.list(
      q: "mimeType='application/vnd.google-apps.folder' and trashed = false",
      $fields: "files(id, name)",
    );
    return folders.files!;
  }


}
