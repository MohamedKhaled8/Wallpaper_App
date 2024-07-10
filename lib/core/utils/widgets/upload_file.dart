import 'dart:io';
import 'package:wallapp/core/utils/config/enum.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:wallapp/core/utils/config/app_logger.dart';
import 'package:wallapp/core/utils/model/upload_doc_result_model.dart';

Future<UploadDocResultModel> uploadDocumentToServer(String docPath) async {
  UploadTask uploadTask;
  final docName = docPath.split('/').last;
  appLogger("Uploading document to server: $docName");
  try {
    Reference ref =
        FirebaseStorage.instance.ref().child('images').child('/$docName');

    uploadTask = ref.putFile(File(docPath));

    TaskSnapshot snapshot =
        await uploadTask.whenComplete(() => appLogger("Task completed"));

    final downloadUrl = await snapshot.ref.getDownloadURL();
    return Future.value(
        UploadDocResultModel(fileUrl: downloadUrl, state: ViewState.success));
  } on FirebaseException catch (error) {
    appLogger("F-Error uploading image : $error");
    return Future.value(UploadDocResultModel(
        state: ViewState.error, fileUrl: 'Error uploading image'));
  } catch (e) {
    appLogger("Error uploading image : $e");
    return Future.value(UploadDocResultModel(
        state: ViewState.error, fileUrl:  'Error uploading image: $e'));
  }
}
