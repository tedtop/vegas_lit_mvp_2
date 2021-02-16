import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

abstract class BaseStorage {
  Future<String> uploadFile(File file, String path);
}

class FireStorage extends BaseStorage {
  FireStorage({FirebaseStorage firebaseStorage})
      : _firebaseStorage = firebaseStorage ?? FirebaseStorage.instance;

  final FirebaseStorage _firebaseStorage;

  @override
  Future<String> uploadFile(File file, String path) async {
    final fileName = basename(file.path);
    final miliSecs = DateTime.now().millisecondsSinceEpoch;
    final reference =
        _firebaseStorage.ref().child('$path/$miliSecs\_$fileName');
    final uploadPath = await reference.getData();
    print('uploading to $uploadPath');
    final uploadTask = await reference.putFile(file);
    // final result = await uploadTask.onComplete;
    final url = await uploadTask.ref.getDownloadURL();
    return url;
  }
}
