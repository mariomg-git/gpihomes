import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'a_crear_nombre_pano_model.dart';
export 'a_crear_nombre_pano_model.dart';

class ACrearNombrePanoWidget extends StatefulWidget {
  const ACrearNombrePanoWidget({
    super.key,
    required this.idProperty,
  });

  final String? idProperty;

  @override
  State<ACrearNombrePanoWidget> createState() => _ACrearNombrePanoWidgetState();
}

class _ACrearNombrePanoWidgetState extends State<ACrearNombrePanoWidget> {
  late ACrearNombrePanoModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ACrearNombrePanoModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

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
        title: 'aCrearNombrePano',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          appBar: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            automaticallyImplyLeading: false,
            leading: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30.0,
              borderWidth: 1.0,
              buttonSize: 60.0,
              icon: Icon(
                Icons.arrow_back_rounded,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 30.0,
              ),
              onPressed: () async {
                context.pop();
              },
            ),
            title: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 0.0, 0.0),
              child: Text(
                FFLocalizations.of(context).getText(
                  'bhgn671d' /* Version Name */,
                ),
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: 'Poiret One',
                      letterSpacing: 0.0,
                    ),
              ),
            ),
            actions: const [],
            centerTitle: true,
            elevation: 2.0,
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: double.infinity,
                  height: 150.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).dark600,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 3.0,
                        color: Color(0x39000000),
                        offset: Offset(
                          0.0,
                          2.0,
                        ),
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            24.0, 10.0, 0.0, 0.0),
                        child: Image.asset(
                          'assets/images/GPI-Homes-black.png',
                          width: 200.0,
                          height: 50.0,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            24.0, 12.0, 24.0, 8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              FFLocalizations.of(context).getText(
                                'l91hm8sg' /* Welcome! */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .displaySmall
                                  .override(
                                    fontFamily: 'Poiret One',
                                    color:
                                        FlutterFlowTheme.of(context).tertiary,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              FFLocalizations.of(context).getText(
                                'vgu7l9q5' /* Find your Dream Space  */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'Poiret One',
                                    color:
                                        FlutterFlowTheme.of(context).grayIcon,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w300,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
                            0.0, 10.0, 0.0, 24.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              FFLocalizations.of(context).getText(
                                'mnhewfnw' /* Tours: */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyLarge
                                  .override(
                                    fontFamily: 'Poiret One',
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  8.0, 0.0, 8.0, 0.0),
                              child: TextFormField(
                                controller: _model.textController,
                                focusNode: _model.textFieldFocusNode,
                                autofocus: true,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText:
                                      FFLocalizations.of(context).getText(
                                    '5ent2698' /* New Tour */,
                                  ),
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .titleLarge
                                      .override(
                                        fontFamily: 'Poiret One',
                                        letterSpacing: 0.0,
                                      ),
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Poiret One',
                                        letterSpacing: 0.0,
                                      ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedErrorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .displaySmall
                                    .override(
                                      fontFamily: 'Poiret One',
                                      fontSize: 30.0,
                                      letterSpacing: 0.0,
                                    ),
                                textAlign: TextAlign.center,
                                validator: _model.textControllerValidator
                                    .asValidator(context),
                              ),
                            ),
                            FFButtonWidget(
                              onPressed: () async {
                                await VirtualToursRecord.collection
                                    .doc()
                                    .set(createVirtualToursRecordData(
                                      aFechaCreacion: getCurrentTimestamp,
                                      nombre: _model.textController.text,
                                      idPropiedad: widget.idProperty,
                                    ));
                              },
                              text: FFLocalizations.of(context).getText(
                                'orq8it3e' /* Save */,
                              ),
                              options: FFButtonOptions(
                                height: 40.0,
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    24.0, 0.0, 24.0, 0.0),
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
                                elevation: 3.0,
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            StreamBuilder<List<VirtualToursRecord>>(
                              stream: queryVirtualToursRecord(
                                queryBuilder: (virtualToursRecord) =>
                                    virtualToursRecord
                                        .where(
                                          'idPropiedad',
                                          isEqualTo: widget.idProperty,
                                        )
                                        .orderBy('aFechaCreacion',
                                            descending: true),
                              ),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: SizedBox(
                                      width: 50.0,
                                      height: 50.0,
                                      child: SpinKitThreeBounce(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        size: 50.0,
                                      ),
                                    ),
                                  );
                                }
                                List<VirtualToursRecord>
                                    listViewVirtualToursRecordList =
                                    snapshot.data!;
                                
                                // Estado vacío
                                if (listViewVirtualToursRecordList.isEmpty) {
                                  return Padding(
                                    padding: const EdgeInsets.all(24.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.panorama_photosphere_outlined,
                                          size: 100,
                                          color: FlutterFlowTheme.of(context).secondaryText,
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          'No hay tours virtuales',
                                          style: FlutterFlowTheme.of(context).headlineSmall.override(
                                                fontFamily: 'Poiret One',
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Crea tu primer tour 360° usando el formulario de arriba',
                                          textAlign: TextAlign.center,
                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                fontFamily: 'Poiret One',
                                                letterSpacing: 0.0,
                                                color: FlutterFlowTheme.of(context).secondaryText,
                                              ),
                                        ),
                                      ],
                                    ),
                                  );
                                }

                                return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount:
                                      listViewVirtualToursRecordList.length,
                                  itemBuilder: (context, listViewIndex) {
                                    final listViewVirtualToursRecord =
                                        listViewVirtualToursRecordList[
                                            listViewIndex];
                                    
                                    // Verificar si es un tour nuevo (últimos 7 días)
                                    final isNew = listViewVirtualToursRecord.hasAFechaCreacion() &&
                                        listViewVirtualToursRecord.aFechaCreacion!
                                            .isAfter(DateTime.now().subtract(const Duration(days: 7)));
                                    
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                        vertical: 8.0,
                                      ),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          context.pushNamed(
                                            'createProperty360Panos',
                                            queryParameters: {
                                              'idProperty': serializeParam(
                                                widget.idProperty,
                                                ParamType.String,
                                              ),
                                              'idVirtualTour': serializeParam(
                                                listViewVirtualToursRecord
                                                    .reference.id,
                                                ParamType.String,
                                              ),
                                            }.withoutNulls,
                                          );
                                        },
                                        child: Card(
                                          elevation: 4,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(16),
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(16),
                                              gradient: LinearGradient(
                                                colors: [
                                                  FlutterFlowTheme.of(context).primary.withOpacity(0.1),
                                                  FlutterFlowTheme.of(context).secondary.withOpacity(0.05),
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(16.0),
                                              child: Row(
                                                children: [
                                                  // Icono decorativo
                                                  Container(
                                                    width: 80,
                                                    height: 80,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme.of(context).primary.withOpacity(0.2),
                                                      borderRadius: BorderRadius.circular(12),
                                                    ),
                                                    child: Icon(
                                                      Icons.panorama_photosphere,
                                                      size: 40,
                                                      color: FlutterFlowTheme.of(context).primary,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 16),
                                                  // Información del tour
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                listViewVirtualToursRecord.nombre,
                                                                style: FlutterFlowTheme.of(context)
                                                                    .headlineSmall
                                                                    .override(
                                                                      fontFamily: 'Poiret One',
                                                                      fontSize: 20.0,
                                                                      letterSpacing: 0.0,
                                                                      fontWeight: FontWeight.bold,
                                                                    ),
                                                              ),
                                                            ),
                                                            if (isNew)
                                                              Container(
                                                                padding: const EdgeInsets.symmetric(
                                                                  horizontal: 8,
                                                                  vertical: 4,
                                                                ),
                                                                decoration: BoxDecoration(
                                                                  color: FlutterFlowTheme.of(context).error,
                                                                  borderRadius: BorderRadius.circular(12),
                                                                ),
                                                                child: Text(
                                                                  'NUEVO',
                                                                  style: TextStyle(
                                                                    fontSize: 10,
                                                                    color: Colors.white,
                                                                    fontWeight: FontWeight.bold,
                                                                  ),
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                        const SizedBox(height: 8),
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons.calendar_today,
                                                              size: 16,
                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                            ),
                                                            const SizedBox(width: 4),
                                                            Text(
                                                              dateTimeFormat(
                                                                "relative",
                                                                listViewVirtualToursRecord
                                                                    .aFechaCreacion!,
                                                                locale:
                                                                    FFLocalizations.of(context)
                                                                        .languageCode,
                                                              ),
                                                              style: FlutterFlowTheme.of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily: 'Poiret One',
                                                                    fontSize: 13.0,
                                                                    letterSpacing: 0.0,
                                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                                  ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(height: 8),
                                                        // Contador de panoramas
                                                        StreamBuilder<List<NivelesRecord>>(
                                                          stream: queryNivelesRecord(
                                                            parent: listViewVirtualToursRecord.reference,
                                                          ),
                                                          builder: (context, nivelesSnapshot) {
                                                            int panoramaCount = 0;
                                                            if (nivelesSnapshot.hasData) {
                                                              panoramaCount = nivelesSnapshot.data!.length;
                                                            }
                                                            return Row(
                                                              children: [
                                                                Container(
                                                                  padding: const EdgeInsets.symmetric(
                                                                    horizontal: 12,
                                                                    vertical: 6,
                                                                  ),
                                                                  decoration: BoxDecoration(
                                                                    color: FlutterFlowTheme.of(context).accent1,
                                                                    borderRadius: BorderRadius.circular(20),
                                                                  ),
                                                                  child: Row(
                                                                    mainAxisSize: MainAxisSize.min,
                                                                    children: [
                                                                      Icon(
                                                                        Icons.threesixty,
                                                                        size: 16,
                                                                        color: FlutterFlowTheme.of(context).primary,
                                                                      ),
                                                                      const SizedBox(width: 4),
                                                                      Text(
                                                                        'Recorrido Virtual',
                                                                        style: TextStyle(
                                                                          fontSize: 12,
                                                                          color: FlutterFlowTheme.of(context).primary,
                                                                          fontWeight: FontWeight.w600,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                if (panoramaCount > 0) const SizedBox(width: 8),
                                                                if (panoramaCount > 0) Container(
                                                                  padding: const EdgeInsets.symmetric(
                                                                    horizontal: 12,
                                                                    vertical: 6,
                                                                  ),
                                                                  decoration: BoxDecoration(
                                                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                    borderRadius: BorderRadius.circular(20),
                                                                    border: Border.all(
                                                                      color: FlutterFlowTheme.of(context).alternate,
                                                                    ),
                                                                  ),
                                                                  child: Row(
                                                                    mainAxisSize: MainAxisSize.min,
                                                                    children: [
                                                                      Icon(
                                                                        Icons.panorama,
                                                                        size: 14,
                                                                        color: FlutterFlowTheme.of(context).secondaryText,
                                                                      ),
                                                                      const SizedBox(width: 4),
                                                                      Text(
                                                                        '$panoramaCount ${panoramaCount == 1 ? "panorama" : "panoramas"}',
                                                                        style: TextStyle(
                                                                          fontSize: 12,
                                                                          color: FlutterFlowTheme.of(context).secondaryText,
                                                                          fontWeight: FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  // Flecha
                                                  Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: FlutterFlowTheme.of(context)
                                                        .primary,
                                                    size: 24.0,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
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
        ));
  }
}
