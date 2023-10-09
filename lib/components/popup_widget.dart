import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'popup_model.dart';
export 'popup_model.dart';

class PopupWidget extends StatefulWidget {
  const PopupWidget({
    Key? key,
    required this.headline,
    required this.text,
  }) : super(key: key);

  final String? headline;
  final String? text;

  @override
  _PopupWidgetState createState() => _PopupWidgetState();
}

class _PopupWidgetState extends State<PopupWidget> {
  late PopupModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PopupModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(24.0, 16.0, 24.0, 16.0),
      child: Material(
        color: Colors.transparent,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            constraints: BoxConstraints(
              maxHeight: 500.0,
            ),
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).primaryBackground,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: FlutterFlowTheme.of(context).secondaryText,
                width: 1.0,
              ),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.close,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 24.0,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ClipRRect(
                      child: Container(
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 8.0, 0.0, 0.0),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 8.0),
                                  child: Text(
                                    widget.headline!,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                                Text(
                                  widget.text == 'Terms'
                                      ? FFAppState().TermsOfUse
                                      : FFAppState().PrivacyPolicy,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Inter',
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
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
