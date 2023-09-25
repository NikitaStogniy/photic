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

import 'package:flutter/services.dart';
import 'package:image_downloader/image_downloader.dart';

Future<String> downloadImage(
  String? imageURL,
  bool? platformIsAndroid,
  bool? platformIsiOS,
  bool? platformIsWeb,
) async {
  if (imageURL == null || imageURL.isEmpty) {
    return "File doesn't exist";
  }

  try {
    if (platformIsAndroid == true || platformIsiOS == true) {
      // Code for Android and iOS
      var imageId = await ImageDownloader.downloadImage(imageURL);
      if (imageId == null) {
        return "File doesn't exist";
      }
      // Below is a method of obtaining saved image information.
      var fileName = await ImageDownloader.findName(imageId);
      var path = await ImageDownloader.findPath(imageId);
      var size = await ImageDownloader.findByteSize(imageId);
      var mimeType = await ImageDownloader.findMimeType(imageId);
      // Return a success message once the download finishes.
      // You can use this as an action output variable to show a snackbar.
      return "Download Successful";
    } else if (platformIsWeb == true) {
      // Code for the web platform
      // Handle web-specific image downloading logic here
      // You might use different packages or methods for web image downloads
      // Return a success message or handle errors accordingly
      return "Download Successful (Web)";
    } else {
      // Handle other platforms if needed
      return "Platform not supported";
    }
  } on PlatformException catch (error) {
    // Handle specific platform-related exceptions
    print("Error: $error");
    return "Download Failed: $error";
  } catch (error) {
    // Handle other exceptions
    print("Error: $error");
    return "Download Failed: $error";
  }
}
