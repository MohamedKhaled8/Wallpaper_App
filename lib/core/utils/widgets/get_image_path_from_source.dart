import 'package:image_picker/image_picker.dart';

Future<String?> getImagePathFromSource() async {
  final result = await ImagePicker()
      .pickImage(source: ImageSource.gallery, maxWidth: 1440, imageQuality: 70);

  return result?.path;
}
