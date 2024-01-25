import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dialog_widget.dart' show DialogWidget;
import 'package:flutter/material.dart';

class DialogModel extends FlutterFlowModel<DialogWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (FaceSwap)] action in Button widget.
  ApiCallResponse? avatar;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  AiImageRecord? generation;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
