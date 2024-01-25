import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/generate/generate_bottomsheet/generate_bottomsheet_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/revenue_cat_util.dart' as revenue_cat;
import 'home_page_widget.dart' show HomePageWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  Local state fields for this page.

  bool loading = false;

  String? id;

  String? image;

  String? status;

  int iteration = 0;

  int? pendingIterator = 0;

  List<DocumentReference> toDelete = [];
  void addToToDelete(DocumentReference item) => toDelete.add(item);
  void removeFromToDelete(DocumentReference item) => toDelete.remove(item);
  void removeAtIndexFromToDelete(int index) => toDelete.removeAt(index);
  void insertAtIndexInToDelete(int index, DocumentReference item) =>
      toDelete.insert(index, item);
  void updateToDeleteAtIndex(int index, Function(DocumentReference) updateFn) =>
      toDelete[index] = updateFn(toDelete[index]);

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Firestore Query - Query a collection] action in HomePage widget.
  List<PendingRecord>? pending;
  // Stores action output result for [Backend Call - API (StatusCheck)] action in HomePage widget.
  ApiCallResponse? statusApi;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
