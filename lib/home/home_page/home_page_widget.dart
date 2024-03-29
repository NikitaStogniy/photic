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
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

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
              id: _model.pending?[_model.pendingIterator!].id,
            );
            if ((_model.statusApi?.succeeded ?? true) &&
                (DebGroup.statusCheckCall.status(
                      (_model.statusApi?.jsonBody ?? ''),
                    ) ==
                    3) &&
                ((DebGroup.statusCheckCall.result(
                              (_model.statusApi?.jsonBody ?? ''),
                            ) !=
                            null &&
                        DebGroup.statusCheckCall.result(
                              (_model.statusApi?.jsonBody ?? ''),
                            ) !=
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
                      DebGroup.statusCheckCall.result(
                                    (_model.statusApi?.jsonBody ?? ''),
                                  ) !=
                                  null &&
                              DebGroup.statusCheckCall.result(
                                    (_model.statusApi?.jsonBody ?? ''),
                                  ) !=
                                  ''
                          ? DebGroup.statusCheckCall.result(
                              (_model.statusApi?.jsonBody ?? ''),
                            )
                          : DebGroup.statusCheckCall
                              .textResult(
                                (_model.statusApi?.jsonBody ?? ''),
                              )
                              .toString()
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
          if (revenue_cat.activeEntitlementIds.isNotEmpty) {
            firestoreBatch.update(
                currentUserReference!,
                createUsersRecordData(
                  plan: createPlanStruct(
                    deadline: functions.plusMonth(getCurrentTimestamp),
                    inpaintUsed: 0,
                    used: 0,
                    clearUnsetFields: false,
                  ),
                ));
          } else {
            context.goNamed('Subscribtion');
          }
        }
      } finally {
        await firestoreBatch.commit();
      }
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

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
              if (_model.toDelete.isEmpty)
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
                        kTransitionInfoKey: const TransitionInfo(
                          hasTransition: true,
                          transitionType: PageTransitionType.fade,
                          duration: Duration(milliseconds: 0),
                        ),
                      },
                    );
                  },
                ),
              if (_model.toDelete.isNotEmpty)
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
              visible: _model.toDelete.isNotEmpty,
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
                  while (_model.toDelete.isNotEmpty) {
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
            decoration: const BoxDecoration(),
            child: Stack(
              children: [
                StreamBuilder<List<AiImageRecord>>(
                  stream: FFAppState().mainPage(
                    requestFn: () => queryAiImageRecord(
                      queryBuilder: (aiImageRecord) => aiImageRecord.where(
                        'creator',
                        isEqualTo: currentUserReference,
                      ),
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
                      padding: const EdgeInsets.fromLTRB(
                        0,
                        0,
                        0,
                        150.0,
                      ),
                      scrollDirection: Axis.vertical,
                      itemCount: listViewAiImageRecordList.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8.0),
                      itemBuilder: (context, listViewIndex) {
                        final listViewAiImageRecord =
                            listViewAiImageRecordList[listViewIndex];
                        return Align(
                          alignment: const AlignmentDirectional(0.0, 0.0),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 8.0),
                            child: Container(
                              height: 160.0,
                              constraints: const BoxConstraints(
                                maxWidth: 400.0,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: SizedBox(
                                width: double.infinity,
                                height: double.infinity,
                                child: Stack(
                                  children: [
                                    if (listViewAiImageRecord
                                            .generatedImages.isEmpty)
                                      Align(
                                        alignment:
                                            const AlignmentDirectional(0.0, 0.0),
                                        child: Container(
                                          width: double.infinity,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                          ),
                                          alignment:
                                              const AlignmentDirectional(0.0, 0.0),
                                          child: Align(
                                            alignment:
                                                const AlignmentDirectional(0.0, 0.0),
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
                                            .generatedImages.isNotEmpty)
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
                                      alignment: const AlignmentDirectional(0.0, 0.0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          if (listViewAiImageRecord
                                                  .generatedImages.isEmpty) {
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
                                                    const TransitionInfo(
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
                                            color: const Color(0x1A101213),
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          child: Align(
                                            alignment:
                                                const AlignmentDirectional(-0.9, 0.7),
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
                                    if (_model.toDelete.isNotEmpty)
                                      Builder(
                                        builder: (context) {
                                          if (_model.toDelete.contains(
                                              listViewAiImageRecord
                                                  .reference)) {
                                            return Visibility(
                                              visible:
                                                  _model.toDelete.isNotEmpty,
                                              child: Align(
                                                alignment: const AlignmentDirectional(
                                                    -0.9, -0.9),
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
                                                          const AlignmentDirectional(
                                                              0.0, 0.0),
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
                                                  _model.toDelete.isNotEmpty,
                                              child: Align(
                                                alignment: const AlignmentDirectional(
                                                    -0.9, -0.9),
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
                  alignment: const AlignmentDirectional(0.0, 1.0),
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 32.0),
                    child: Container(
                      height: 100.0,
                      constraints: const BoxConstraints(
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
                            alignment: const AlignmentDirectional(0.0, 0.0),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  if (currentUserDocument!.plan.limit >
                                      currentUserDocument!.plan.used) {
                                    await showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor: const Color(0xB4101213),
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
                                            child: SizedBox(
                                              height: MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.5,
                                              child:
                                                  const GenerateBottomsheetWidget(),
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
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  iconPadding: const EdgeInsetsDirectional.fromSTEB(
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
                        ].divide(const SizedBox(height: 8.0)),
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
