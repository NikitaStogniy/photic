import '/flutter_flow/flutter_flow_util.dart';
import 'pack_page_widget.dart' show PackPageWidget;
import 'package:flutter/material.dart';

class PackPageModel extends FlutterFlowModel<PackPageWidget> {
  ///  Local state fields for this page.

  int? loopCounter = 1;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Custom Action - downloadImage] action in IconButton widget.
  String? download;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
