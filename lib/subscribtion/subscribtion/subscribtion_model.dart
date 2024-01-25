import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'subscribtion_widget.dart' show SubscribtionWidget;
import 'package:flutter/material.dart';

class SubscribtionModel extends FlutterFlowModel<SubscribtionWidget> {
  ///  Local state fields for this page.

  PlanListRecord? plan;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

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
