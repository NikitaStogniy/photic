import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:mime_type/mime_type.dart';
import 'package:image/image.dart' as imglib;

import 'dart:math' as math;

int? origImageHeight;
int? origImageWidth;
int? imgSize;

Future<String?> uploadData(String path, Uint8List data) async {
  final storageRef = FirebaseStorage.instance.ref().child(path);
  final metadata = SettableMetadata(contentType: mime(path));

  imglib.Image image = imglib.decodeImage(data)!;

  origImageHeight = image.height;
  origImageWidth = image.width;

  imgSize = math.min(origImageHeight!, origImageWidth!);

  final thumbnail = imglib.copyCrop(image, x: 0, y: 0, width: imgSize!, height: imgSize!);
  

  final jpg = imglib.encodeJpg(thumbnail);
  final result = await storageRef.putData(jpg, metadata);
  return result.state == TaskState.success ? result.ref.getDownloadURL() : null;
}
