import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'subscribtion_active_widget.dart' show SubscribtionActiveWidget;
import 'package:flutter/material.dart';

class SubscribtionActiveModel
    extends FlutterFlowModel<SubscribtionActiveWidget> {
  ///  Local state fields for this page.

  PlanListRecord? plan;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Firestore Query - Query a collection] action in Subscribtion_active widget.
  PlanListRecord? currentPlan;

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
