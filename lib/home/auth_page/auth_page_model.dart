import '/components/loader_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'auth_page_widget.dart' show AuthPageWidget;
import 'package:flutter/material.dart';

class AuthPageModel extends FlutterFlowModel<AuthPageWidget> {
  ///  Local state fields for this page.

  bool loader = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for Loader component.
  late LoaderModel loaderModel;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    loaderModel = createModel(context, () => LoaderModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    loaderModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
