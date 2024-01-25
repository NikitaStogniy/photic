import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/revenue_cat_util.dart' as revenue_cat;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'subscribtion_model.dart';
export 'subscribtion_model.dart';

class SubscribtionWidget extends StatefulWidget {
  const SubscribtionWidget({Key? key}) : super(key: key);

  @override
  _SubscribtionWidgetState createState() => _SubscribtionWidgetState();
}

class _SubscribtionWidgetState extends State<SubscribtionWidget> {
  late SubscribtionModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SubscribtionModel());
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
        body: SafeArea(
          top: true,
          child: Align(
            alignment: AlignmentDirectional(0, -1),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: 600,
              ),
              decoration: BoxDecoration(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Stack(
                        alignment: AlignmentDirectional(0, 0),
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                              child: Text(
                                'Choose a plan',
                                style: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(1, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 24, 16, 0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.goNamed('authPage');
                                },
                                child: Icon(
                                  Icons.close,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(8, 16, 8, 0),
                        child: Material(
                          color: Colors.transparent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0x23F041FF), Color(0x174B39EF)],
                                stops: [0, 1],
                                begin: AlignmentDirectional(-0.98, -1),
                                end: AlignmentDirectional(0.98, 1),
                              ),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 8),
                                    child: Text(
                                      'Open all\nthe potential of our\napplications',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Inter',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                  Text(
                                    'Enjoy unlimited avatars and pictures without limits',
                                    textAlign: TextAlign.start,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.sizeOf(context).width,
                        height: MediaQuery.sizeOf(context).height * 0.6,
                        decoration: BoxDecoration(),
                        child: StreamBuilder<List<PlanListRecord>>(
                          stream: queryPlanListRecord(
                            queryBuilder: (planListRecord) => planListRecord
                                .orderBy('Plan.Price', descending: true),
                          ),
                          builder: (context, snapshot) {
                            // Customize what your widget looks like when it's loading.
                            if (!snapshot.hasData) {
                              return Center(
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      FlutterFlowTheme.of(context).primaryText,
                                    ),
                                  ),
                                ),
                              );
                            }
                            List<PlanListRecord> listViewPlanListRecordList =
                                snapshot.data!;
                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.vertical,
                              itemCount: listViewPlanListRecordList.length,
                              itemBuilder: (context, listViewIndex) {
                                final listViewPlanListRecord =
                                    listViewPlanListRecordList[listViewIndex];
                                return Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      8, 16, 8, 0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      setState(() {
                                        _model.plan = listViewPlanListRecord;
                                      });
                                    },
                                    child: Material(
                                      color: Colors.transparent,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.9,
                                        decoration: BoxDecoration(
                                          color: _model.plan?.reference ==
                                                  listViewPlanListRecord
                                                      .reference
                                              ? FlutterFlowTheme.of(context)
                                                  .primaryText
                                              : Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 12, 0, 12),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(16, 0,
                                                                    8, 0),
                                                        child: Container(
                                                          width: 16,
                                                          height: 16,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.black,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                            border: Border.all(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryText,
                                                            ),
                                                          ),
                                                          child: Visibility(
                                                            visible: _model.plan
                                                                    ?.reference ==
                                                                listViewPlanListRecord
                                                                    .reference,
                                                            child: Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0, 0),
                                                              child: SvgPicture
                                                                  .asset(
                                                                'assets/images/Checkbox.svg',
                                                                width: 8,
                                                                height: 8,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        listViewPlanListRecord
                                                            .plan.name,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  color:
                                                                      valueOrDefault<
                                                                          Color>(
                                                                    _model.plan?.reference ==
                                                                            listViewPlanListRecord
                                                                                .reference
                                                                        ? FlutterFlowTheme.of(context)
                                                                            .primaryBackground
                                                                        : FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                  ),
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 16, 0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      if (listViewPlanListRecord
                                                              .plan.price !=
                                                          0.0)
                                                        Text(
                                                          '${revenue_cat.offerings!.current!.availablePackages.where((e) => e.identifier == listViewPlanListRecord.packageId).toList().first.storeProduct.priceString}',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Inter',
                                                                color:
                                                                    valueOrDefault<
                                                                        Color>(
                                                                  _model.plan?.reference ==
                                                                          listViewPlanListRecord
                                                                              .reference
                                                                      ? FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryBackground
                                                                      : FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                ),
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                        ),
                                                      Text(
                                                        listViewPlanListRecord
                                                                    .plan
                                                                    .price !=
                                                                0.0
                                                            ? '/ mon'
                                                            : 'free',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  color:
                                                                      valueOrDefault<
                                                                          Color>(
                                                                    _model.plan?.reference ==
                                                                            listViewPlanListRecord
                                                                                .reference
                                                                        ? FlutterFlowTheme.of(context)
                                                                            .primaryBackground
                                                                        : FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                  ),
                                                                  fontSize: 12,
                                                                ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            if (_model.plan?.reference ==
                                                listViewPlanListRecord
                                                    .reference)
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(16, 0, 16, 16),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Wrap(
                                                            spacing: 0,
                                                            runSpacing: 0,
                                                            alignment:
                                                                WrapAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                WrapCrossAlignment
                                                                    .start,
                                                            direction:
                                                                Axis.horizontal,
                                                            runAlignment:
                                                                WrapAlignment
                                                                    .start,
                                                            verticalDirection:
                                                                VerticalDirection
                                                                    .down,
                                                            clipBehavior:
                                                                Clip.none,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            4),
                                                                child: Text(
                                                                  listViewPlanListRecord
                                                                      .plan
                                                                      .description,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Inter',
                                                                        color: _model.plan?.reference ==
                                                                                listViewPlanListRecord.reference
                                                                            ? FlutterFlowTheme.of(context).primaryBackground
                                                                            : FlutterFlowTheme.of(context).primaryText,
                                                                      ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          if (listViewPlanListRecord
                                                                  .plan
                                                                  .featureList
                                                                  .first !=
                                                              '0')
                                                            Builder(
                                                              builder:
                                                                  (context) {
                                                                final featureList =
                                                                    listViewPlanListRecord
                                                                        .plan
                                                                        .featureList
                                                                        .toList();
                                                                return Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: List.generate(
                                                                      featureList
                                                                          .length,
                                                                      (featureListIndex) {
                                                                    final featureListItem =
                                                                        featureList[
                                                                            featureListIndex];
                                                                    return Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children:
                                                                          [
                                                                        Container(
                                                                          width:
                                                                              2,
                                                                          height:
                                                                              2,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryBackground,
                                                                            shape:
                                                                                BoxShape.circle,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          featureListItem,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'Inter',
                                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                              ),
                                                                        ),
                                                                      ].divide(SizedBox(width: 2)).addToStart(
                                                                              SizedBox(width: 4)),
                                                                    );
                                                                  }),
                                                                );
                                                              },
                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
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
                      ),
                    ],
                  ),
                  if (valueOrDefault<bool>(
                    _model.plan != null,
                    false,
                  ))
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 48),
                      child: FFButtonWidget(
                        onPressed: !(_model.plan != null)
                            ? null
                            : () async {
                                final firestoreBatch =
                                    FirebaseFirestore.instance.batch();
                                try {
                                  if (_model.plan?.plan?.name == 'Free') {
                                    firestoreBatch.update(
                                        currentUserReference!,
                                        createUsersRecordData(
                                          plan: updatePlanStruct(
                                            _model.plan?.plan,
                                            clearUnsetFields: false,
                                          ),
                                        ));

                                    firestoreBatch.update(
                                        currentUserReference!,
                                        createUsersRecordData(
                                          plan: createPlanStruct(
                                            deadline: functions
                                                .plusMonth(getCurrentTimestamp),
                                            clearUnsetFields: false,
                                          ),
                                        ));

                                    context.goNamed(
                                      'subscription_done',
                                      extra: <String, dynamic>{
                                        kTransitionInfoKey: TransitionInfo(
                                          hasTransition: true,
                                          transitionType:
                                              PageTransitionType.fade,
                                        ),
                                      },
                                    );
                                  } else {
                                    _model.revenue =
                                        await revenue_cat.purchasePackage(
                                            _model.plan!.packageId);
                                    if (revenue_cat
                                        .activeEntitlementIds.isNotEmpty) {
                                      firestoreBatch.update(
                                          currentUserReference!,
                                          createUsersRecordData(
                                            plan: updatePlanStruct(
                                              _model.plan?.plan,
                                              clearUnsetFields: false,
                                            ),
                                          ));

                                      firestoreBatch.update(
                                          currentUserReference!,
                                          createUsersRecordData(
                                            plan: createPlanStruct(
                                              deadline: functions.plusMonth(
                                                  getCurrentTimestamp),
                                              clearUnsetFields: false,
                                            ),
                                          ));

                                      context.goNamed(
                                        'subscription_done',
                                        extra: <String, dynamic>{
                                          kTransitionInfoKey: TransitionInfo(
                                            hasTransition: true,
                                            transitionType:
                                                PageTransitionType.fade,
                                          ),
                                        },
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Try again',
                                            style: TextStyle(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                            ),
                                          ),
                                          duration:
                                              Duration(milliseconds: 4000),
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryText,
                                        ),
                                      );
                                    }
                                  }
                                } finally {
                                  await firestoreBatch.commit();
                                }

                                setState(() {});
                              },
                        text: 'Next',
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 40,
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          iconPadding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color: Color(0x004B39EF),
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Inter',
                                    color: Colors.white,
                                  ),
                          elevation: 0,
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).accent3,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          disabledTextColor:
                              FlutterFlowTheme.of(context).secondaryText,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
