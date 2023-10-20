// Automatic FlutterFlow imports
import 'package:photiq/backend/firebase_storage/storage.dart';

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

Future<String> getMyCustomWidgeCurrentValue(
    BuildContext context, Uint8List uint8list) async {
  imglib.Image image = imglib.decodeImage(uint8list)!;

  imglib.Image thumbnail = imglib.copyResize(image, height: 400);

  if (thumbnail.numChannels == 4) {
    var imageDst = imglib.Image(
      width: thumbnail.width,
      height: thumbnail.height,
    ) // default format is uint8 and numChannels is 3 (no alpha)
      ..clear(
        imglib.ColorRgb8(0, 0, 0),
      ); // clear the image with the color white.

    thumbnail = imglib.compositeImage(
      imageDst,
      thumbnail,
    ); // alpha composite the image onto the white background
  }

  final jpg = imglib.encodeJpg(thumbnail);

  // Upload the image to Firebase Storage
  final storage = FirebaseStorage.instance;
  final ref = storage
      .ref()
      .child('paintings/${DateTime.now().millisecondsSinceEpoch}.jpg');
  final uploadTask = ref.putData(jpg);

  // Wait for the upload to complete
  final snapshot = await uploadTask.whenComplete(() {});

  // Return the uploaded image path
  final downloadUrl = await snapshot.ref.getDownloadURL();
  return downloadUrl.toString();
}

Future<String> uploadResizedMask(
    Uint8List uint8list, int newHeight, int newWidth) async {
  imglib.Image image = imglib.decodeImage(uint8list)!;

  imglib.Image thumbnail =
      imglib.copyResize(image, height: newHeight, width: newWidth);

  if (thumbnail.numChannels == 4) {
    var imageDst = imglib.Image(
      width: thumbnail.width,
      height: thumbnail.height,
    ) // default format is uint8 and numChannels is 3 (no alpha)
      ..clear(
        imglib.ColorRgb8(0, 0, 0),
      ); // clear the image with the color white.

    print('[eeee] new mask ${thumbnail.height} ${thumbnail.width}');

    thumbnail = imglib.compositeImage(
      imageDst,
      thumbnail,
    ); // alpha composite the image onto the white background
  }

  final jpg = imglib.encodeJpg(thumbnail);

  // Upload the image to Firebase Storage
  final storage = FirebaseStorage.instance;
  final ref = storage
      .ref()
      .child('paintings/${DateTime.now().millisecondsSinceEpoch}.jpg');
  final uploadTask = ref.putData(jpg);

  // Wait for the upload to complete
  final snapshot = await uploadTask.whenComplete(() {});

  // Return the uploaded image path
  final downloadUrl = await snapshot.ref.getDownloadURL();
  return downloadUrl.toString();
}