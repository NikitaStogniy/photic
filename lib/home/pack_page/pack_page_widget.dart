import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'pack_page_model.dart';
export 'pack_page_model.dart';

class PackPageWidget extends StatefulWidget {
  const PackPageWidget({
    Key? key,
    String? packNum,
    required this.pack,
  })  : this.packNum = packNum ?? '1',
        super(key: key);

  final String packNum;
  final AiImageRecord? pack;

  @override
  _PackPageWidgetState createState() => _PackPageWidgetState();
}

class _PackPageWidgetState extends State<PackPageWidget> {
  late PackPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PackPageModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.close,
              color: FlutterFlowTheme.of(context).primaryBackground,
              size: 30.0,
            ),
            onPressed: () async {
              context.safePop();
            },
          ),
          title: Text(
            'Генерация #${widget.packNum}',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Open Sans',
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  fontSize: 22.0,
                ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(0.00, -1.00),
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: 600.0,
                  ),
                  decoration: BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              8.0, 32.0, 8.0, 0.0),
                          child: Builder(
                            builder: (context) {
                              final imgs =
                                  widget.pack?.generatedImages?.toList() ?? [];
                              return GridView.builder(
                                padding: EdgeInsets.zero,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 8.0,
                                  mainAxisSpacing: 8.0,
                                  childAspectRatio: 1.0,
                                ),
                                scrollDirection: Axis.vertical,
                                itemCount: imgs.length,
                                itemBuilder: (context, imgsIndex) {
                                  final imgsItem = imgs[imgsIndex];
                                  return Align(
                                    alignment: AlignmentDirectional(0.00, 0.00),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        await Navigator.push(
                                          context,
                                          PageTransition(
                                            type: PageTransitionType.fade,
                                            child: FlutterFlowExpandedImageView(
                                              image: Image.network(
                                                imgsItem,
                                                fit: BoxFit.contain,
                                              ),
                                              allowRotation: false,
                                              tag: imgsItem,
                                              useHeroAnimation: true,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Hero(
                                        tag: imgsItem,
                                        transitionOnUserGestures: true,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          child: Image.network(
                                            imgsItem,
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                5.0,
                                            height: 300.0,
                                            fit: BoxFit.cover,
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
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.00, 0.80),
                child: Material(
                  color: Colors.transparent,
                  elevation: 10.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryText,
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(8.0, 4.0, 8.0, 4.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FlutterFlowIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 30.0,
                            borderWidth: 1.0,
                            buttonSize: 60.0,
                            icon: Icon(
                              Icons.file_download,
                              color: FlutterFlowTheme.of(context).accent2,
                              size: 30.0,
                            ),
                            onPressed: () async {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: Text('Downloads'),
                                    content: Text('Terst'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(alertDialogContext),
                                        child: Text('Ok'),
                                      ),
                                    ],
                                  );
                                },
                              );
                              _model.successImage = await actions.downloadImage(
                                widget.pack?.generatedImages?.first,
                                isiOS,
                                isAndroid,
                                true,
                              );
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: Text('Downloads'),
                                    content: Text(_model.successImage!),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(alertDialogContext),
                                        child: Text('Ok'),
                                      ),
                                    ],
                                  );
                                },
                              );
                              if (widget.pack!.generatedImages.length > 1) {
                                while (_model.loopCounter! <
                                    widget.pack!.generatedImages.length) {
                                  await actions.downloadImage(
                                    widget.pack?.generatedImages?[
                                        _model.loopCounter! - 1],
                                    isiOS,
                                    isAndroid,
                                    isWeb,
                                  );
                                  setState(() {
                                    _model.loopCounter =
                                        _model.loopCounter! + 1;
                                  });
                                }
                              } else {
                                _model.success = await actions.downloadImage(
                                  widget.pack?.generatedImages?.first,
                                  isiOS,
                                  isAndroid,
                                  isWeb,
                                );
                                await showDialog(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return AlertDialog(
                                      title: Text('Downloads'),
                                      content: Text(_model.success!),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(alertDialogContext),
                                          child: Text('Ok'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }

                              setState(() {
                                _model.loopCounter = 1;
                              });

                              setState(() {});
                            },
                          ),
                          FlutterFlowIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 30.0,
                            borderWidth: 1.0,
                            buttonSize: 60.0,
                            icon: Icon(
                              Icons.plus_one,
                              color: FlutterFlowTheme.of(context).accent2,
                              size: 30.0,
                            ),
                            onPressed: () async {
                              _model.faceSwap =
                                  await DebGroup.faceSwapCall.call(
                                firstImage: widget.pack?.firstImage,
                                secondImage: widget.pack?.refImage,
                              );
                              if ((_model.faceSwap?.succeeded ?? true)) {
                                context.goNamed(
                                  'generate_holder',
                                  queryParameters: {
                                    'id': serializeParam(
                                      DebGroup.faceSwapCall
                                          .id(
                                            (_model.faceSwap?.jsonBody ?? ''),
                                          )
                                          .toString(),
                                      ParamType.String,
                                    ),
                                    'packRef': serializeParam(
                                      widget.pack?.reference,
                                      ParamType.DocumentReference,
                                    ),
                                  }.withoutNulls,
                                );
                              } else {
                                await showDialog(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return AlertDialog(
                                      title: Text(
                                          (_model.faceSwap?.statusCode ?? 200)
                                              .toString()),
                                      content: Text(
                                          (_model.faceSwap?.jsonBody ?? '')
                                              .toString()),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(alertDialogContext),
                                          child: Text('Ok'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }

                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
