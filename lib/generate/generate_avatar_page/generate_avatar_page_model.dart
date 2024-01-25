import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'generate_avatar_page_widget.dart' show GenerateAvatarPageWidget;
import 'package:flutter/material.dart';

class GenerateAvatarPageModel
    extends FlutterFlowModel<GenerateAvatarPageWidget> {
  ///  Local state fields for this page.

  int step = 1;

  String? gender;

  StylesRecord? style;

  String? uploaded;

  bool isLegalAge = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  bool isDataUploading1 = false;
  FFUploadedFile uploadedLocalFile1 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl1 = '';

  bool isDataUploading2 = false;
  FFUploadedFile uploadedLocalFile2 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl2 = '';

  // Stores action output result for [Backend Call - API (FaceSwap)] action in Button widget.
  ApiCallResponse? firstAvatart;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  AiImageRecord? generation;

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
