import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'painter_widget.dart' show PainterWidget;
import 'package:flutter/material.dart';

class PainterModel extends FlutterFlowModel<PainterWidget> {
  ///  Local state fields for this page.

  int? step = 0;

  String? image = 'false';

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for Slider widget.
  double? sliderValue;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - API (applyMask)] action in Button widget.
  ApiCallResponse? firstMask;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  AiImageRecord? gene;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  PendingRecord? ref;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
