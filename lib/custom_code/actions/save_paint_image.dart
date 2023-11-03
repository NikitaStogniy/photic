// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:image/image.dart' as imglib;
import '../widgets/painter.dart';
import 'package:http/http.dart' as http;

Future<String> savePaintImage(
  BuildContext context,
) async {
  http.Response response = await http.get(
    Uri.parse(
        'https://imageio.forbes.com/specials-images/imageserve/5d35eacaf1176b0008974b54/0x0.jpg'),
  );
  final jpg = response.bodyBytes;

  // // Get the base64 image data from MyPainterShareState
  // final base64Image = MyPainterShareState().textFieldValue;

  // // Decode the base64 image
  // final bytes = base64.decode(base64Image);

  // // Convert the image to jpg format
  // final image = imglib.decodeImage(bytes)!;
  // final jpg = imglib.encodeJpg(image);

  // Upload the image to Firebase Storage
  final storage = FirebaseStorage.instance;
  final ref = storage
      .ref()
      .child('paintings/2${DateTime.now().millisecondsSinceEpoch}.jpg');
  final uploadTask = ref.putData(jpg);

  // Wait for the upload to complete
  final snapshot = await uploadTask.whenComplete(() {});

  // Return the uploaded image path
  final downloadUrl = await snapshot.ref.getDownloadURL();
  return downloadUrl;
}