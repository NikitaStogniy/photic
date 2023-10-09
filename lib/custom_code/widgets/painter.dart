// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class Painter extends StatefulWidget {
  const Painter({
    Key? key,
    this.width,
    this.height,
    required this.strokeWidth,
    required this.imgMask,
  }) : super(key: key);

  final double? width;
  final double? height;
  final double strokeWidth;
  final String imgMask;

  @override
  _PainterState createState() => _PainterState();
}

class _PainterState extends State<Painter> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
