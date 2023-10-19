import '/auth/firebase_auth/auth_util.dart';
import '/components/loader_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'auth_page_widget.dart' show AuthPageWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AuthPageModel extends FlutterFlowModel<AuthPageWidget> {
  ///  Local state fields for this page.

  bool loader = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for Loader component.
  late LoaderModel loaderModel;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    loaderModel = createModel(context, () => LoaderModel());
  }

  void dispose() {
    unfocusNode.dispose();
    loaderModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
