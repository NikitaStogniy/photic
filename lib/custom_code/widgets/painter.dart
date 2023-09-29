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
  final double strokeWidth;
  final double? width;
  final double? height;
  String imgMask; // Remove 'final'

  Painter({
    required this.strokeWidth,
    this.width,
    this.height,
    required this.imgMask,
  });

  @override
  _PainterState createState() => _PainterState();
}

class _PainterState extends State<Painter> {
  List<Offset> points = [];
  GlobalKey _repaintKey = GlobalKey();

  Future<String> _saveCanvasToBase64() async {
    try {
      RenderRepaintBoundary boundary = _repaintKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;

      // Capture the content of the CustomPaint widget with a pixel ratio of 1.0
      final imageByteData = await boundary.toImage(pixelRatio: 1.0);
      final ByteData? byteData = await imageByteData.toByteData(
        format: ui.ImageByteFormat.png,
      );

      if (byteData != null) {
        final Uint8List pngBytes =
            Uint8List.sublistView(byteData.buffer.asUint8List());

        // Encode the image data as a base64 string
        final base64Image = base64Encode(pngBytes);

        // Access MyPainterShareState and update textFieldValue
        MyPainterShareState().textFieldValue = base64Image;

        return base64Image;
      } else {
        throw Exception("Failed to convert image to base64");
      }
    } catch (e) {
      // Handle any exceptions that may occur during the conversion
      print('Error converting image to base64: $e');
      return 'Error converting image to base64: $e';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          RenderBox renderBox = context.findRenderObject() as RenderBox;
          points.add(renderBox.globalToLocal(details.globalPosition));
        });
      },
      onPanEnd: (details) async {
        points.add(Offset(-1, -1)); // Indicator for the end of a stroke
        // Save the canvas as a base64 string
        await _saveCanvasToBase64();
      },
      child: RepaintBoundary(
        key: _repaintKey,
        child: CustomPaint(
          size: Size(widget.width ?? double.infinity,
              widget.height ?? double.infinity),
          painter: MyPainter(
              points: points.where((point) => point != Offset(-1, -1)).toList(),
              strokeWidth: widget.strokeWidth),
        ),
      ),
    );
  }
}
