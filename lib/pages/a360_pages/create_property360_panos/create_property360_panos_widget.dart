import '/components/a_modal_ver_panos_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'create_property360_panos_model.dart';
export 'create_property360_panos_model.dart';

class CreateProperty360PanosWidget extends StatefulWidget {
  const CreateProperty360PanosWidget({
    super.key,
    required this.idProperty,
    required this.idVirtualTour,
  });

  final String? idProperty;
  final String? idVirtualTour;

  @override
  State<CreateProperty360PanosWidget> createState() =>
      _CreateProperty360PanosWidgetState();
}

class _CreateProperty360PanosWidgetState
    extends State<CreateProperty360PanosWidget> {
  late CreateProperty360PanosModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreateProperty360PanosModel());

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
        title: 'createProperty360Panos',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          body: Stack(
            children: [
              // Widget principal con el creador de panoramas
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: MediaQuery.sizeOf(context).height * 1.0,
                child: custom_widgets.APanosCreator(
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  height: MediaQuery.sizeOf(context).height * 1.0,
                  idVirtualTour: widget.idVirtualTour,
                  actionParam360wdget: () async {
                    await showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      enableDrag: false,
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: MediaQuery.viewInsetsOf(context),
                          child: SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.95,
                            child: AModalVerPanosWidget(
                              idVirtualTour: widget.idVirtualTour,
                            ),
                          ),
                        );
                      },
                    ).then((value) => safeSetState(() {}));
                  },
                ),
              ),
              // Botón flotante en la esquina superior derecha
              Positioned(
                top: 16.0,
                right: 16.0,
                child: SafeArea(
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: FFButtonWidget(
                      onPressed: () async {
                        context.pushNamed('homePage_MAIN');
                      },
                      text: FFLocalizations.of(context).getText(
                        '088zd5nf' /* Finish */,
                      ),
                      icon: const Icon(
                        Icons.check_circle,
                        size: 18.0,
                      ),
                      options: FFButtonOptions(
                        height: 40.0,
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        iconPadding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 0.0, 4.0, 0.0),
                        color: FlutterFlowTheme.of(context).success,
                        textStyle: FlutterFlowTheme.of(context)
                            .labelMedium
                            .override(
                              fontFamily: 'Poiret One',
                              color: Colors.white,
                              fontSize: 14.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                            ),
                        elevation: 4.0,
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
