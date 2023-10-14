import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/rendering.dart';
import 'package:photiq/custom_code/actions/get_my_custom_widge_current_value.dart';
import 'package:photiq/custom_code/widgets/edit_painter/view/drawing_canvas/widgets/canvas_side_bar.dart';
import 'package:photiq/custom_code/widgets/edit_painter/view/drawing_widget.dart';
import 'package:photiq/generate/painter/source_image.dart';

import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:ui' as ui;
import '/flutter_flow/permissions_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'painter_model.dart';
export 'painter_model.dart';

double stroke = 10;
double? imageRenderHeight;
double? imageRenderWidth;
int? imageOrigHeight;
int? imageOrigWidth;

class PainterWidget extends StatefulWidget {
  const PainterWidget({Key? key}) : super(key: key);

  @override
  _PainterWidgetState createState() => _PainterWidgetState();
}

class _PainterWidgetState extends State<PainterWidget> {
  late PainterModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  Image? image;

  @override
  void initState() {
    super.initState();
    imageRenderHeight = null;
    imageRenderWidth = null;
    imageOrigHeight = null;
    imageOrigWidth = null;
    currentSketchGlobal = null;
    allSketchesGlobal = null;
    strokeSizeGlobal = null;
    _model = createModel(context, () => PainterModel());

    _model.textController ??= TextEditingController();
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
          automaticallyImplyLeading: true,
          title: Text(
            'Inpaint',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Inter',
                  color: Colors.white,
                  fontSize: 22.0,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              if (_model.step == 1)
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0.00, 0.00),
                      child: Builder(builder: (context) {
                        if (image == null && _model.image != null) {
                          print('image is null');
                          image = Image.network(_model.image!);
                          Completer<ui.Image> completer =
                              new Completer<ui.Image>();
                          image!.image
                              .resolve(new ImageConfiguration())
                              .addListener(
                                  ImageStreamListener((ImageInfo info, bool _) {
                            completer.complete(info.image);
                            print(
                                '[eeee] orig image height ${info.image.height}');
                            print(
                                '[eeee] orig image width ${info.image.width}');
                            imageOrigHeight = info.image.height;
                            imageOrigWidth = info.image.width;
                          }));
                        }
                        return Stack(
                          // alignment: AlignmentDirectional(0.0, 0.0),
                          children: [
                            ConstrainedBox(
                              constraints: BoxConstraints(maxHeight: 450),
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: WidgetSizeOffsetWrapper(
                                  onSizeChange: (Size size) {
                                    print(
                                        '[eeee] render size: width ${size.width}, height ${size.height}');
                                    imageRenderHeight = size.height;
                                    imageRenderWidth = size.width;
                                    setState(() {});
                                  },
                                  child: image != null
                                      ? Image(
                                          image: image!.image,
                                          fit: BoxFit.scaleDown,
                                          // height: 400,
                                        )
                                      : Container(),
                                ),
                              ),
                            ),
                            Align(
                              child: ClipRect(
                                child: ImageFiltered(
                                  imageFilter: ui.ImageFilter.blur(
                                    sigmaX: 2.0,
                                    sigmaY: 2.0,
                                  ),
                                  child: image != null &&
                                          imageRenderHeight != null &&
                                          imageRenderWidth != null
                                      ? SizedBox(
                                          height: imageRenderHeight,
                                          width: imageRenderWidth,
                                          child: DrawingWidget(
                                            height: imageRenderHeight!,
                                            width: imageRenderWidth!,
                                          ),
                                        )
                                      : Container(),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 450 - 80,
                      child: ListView(
                        children: [
                          if (allSketchesGlobal != null &&
                              currentSketchGlobal != null &&
                              strokeSizeGlobal != null)
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 16.0, 16.0, 0.0),
                              child: Container(
                                color: Colors.black,
                                child: GestureDetector(
                                  onTap: () => {setState(() {})},
                                  child: Row(
                                    children: [
                                      CanvasSideBar(
                                        currentSketch: currentSketchGlobal!,
                                        allSketches: allSketchesGlobal!,
                                        strokeSize: strokeSizeGlobal!,
                                      ),
                                      Expanded(
                                        child: Slider(
                                          activeColor: Colors.white,
                                          inactiveColor: Colors.white30,
                                          value: strokeSizeGlobal!.value,
                                          min: 0,
                                          max: 50,
                                          onChanged: (val) {
                                            strokeSizeGlobal!.value = val;
                                            setState(() {});
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 16.0, 16.0, 0.0),
                            child: TextFormField(
                              controller: _model.textController,
                              autofocus: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Describe your idea',
                                labelStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Open Sans',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                    ),
                                hintStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Open Sans',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                    ),

                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(

                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    width: 1.0,
                                  ),

                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).primary,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Open Sans',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                  ),
                              validator: _model.textControllerValidator
                                  .asValidator(context),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 16.0, 16.0, 0.0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                final firestoreBatch =
                                    FirebaseFirestore.instance.batch();
                                try {
                                  final uint8list = await getBytes();
                                  _model.getWidget = await uploadResizedMask(
                                    uint8list!,
                                    imageOrigHeight!,
                                    imageOrigWidth!,
                                  );
                                  _model.apiResult74h =
                                      await DebGroup.applyMaskCall.call(
                                    imageUrl: _model.image,
                                    maskImageUrl: _model.getWidget,
                                    prompt: _model.textController.text,
                                  );
                                  if ((_model.apiResult74h?.succeeded ??
                                      true)) {
                                    firestoreBatch
                                        .set(AiImageRecord.collection.doc(), {
                                      ...createAiImageRecordData(
                                        creator: currentUserReference,
                                        firstImage: _model.image,
                                      ),
                                      'generatedImages': [
                                        DebGroup.applyMaskCall.image(
                                          (_model.apiResult74h?.jsonBody ?? ''),
                                        )
                                      ],
                                    });

                                    context.goNamed('HomePage');

                                    setState(() {
                                      _model.step = 0;
                                      _model.image = 'false';
                                    });
                                  } else {
                                    await showDialog(
                                      context: context,
                                      builder: (alertDialogContext) {
                                        return AlertDialog(
                                          title: Text('Err'),
                                          content: Text(
                                              (_model.apiResult74h?.jsonBody ??
                                                      '')
                                                  .toString()),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  alertDialogContext),
                                              child: Text('Ok'),
                                            ),
                                          ],
                                        );
                                      },
                                    );

                                    firestoreBatch.set(
                                        AiImageRecord.collection.doc(),
                                        createAiImageRecordData(
                                          creator: currentUserReference,
                                          firstImage: _model.image,
                                        ));
                                  }
                                } finally {
                                  await firestoreBatch.commit();
                                }

                                setState(() {});
                              },
                              text: 'Edit',
                              options: FFButtonOptions(
                                width: double.infinity,
                                height: 40.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24.0, 0.0, 24.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: Colors.black,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Open Sans',
                                      color: Colors.white,
                                    ),
                                elevation: 3.0,
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              if (_model.step == 0)
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 32.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            Align(
                              alignment: AlignmentDirectional(0.00, 0.00),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                  'assets/images/Group_65.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0.00, 1.00),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        await requestPermission(
                                            cameraPermission);
                                        final selectedMedia = await selectMedia(
                                          imageQuality: 100,
                                          multiImage: false,
                                        );
                                        if (selectedMedia != null &&
                                            selectedMedia.every((m) =>
                                                validateFileFormat(
                                                    m.storagePath, context))) {
                                          setState(() =>
                                              _model.isDataUploading1 = true);
                                          var selectedUploadedFiles =
                                              <FFUploadedFile>[];

                                          var downloadUrls = <String>[];
                                          try {
                                            selectedUploadedFiles =
                                                selectedMedia
                                                    .map((m) => FFUploadedFile(
                                                          name: m.storagePath
                                                              .split('/')
                                                              .last,
                                                          bytes: m.bytes,
                                                          height: m.dimensions
                                                              ?.height,
                                                          width: m.dimensions
                                                              ?.width,
                                                          blurHash: m.blurHash,
                                                        ))
                                                    .toList();

                                            downloadUrls = (await Future.wait(
                                              selectedMedia.map(
                                                (m) async => await uploadData(
                                                    m.storagePath, m.bytes),
                                              ),
                                            ))
                                                .where((u) => u != null)
                                                .map((u) => u!)
                                                .toList();
                                          } finally {
                                            _model.isDataUploading1 = false;
                                          }
                                          if (selectedUploadedFiles.length ==
                                                  selectedMedia.length &&
                                              downloadUrls.length ==
                                                  selectedMedia.length) {
                                            setState(() {
                                              _model.uploadedLocalFile1 =
                                                  selectedUploadedFiles.first;
                                              _model.uploadedFileUrl1 =
                                                  downloadUrls.first;
                                            });
                                          } else {
                                            setState(() {});
                                            return;
                                          }
                                        }

                                        setState(() {
                                          _model.image =
                                              _model.uploadedFileUrl1;
                                          _model.step = _model.step! + 1;
                                        });
                                      },
                                      child: Container(
                                        width: 48.0,
                                        height: 48.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          border: Border.all(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional(0.00, 0.00),
                                          child: SvgPicture.asset(
                                            'assets/images/images.svg',
                                            width: 24.0,
                                            height: 24.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 0.0, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            await requestPermission(
                                                photoLibraryPermission);
                                            final selectedMedia =
                                                await selectMedia(
                                              imageQuality: 100,
                                              mediaSource:
                                                  MediaSource.photoGallery,
                                              multiImage: false,
                                            );
                                            if (selectedMedia != null &&
                                                selectedMedia.every((m) =>
                                                    validateFileFormat(
                                                        m.storagePath,
                                                        context))) {
                                              setState(() => _model
                                                  .isDataUploading2 = true);
                                              var selectedUploadedFiles =
                                                  <FFUploadedFile>[];

                                              var downloadUrls = <String>[];
                                              try {
                                                selectedUploadedFiles =
                                                    selectedMedia
                                                        .map((m) =>
                                                            FFUploadedFile(
                                                              name: m
                                                                  .storagePath
                                                                  .split('/')
                                                                  .last,
                                                              bytes: m.bytes,
                                                              height: m
                                                                  .dimensions
                                                                  ?.height,
                                                              width: m
                                                                  .dimensions
                                                                  ?.width,
                                                              blurHash:
                                                                  m.blurHash,
                                                            ))
                                                        .toList();

                                                downloadUrls =
                                                    (await Future.wait(
                                                  selectedMedia.map(
                                                    (m) async =>
                                                        await uploadData(
                                                            m.storagePath,
                                                            m.bytes),
                                                  ),
                                                ))
                                                        .where((u) => u != null)
                                                        .map((u) => u!)
                                                        .toList();
                                              } finally {
                                                _model.isDataUploading2 = false;
                                              }
                                              if (selectedUploadedFiles
                                                          .length ==
                                                      selectedMedia.length &&
                                                  downloadUrls.length ==
                                                      selectedMedia.length) {
                                                setState(() {
                                                  _model.uploadedLocalFile2 =
                                                      selectedUploadedFiles
                                                          .first;
                                                  _model.uploadedFileUrl2 =
                                                      downloadUrls.first;
                                                });
                                              } else {
                                                setState(() {});
                                                return;
                                              }
                                            }

                                            setState(() {
                                              _model.step = _model.step! + 1;
                                              _model.image =
                                                  _model.uploadedFileUrl2;
                                            });
                                          },
                                          text: 'Upload',
                                          options: FFButtonOptions(
                                            width: 130.0,
                                            height: 48.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'Inter',
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                    ),
                                            elevation: 0.0,
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
    );
  }

  Future<Uint8List?> getBytes() async {
    RenderRepaintBoundary boundary =
        canvasKey!.currentContext?.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List? pngBytes = byteData?.buffer.asUint8List();
    return pngBytes;
  }
}
