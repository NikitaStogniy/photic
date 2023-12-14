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

import 'package:gallery_saver/gallery_saver.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<String?> downloadImage(String imageUrl) async {
  try {
    // Fetch the image from the URL
    final response = await http.get(Uri.parse(imageUrl));

    if (response.statusCode == 200) {
      // Get the temporary directory on the device
      final tempDir = await getTemporaryDirectory();

      // Generate a unique file name for the image
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();

      // Create a file and write the image data to it
      final File file = File('${tempDir.path}/$fileName.jpg');
      await file.writeAsBytes(response.bodyBytes);

      // Save the image to the device's gallery
      await GallerySaver.saveImage(file.path);
      return 'Image saved to gallery';
    } else {
      // Handle the case when the image cannot be downloaded
      return 'Failed to download image. Status code: ${response.statusCode}';
    }
  } catch (error) {
    // Handle exceptions
    return 'Error saving image to gallery: $error';
  }
}
