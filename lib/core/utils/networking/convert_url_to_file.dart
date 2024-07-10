import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

abstract class Networking {
  Networking._();

  static Future<File?> convertUrlToFile(String url) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final documentDirectory = await getApplicationDocumentsDirectory();
        final file = File("${documentDirectory.path}/${url.split('/').last}");

        await file.writeAsBytes(response.bodyBytes);

        return file;
      } else {
        return null;
      }
    } catch (e) {
      print("Error converting url to file: $e");
      return null;
    }
  }
}
