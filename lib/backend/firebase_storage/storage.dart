import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:mime_type/mime_type.dart';
import 'package:image/image.dart' as imglib;

Future<String?> uploadData(String path, Uint8List data) async {
  final storageRef = FirebaseStorage.instance.ref().child(path);
  final metadata = SettableMetadata(contentType: mime(path));

  imglib.Image image = imglib.decodeImage(data)!;

  imglib.Image thumbnail = imglib.copyResize(image, height: 400, width: 400);

  final jpg = imglib.encodeJpg(thumbnail);
  final result = await storageRef.putData(jpg, metadata);
  return result.state == TaskState.success ? result.ref.getDownloadURL() : null;
}
