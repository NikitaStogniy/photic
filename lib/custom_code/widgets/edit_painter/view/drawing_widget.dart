import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:photic/custom_code/widgets/edit_painter/view/drawing_canvas/drawing_canvas.dart';
import 'package:photic/custom_code/widgets/edit_painter/view/drawing_canvas/models/drawing_mode.dart';
import 'package:photic/custom_code/widgets/edit_painter/view/drawing_canvas/models/sketch.dart';

GlobalKey? canvasKey;

class DrawingWidget extends HookWidget {
  const DrawingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedColor = useState(Colors.white);
    final strokeSize = useState<double>(10);
    final eraserSize = useState<double>(30);
    final drawingMode = useState(DrawingMode.pencil);
    final filled = useState<bool>(false);
    final polygonSides = useState<int>(3);
    final backgroundImage = useState<ui.Image?>(null);

    final canvasGlobalKey = GlobalKey();
    canvasKey = canvasGlobalKey;

    ValueNotifier<Sketch?> currentSketch = useState(null);
    ValueNotifier<List<Sketch>> allSketches = useState([]);

    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 150),
      initialValue: 1,
    );
    return Container(
      height: 400,
      width: 400,
      child: DrawingCanvas(
        width: 400,
        height: 400,
        drawingMode: drawingMode,
        selectedColor: selectedColor,
        strokeSize: strokeSize,
        eraserSize: eraserSize,
        sideBarController: animationController,
        currentSketch: currentSketch,
        allSketches: allSketches,
        canvasGlobalKey: canvasGlobalKey,
        filled: filled,
        polygonSides: polygonSides,
        backgroundImage: backgroundImage,
      ),
    );
  }

  Future<Uint8List?> getBytes() async {
    RenderRepaintBoundary boundary =
        canvasKey!.currentContext?.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List? pngBytes = byteData?.buffer.asUint8List();
    return pngBytes;
  }
}
