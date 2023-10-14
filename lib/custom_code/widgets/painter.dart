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


import 'dart:ui';

import 'package:flutter/rendering.dart';

import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:convert';
// import 'dart:js' as js;

class MyPainterShareState {
  String _textFieldValue = '';

  MyPainterShareState._privateConstructor();

  static final MyPainterShareState _instance =
      MyPainterShareState._privateConstructor();

  factory MyPainterShareState() {
    return _instance;
  }

  String get textFieldValue => _textFieldValue;

  set textFieldValue(String value) {
    _textFieldValue = value;
  }
}

class MyPainter extends CustomPainter {
  MyPainter({required this.points, required this.strokeWidth});

  final List<Offset> points;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    for (int i = 0; i < points.length - 1; i++) {
      canvas.drawLine(points[i], points[i + 1], paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

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
