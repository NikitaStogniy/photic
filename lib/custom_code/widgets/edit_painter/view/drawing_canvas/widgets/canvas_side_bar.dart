import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:file_picker/file_picker.dart';
// import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photiq/custom_code/widgets/edit_painter/view/drawing_canvas/models/drawing_mode.dart';
import 'package:photiq/custom_code/widgets/edit_painter/view/drawing_canvas/models/sketch.dart';
import 'package:photiq/custom_code/widgets/edit_painter/view/drawing_canvas/widgets/color_palette.dart';
import 'package:photiq/custom_code/widgets/edit_painter/view/drawing_widget.dart';
import 'package:photiq/flutter_flow/flutter_flow_theme.dart';
import 'package:photiq/flutter_flow/flutter_flow_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class CanvasSideBar extends HookWidget {
  // final ValueNotifier<Color> selectedColor;
  final ValueNotifier<double> strokeSize;
  // final ValueNotifier<double> eraserSize;
  // final ValueNotifier<DrawingMode> drawingMode;
  final ValueNotifier<Sketch?> currentSketch;
  final ValueNotifier<List<Sketch>> allSketches;
  // final GlobalKey canvasGlobalKey;
  // final ValueNotifier<bool> filled;
  // final ValueNotifier<int> polygonSides;
  // final ValueNotifier<ui.Image?> backgroundImage;

  const CanvasSideBar({
    Key? key,
    // required this.selectedColor,
    required this.strokeSize,
    // required this.eraserSize,
    // required this.drawingMode,
    required this.currentSketch,
    required this.allSketches,
    // required this.canvasGlobalKey,
    // required this.filled,
    // required this.polygonSides,
    // required this.backgroundImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final undoRedoStack = useState(_UndoRedoStack(
      sketchesNotifier: allSketches,
      currentSketchNotifier: currentSketch,
    ));
    final scrollController = useScrollController();
    return FFButtonWidget(
      icon: Icon(Icons.settings_backup_restore_rounded),
      onPressed: allSketches.value.isNotEmpty
          ? () => undoRedoStack.value.undo()
          : null,
      options: FFButtonOptions(
        width: 48.0,
        height: 48.0,
        padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
        iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
        color: Colors.black,
        // textStyle: FlutterFlowTheme.of(context).titleSmall.override(
        //       fontFamily: 'Open Sans',
        //       color: FlutterFlowTheme.of(context).accent3,
        //     ),
        // elevation: 0.0,
        // borderSide: BorderSide(
        //   color: FlutterFlowTheme.of(context).primaryBackground,
        //   width: 1.0,
        // ),
        // borderRadius: BorderRadius.circular(8.0),
      ),
      text: '',
    );
  }

  void saveFile(Uint8List bytes, String extension) async {
    // await FileSaver.instance.saveFile(
    //   'FlutterLetsDraw-${DateTime.now().toIso8601String()}.$extension',
    //   bytes,
    //   extension,
    //   mimeType: extension == 'png' ? MimeType.PNG : MimeType.JPEG,
    // );
  }

  Future<ui.Image> get _getImage async {
    final completer = Completer<ui.Image>();
    if (!kIsWeb && !Platform.isAndroid && !Platform.isIOS) {
      final file = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );
      if (file != null) {
        final filePath = file.files.single.path;
        final bytes = filePath == null
            ? file.files.first.bytes
            : File(filePath).readAsBytesSync();
        if (bytes != null) {
          completer.complete(decodeImageFromList(bytes));
        } else {
          completer.completeError('No image selected');
        }
      }
    } else {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        final bytes = await image.readAsBytes();
        completer.complete(
          decodeImageFromList(bytes),
        );
      } else {
        completer.completeError('No image selected');
      }
    }

    return completer.future;
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  // Future<Uint8List?> getBytes() async {
  //   RenderRepaintBoundary boundary = canvasGlobalKey.currentContext
  //       ?.findRenderObject() as RenderRepaintBoundary;
  //   ui.Image image = await boundary.toImage();
  //   ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  //   Uint8List? pngBytes = byteData?.buffer.asUint8List();
  //   return pngBytes;
  // }
}

class _IconBox extends StatelessWidget {
  final IconData? iconData;
  final Widget? child;
  final bool selected;
  final VoidCallback onTap;
  final String? tooltip;

  const _IconBox({
    Key? key,
    this.iconData,
    this.child,
    this.tooltip,
    required this.selected,
    required this.onTap,
  })  : assert(child != null || iconData != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            border: Border.all(
              color: selected ? Colors.grey[900]! : Colors.grey,
              width: 1.5,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          child: Tooltip(
            message: tooltip,
            preferBelow: false,
            child: child ??
                Icon(
                  iconData,
                  color: selected ? Colors.grey[900] : Colors.grey,
                  size: 20,
                ),
          ),
        ),
      ),
    );
  }
}

///A data structure for undoing and redoing sketches.
class _UndoRedoStack {
  _UndoRedoStack({
    required this.sketchesNotifier,
    required this.currentSketchNotifier,
  }) {
    _sketchCount = sketchesNotifier.value.length;
    sketchesNotifier.addListener(_sketchesCountListener);
  }

  final ValueNotifier<List<Sketch>> sketchesNotifier;
  final ValueNotifier<Sketch?> currentSketchNotifier;

  ///Collection of sketches that can be redone.
  late final List<Sketch> _redoStack = [];

  ///Whether redo operation is possible.
  ValueNotifier<bool> get canRedo => _canRedo;
  late final ValueNotifier<bool> _canRedo = ValueNotifier(false);

  late int _sketchCount;

  void _sketchesCountListener() {
    if (sketchesNotifier.value.length > _sketchCount) {
      //if a new sketch is drawn,
      //history is invalidated so clear redo stack
      _redoStack.clear();
      _canRedo.value = false;
      _sketchCount = sketchesNotifier.value.length;
    }
  }

  void clear() {
    _sketchCount = 0;
    sketchesNotifier.value = [];
    _canRedo.value = false;
    currentSketchNotifier.value = null;
  }

  void undo() {
    final sketches = List<Sketch>.from(sketchesNotifier.value);
    if (sketches.isNotEmpty) {
      _sketchCount--;
      _redoStack.add(sketches.removeLast());
      sketchesNotifier.value = sketches;
      _canRedo.value = true;
      currentSketchNotifier.value = null;
    }
  }

  void redo() {
    if (_redoStack.isEmpty) return;
    final sketch = _redoStack.removeLast();
    _canRedo.value = _redoStack.isNotEmpty;
    _sketchCount++;
    sketchesNotifier.value = [...sketchesNotifier.value, sketch];
  }

  void dispose() {
    sketchesNotifier.removeListener(_sketchesCountListener);
  }
}

class Slid extends StatefulWidget {
  const Slid({super.key});

  @override
  State<Slid> createState() => _SlidState();
}

class _SlidState extends State<Slid> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}