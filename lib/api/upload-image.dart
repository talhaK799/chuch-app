import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

FirebaseStorage storage = FirebaseStorage.instance;

Future uploadImage(String imagePath) async {
  try {
    File file = File(imagePath);
    Reference firebaseStorageRef =
        storage.ref().child('uploads/' + "image1" + DateTime.now().toString());
    UploadTask task = firebaseStorageRef.putFile(file);
    final snapshot = await task.whenComplete(() {});
    return await snapshot.ref.getDownloadURL();
  } catch (e) {
    return null;
  }
}

Future selectImage() async {
  try {
    print("image");
    final ImagePicker _picker = ImagePicker();
    final image = await _picker.pickImage(source: ImageSource.gallery);
    return image!.path;
  } catch (e) {
    print(e);
    return null;
  }
}
