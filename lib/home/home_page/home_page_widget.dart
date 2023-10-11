import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/generate/generate_bottomsheet/generate_bottomsheet_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      final firestoreBatch = FirebaseFirestore.instance.batch();
      try {
        await actions.lockOrientation();
        if ((currentUserDocument?.plan != null) &&
            (currentUserDocument!.plan.deadline! > getCurrentTimestamp)) {
          _model.pending = await queryPendingRecordOnce(
            parent: currentUserReference,
          );
          while (_model.pendingIterator! <
              valueOrDefault<int>(
                _model.pending?.length,
                1,
              )) {
            _model.statusApi = await DebGroup.statusCheckCall.call(
              id: _model.pending?[_model.pendingIterator!]?.id,
            );
            if ((_model.statusApi?.succeeded ?? true) &&
                (DebGroup.statusCheckCall.status(
                      (_model.statusApi?.jsonBody ?? ''),
                    ) ==
                    3) &&
                ((DebGroup.statusCheckCall
                                .result(
                                  (_model.statusApi?.jsonBody ?? ''),
                                )
                                .toString() !=
                            null &&
                        DebGroup.statusCheckCall
                                .result(
                                  (_model.statusApi?.jsonBody ?? ''),
                                )
                                .toString() !=
                            '') ||
                    (DebGroup.statusCheckCall.textResult(
                          (_model.statusApi?.jsonBody ?? ''),
                        ) !=
                        null))) {
              firestoreBatch
                  .update(_model.pending![_model.pendingIterator!].genRef!, {
                ...mapToFirestore(
                  {
                    'generatedImages': FieldValue.arrayUnion([
                      DebGroup.statusCheckCall
                                      .result(
                                        (_model.statusApi?.jsonBody ?? ''),
                                      )
                                      .toString() !=
                                  null &&
                              DebGroup.statusCheckCall
                                      .result(
                                        (_model.statusApi?.jsonBody ?? ''),
                                      )
                                      .toString() !=
                                  ''
                          ? DebGroup.statusCheckCall.result(
                              (_model.statusApi?.jsonBody ?? ''),
                            )
                          : DebGroup.statusCheckCall.textResult(
                              (_model.statusApi?.jsonBody ?? ''),
                            )
                    ]),
                  },
                ),
              });
              firestoreBatch
                  .delete(_model.pending![_model.pendingIterator!].reference);
              setState(() {
                _model.pendingIterator = _model.pendingIterator! + 1;
              });
            }
            await Future.delayed(const Duration(milliseconds: 5000));
          }
        } else {
          context.goNamed('Subscribtion');
        }
      } finally {
        await firestoreBatch.commit();
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
          leading: Stack(
            children: [
              if (_model.toDelete.length == 0)
                FlutterFlowIconButton(
                  borderRadius: 30.0,
                  borderWidth: 1.0,
                  buttonSize: 60.0,
                  icon: Icon(
                    Icons.settings,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 30.0,
                  ),
                  onPressed: () async {
                    context.pushNamed(
                      'settingsPage',
                      extra: <String, dynamic>{
                        kTransitionInfoKey: TransitionInfo(
                          hasTransition: true,
                          transitionType: PageTransitionType.fade,
                          duration: Duration(milliseconds: 0),
                        ),
                      },
                    );
                  },
                ),
              if (_model.toDelete.length > 0)
                FlutterFlowIconButton(
                  borderColor: Colors.transparent,
                  borderRadius: 30.0,
                  borderWidth: 1.0,
                  buttonSize: 60.0,
                  icon: Icon(
                    Icons.chevron_left,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 30.0,
                  ),
                  onPressed: () async {
                    setState(() {
                      _model.toDelete = [];
                    });
                  },
                ),
            ],
          ),
          actions: [
            Visibility(
              visible: _model.toDelete.length > 0,
              child: FlutterFlowIconButton(
                borderRadius: 100.0,
                borderWidth: 0.0,
                buttonSize: 60.0,
                icon: Icon(
                  Icons.delete,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 24.0,
                ),
                onPressed: () async {
                  while (_model.toDelete.length > 0) {
                    await _model.toDelete.last.delete();
                    setState(() {
                      _model.removeAtIndexFromToDelete(
                          _model.toDelete.length - 1);
                    });
                  }
                },
              ),
            ),
          ],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Container(
            decoration: BoxDecoration(),
            child: Stack(
              children: [
                StreamBuilder<List<AiImageRecord>>(
                  stream: queryAiImageRecord(
                    queryBuilder: (aiImageRecord) => aiImageRecord.where(
                      'creator',
                      isEqualTo: currentUserReference,
                    ),
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              FlutterFlowTheme.of(context).primaryText,
                            ),
                          ),
                        ),
                      );
                    }
                    List<AiImageRecord> listViewAiImageRecordList =
                        snapshot.data!;
                    if (listViewAiImageRecordList.isEmpty) {
                      return Center(
                        child: Image.asset(
                          'assets/images/empty_main.png',
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      );
                    }
                    return ListView.separated(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      itemCount: listViewAiImageRecordList.length,
                      separatorBuilder: (_, __) => SizedBox(height: 8.0),
                      itemBuilder: (context, listViewIndex) {
                        final listViewAiImageRecord =
                            listViewAiImageRecordList[listViewIndex];
                        return Align(
                          alignment: AlignmentDirectional(0.00, 0.00),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 8.0),
                            child: Container(
                              height: 160.0,
                              constraints: BoxConstraints(
                                maxWidth: 400.0,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                child: Stack(
                                  children: [
                                    if (listViewAiImageRecord
                                            .generatedImages.length ==
                                        0)
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.00, 0.00),
                                        child: Container(
                                          width: double.infinity,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                          ),
                                          alignment:
                                              AlignmentDirectional(0.00, 0.00),
                                          child: Align(
                                            alignment: AlignmentDirectional(
                                                0.00, 0.00),
                                            child: Lottie.asset(
                                              'assets/lottie_animations/Loader_main_screen.json',
                                              width: 200.0,
                                              height: 100.0,
                                              fit: BoxFit.contain,
                                              animate: true,
                                            ),
                                          ),
                                        ),
                                      ),
                                    if (listViewAiImageRecord
                                            .generatedImages.length >
                                        0)
                                      Container(
                                        width: double.infinity,
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: Image.network(
                                              listViewAiImageRecord
                                                  .generatedImages.first,
                                            ).image,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                        ),
                                      ),
                                    Align(
                                      alignment:
                                          AlignmentDirectional(0.00, 0.00),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          if (listViewAiImageRecord
                                                  .generatedImages.length ==
                                              0) {
                                            HapticFeedback.lightImpact();
                                          } else {
                                            context.pushNamed(
                                              'packPage',
                                              queryParameters: {
                                                'pack': serializeParam(
                                                  listViewAiImageRecord,
                                                  ParamType.Document,
                                                ),
                                                'packNum': serializeParam(
                                                  valueOrDefault<String>(
                                                    (listViewIndex + 1)
                                                        .toString(),
                                                    '1',
                                                  ),
                                                  ParamType.String,
                                                ),
                                              }.withoutNulls,
                                              extra: <String, dynamic>{
                                                'pack': listViewAiImageRecord,
                                                kTransitionInfoKey:
                                                    TransitionInfo(
                                                  hasTransition: true,
                                                  transitionType:
                                                      PageTransitionType.fade,
                                                  duration:
                                                      Duration(milliseconds: 0),
                                                ),
                                              },
                                            );
                                          }
                                        },
                                        onLongPress: () async {
                                          setState(() {
                                            _model.addToToDelete(
                                                listViewAiImageRecord
                                                    .reference);
                                          });
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Color(0x1A101213),
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          child: Align(
                                            alignment: AlignmentDirectional(
                                                -0.90, 0.70),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Generation #${(listViewIndex + 1).toString()}',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (_model.toDelete.length > 0)
                                      Builder(
                                        builder: (context) {
                                          if (_model.toDelete.contains(
                                              listViewAiImageRecord
                                                  .reference)) {
                                            return Visibility(
                                              visible:
                                                  _model.toDelete.length > 0,
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    -0.90, -0.90),
                                                child: InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    if (_model.toDelete.contains(
                                                        listViewAiImageRecord
                                                            .reference)) {
                                                      setState(() {
                                                        _model.removeFromToDelete(
                                                            listViewAiImageRecord
                                                                .reference);
                                                      });
                                                    } else {
                                                      setState(() {
                                                        _model.addToToDelete(
                                                            listViewAiImageRecord
                                                                .reference);
                                                      });
                                                    }
                                                  },
                                                  child: Container(
                                                    width: 24.0,
                                                    height: 24.0,
                                                    decoration: BoxDecoration(
                                                      color: _model.toDelete
                                                              .contains(
                                                                  listViewAiImageRecord
                                                                      .reference)
                                                          ? FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryBackground
                                                          : FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryBackground,
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                      ),
                                                    ),
                                                    child: Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.00, 0.00),
                                                      child: Container(
                                                        width: 18.0,
                                                        height: 18.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          } else {
                                            return Visibility(
                                              visible:
                                                  _model.toDelete.length > 0,
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    -0.90, -0.90),
                                                child: InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    if (_model.toDelete.contains(
                                                        listViewAiImageRecord
                                                            .reference)) {
                                                      setState(() {
                                                        _model.removeFromToDelete(
                                                            listViewAiImageRecord
                                                                .reference);
                                                      });
                                                    } else {
                                                      setState(() {
                                                        _model.addToToDelete(
                                                            listViewAiImageRecord
                                                                .reference);
                                                      });
                                                    }
                                                  },
                                                  child: Container(
                                                    width: 24.0,
                                                    height: 24.0,
                                                    decoration: BoxDecoration(
                                                      color: _model.toDelete
                                                              .contains(
                                                                  listViewAiImageRecord
                                                                      .reference)
                                                          ? FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText
                                                          : FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryBackground,
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                Align(
                  alignment: AlignmentDirectional(0.00, 1.00),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 32.0),
                    child: Container(
                      height: 100.0,
                      constraints: BoxConstraints(
                        maxWidth: 600.0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0.00, 0.00),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  if (currentUserDocument!.plan.limit >
                                      currentUserDocument!.plan.used) {
                                    await showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor: Color(0xB4101213),
                                      useSafeArea: true,
                                      context: context,
                                      builder: (context) {
                                        return GestureDetector(
                                          onTap: () => _model
                                                  .unfocusNode.canRequestFocus
                                              ? FocusScope.of(context)
                                                  .requestFocus(
                                                      _model.unfocusNode)
                                              : FocusScope.of(context)
                                                  .unfocus(),
                                          child: Padding(
                                            padding: MediaQuery.viewInsetsOf(
                                                context),
                                            child: Container(
                                              height: MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.5,
                                              child:
                                                  GenerateBottomsheetWidget(),
                                            ),
                                          ),
                                        );
                                      },
                                    ).then((value) => safeSetState(() {}));
                                  } else {
                                    context.goNamed('Subscribtion');
                                  }
                                },
                                text: 'Generate',
                                options: FFButtonOptions(
                                  width: double.infinity,
                                  height: 48.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .override(
                                        fontFamily: 'Inter',
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                  elevation: 0.0,
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                            ),
                          ),
                        ].divide(SizedBox(height: 8.0)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
