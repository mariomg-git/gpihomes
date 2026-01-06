import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'calendar_disponibilidad_user_model.dart';
export 'calendar_disponibilidad_user_model.dart';

class CalendarDisponibilidadUserWidget extends StatefulWidget {
  const CalendarDisponibilidadUserWidget({
    super.key,
    required this.idProperty,
  });

  final String? idProperty;

  @override
  State<CalendarDisponibilidadUserWidget> createState() =>
      _CalendarDisponibilidadUserWidgetState();
}

class _CalendarDisponibilidadUserWidgetState
    extends State<CalendarDisponibilidadUserWidget> {
  late CalendarDisponibilidadUserModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CalendarDisponibilidadUserModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Title(
        title: 'calendarDisponibilidadUser',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          appBar: AppBar(
            backgroundColor: const Color(0xFF764BA2),
            automaticallyImplyLeading: false,
            leading: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30.0,
              borderWidth: 1.0,
              buttonSize: 60.0,
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
                size: 28.0,
              ),
              onPressed: () async {
                context.pop();
              },
            ),
            title: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mis Citas',
                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                        fontFamily: 'Poiret One',
                        color: Colors.white,
                        fontSize: 22.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                Text(
                  'Revisa tus citas programadas',
                  style: FlutterFlowTheme.of(context).bodySmall.override(
                        fontFamily: 'Poiret One',
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 12.0,
                        letterSpacing: 0.0,
                      ),
                ),
              ],
            ),
            actions: const [],
            centerTitle: false,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  height: MediaQuery.sizeOf(context).height * 0.9,
                  child: custom_widgets.CalendarDisponibilidadUsuarios(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: MediaQuery.sizeOf(context).height * 0.9,
                    idPropiedad: '5QHFnZyyL2SmAGIq4CZE',
                    idCurrentUser: currentUserUid,
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 30.0, 0.0, 24.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FFButtonWidget(
                              onPressed: () async {
                                context.pushNamed('homePage_MAIN');
                              },
                              text: FFLocalizations.of(context).getText(
                                '7cc7t3me' /* Finish */,
                              ),
                              options: FFButtonOptions(
                                width: 240.0,
                                height: 60.0,
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).primary,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Poiret One',
                                      color: Colors.white,
                                      letterSpacing: 0.0,
                                    ),
                                elevation: 2.0,
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(40.0),
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
        ));
  }
}
