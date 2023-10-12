import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'auth_page_widget.dart' show AuthPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AuthPageModel extends FlutterFlowModel<AuthPageWidget> {
  ///  Local state fields for this page.

  bool? create = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for TextField widget.
  TextEditingController? emailTextController1;
  String? Function(BuildContext, String?)? emailTextController1Validator;
  // State field(s) for TextField widget.
  TextEditingController? passwordTextController1;
  late bool passwordVisibility1;
  String? Function(BuildContext, String?)? passwordTextController1Validator;
  // State field(s) for TextField widget.
  TextEditingController? confirmPasswordTextController0;
  late bool passwordVisibility2;
  String? Function(BuildContext, String?)?
      confirmPasswordTextController0Validator;
  // State field(s) for SignInEmail widget.
  TextEditingController? signInEmailController;
  String? Function(BuildContext, String?)? signInEmailControllerValidator;
  // State field(s) for SignInPassword widget.
  TextEditingController? signInPasswordController;
  late bool signInPasswordVisibility;
  String? Function(BuildContext, String?)? signInPasswordControllerValidator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    passwordVisibility1 = false;
    passwordVisibility2 = false;
    signInPasswordVisibility = false;
  }

  void dispose() {
    unfocusNode.dispose();
    emailTextController1?.dispose();
    passwordTextController1?.dispose();
    confirmPasswordTextController0?.dispose();
    signInEmailController?.dispose();
    signInPasswordController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
