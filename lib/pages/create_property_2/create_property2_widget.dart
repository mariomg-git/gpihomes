import '/backend/backend.dart';
import '/components/amenitity_indicator/amenitity_indicator_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'create_property2_model.dart';
export 'create_property2_model.dart';

class CreateProperty2Widget extends StatefulWidget {
  const CreateProperty2Widget({
    super.key,
    this.propertyRef,
    this.propertyAmenities,
  });

  final PropertiesRecord? propertyRef;
  final AmenititiesRecord? propertyAmenities;

  @override
  State<CreateProperty2Widget> createState() => _CreateProperty2WidgetState();
}

class _CreateProperty2WidgetState extends State<CreateProperty2Widget> {
  late CreateProperty2Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreateProperty2Model());

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
        title: 'createProperty_2',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          appBar: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            automaticallyImplyLeading: false,
            leading: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30.0,
              buttonSize: 46.0,
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Color(0xFF95A1AC),
                size: 25.0,
              ),
              onPressed: () async {
                context.pop();
              },
            ),
            title: Text(
              FFLocalizations.of(context).getText(
                'yxs8b0x3' /* Create Property */,
              ),
              style: FlutterFlowTheme.of(context).headlineSmall.override(
                    fontFamily: 'Poiret One',
                    letterSpacing: 0.0,
                  ),
            ),
            actions: const [],
            centerTitle: false,
            elevation: 0.0,
          ),
          body: SafeArea(
            top: true,
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 12.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    FFLocalizations.of(context).getText(
                                      'cfolpjkd' /* CHOOSE YOUR AMENITIES */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodySmall
                                        .override(
                                          fontFamily: 'Poiret One',
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Stack(
                                  children: [
                                    Align(
                                      alignment: const AlignmentDirectional(0.0, 0.0),
                                      child: wrapWithModel(
                                        model: _model.amenitityIndicatorModel1,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: AmenitityIndicatorWidget(
                                          icon: Icon(
                                            Icons.pool_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .gray600,
                                          ),
                                          background:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                          borderColor:
                                              FlutterFlowTheme.of(context)
                                                  .lineGray,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: SwitchListTile.adaptive(
                                      value: _model.amenityPoolValue ??= false,
                                      onChanged: (newValue) async {
                                        safeSetState(() => _model
                                            .amenityPoolValue = newValue);
                                      },
                                      title: Text(
                                        FFLocalizations.of(context).getText(
                                          'vjuno670' /* Pool */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'Poiret One',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                      tileColor: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      activeColor:
                                          FlutterFlowTheme.of(context).primary,
                                      activeTrackColor: const Color(0xFF392BBA),
                                      dense: false,
                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                      contentPadding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              16.0, 8.0, 0.0, 8.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Stack(
                                  children: [
                                    Align(
                                      alignment: const AlignmentDirectional(0.0, 0.0),
                                      child: wrapWithModel(
                                        model: _model.amenitityIndicatorModel2,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: AmenitityIndicatorWidget(
                                          icon: Icon(
                                            Icons.ev_station_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .gray600,
                                          ),
                                          background:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                          borderColor:
                                              FlutterFlowTheme.of(context)
                                                  .lineGray,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: SwitchListTile.adaptive(
                                      value: _model.amenityEVChargingValue ??=
                                          false,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.amenityEVChargingValue =
                                                newValue);
                                      },
                                      title: Text(
                                        FFLocalizations.of(context).getText(
                                          'bhw032kl' /* EV Car Charging */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'Poiret One',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                      tileColor: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      activeColor:
                                          FlutterFlowTheme.of(context).primary,
                                      activeTrackColor: const Color(0xFF392BBA),
                                      dense: false,
                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                      contentPadding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              16.0, 8.0, 0.0, 8.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Stack(
                                  children: [
                                    Align(
                                      alignment: const AlignmentDirectional(0.0, 0.0),
                                      child: wrapWithModel(
                                        model: _model.amenitityIndicatorModel3,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: AmenitityIndicatorWidget(
                                          icon: Icon(
                                            Icons.ac_unit_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .gray600,
                                          ),
                                          background:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                          borderColor:
                                              FlutterFlowTheme.of(context)
                                                  .lineGray,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: SwitchListTile.adaptive(
                                      value: _model.amenityACValue ??= false,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.amenityACValue = newValue);
                                      },
                                      title: Text(
                                        FFLocalizations.of(context).getText(
                                          'wcr7zdtp' /* Air Conditioning (AC) */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'Poiret One',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                      tileColor: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      activeColor:
                                          FlutterFlowTheme.of(context).primary,
                                      activeTrackColor: const Color(0xFF392BBA),
                                      dense: false,
                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                      contentPadding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              16.0, 8.0, 0.0, 8.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Stack(
                                  children: [
                                    Align(
                                      alignment: const AlignmentDirectional(0.0, 0.0),
                                      child: wrapWithModel(
                                        model: _model.amenitityIndicatorModel4,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: AmenitityIndicatorWidget(
                                          icon: Icon(
                                            Icons.wb_sunny_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .gray600,
                                          ),
                                          background:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                          borderColor:
                                              FlutterFlowTheme.of(context)
                                                  .lineGray,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: SwitchListTile.adaptive(
                                      value: _model.amenityHeatingValue ??=
                                          false,
                                      onChanged: (newValue) async {
                                        safeSetState(() => _model
                                            .amenityHeatingValue = newValue);
                                      },
                                      title: Text(
                                        FFLocalizations.of(context).getText(
                                          '7w1851gr' /* Heating */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'Poiret One',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                      tileColor: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      activeColor:
                                          FlutterFlowTheme.of(context).primary,
                                      activeTrackColor: const Color(0xFF392BBA),
                                      dense: false,
                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                      contentPadding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              16.0, 8.0, 0.0, 8.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Stack(
                                  children: [
                                    Align(
                                      alignment: const AlignmentDirectional(0.0, 0.0),
                                      child: wrapWithModel(
                                        model: _model.amenitityIndicatorModel5,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: AmenitityIndicatorWidget(
                                          icon: Icon(
                                            Icons
                                                .local_laundry_service_outlined,
                                            color: FlutterFlowTheme.of(context)
                                                .gray600,
                                          ),
                                          background:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                          borderColor:
                                              FlutterFlowTheme.of(context)
                                                  .lineGray,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: SwitchListTile.adaptive(
                                      value: _model.amenityWasherValue ??=
                                          false,
                                      onChanged: (newValue) async {
                                        safeSetState(() => _model
                                            .amenityWasherValue = newValue);
                                      },
                                      title: Text(
                                        FFLocalizations.of(context).getText(
                                          'dfkmk8n6' /* Washer */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'Poiret One',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                      tileColor: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      activeColor:
                                          FlutterFlowTheme.of(context).primary,
                                      activeTrackColor: const Color(0xFF392BBA),
                                      dense: false,
                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                      contentPadding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              16.0, 8.0, 0.0, 8.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Stack(
                                  children: [
                                    Align(
                                      alignment: const AlignmentDirectional(0.0, 0.0),
                                      child: wrapWithModel(
                                        model: _model.amenitityIndicatorModel6,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: AmenitityIndicatorWidget(
                                          icon: Icon(
                                            Icons
                                                .local_laundry_service_outlined,
                                            color: FlutterFlowTheme.of(context)
                                                .gray600,
                                          ),
                                          background:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                          borderColor:
                                              FlutterFlowTheme.of(context)
                                                  .lineGray,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: SwitchListTile.adaptive(
                                      value: _model.amenityDryerValue ??= false,
                                      onChanged: (newValue) async {
                                        safeSetState(() => _model
                                            .amenityDryerValue = newValue);
                                      },
                                      title: Text(
                                        FFLocalizations.of(context).getText(
                                          'tmirq250' /* Dryer */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'Poiret One',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                      tileColor: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      activeColor:
                                          FlutterFlowTheme.of(context).primary,
                                      activeTrackColor: const Color(0xFF392BBA),
                                      dense: false,
                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                      contentPadding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              16.0, 8.0, 0.0, 8.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Stack(
                                  children: [
                                    Align(
                                      alignment: const AlignmentDirectional(0.0, 0.0),
                                      child: wrapWithModel(
                                        model: _model.amenitityIndicatorModel7,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: AmenitityIndicatorWidget(
                                          icon: Icon(
                                            Icons.pets_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .gray600,
                                          ),
                                          background:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                          borderColor:
                                              FlutterFlowTheme.of(context)
                                                  .lineGray,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: SwitchListTile.adaptive(
                                      value: _model.amenityPetsValue ??= false,
                                      onChanged: (newValue) async {
                                        safeSetState(() => _model
                                            .amenityPetsValue = newValue);
                                      },
                                      title: Text(
                                        FFLocalizations.of(context).getText(
                                          'eviayn1r' /* Pet Friendly */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'Poiret One',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                      tileColor: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      activeColor:
                                          FlutterFlowTheme.of(context).primary,
                                      activeTrackColor: const Color(0xFF392BBA),
                                      dense: false,
                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                      contentPadding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              16.0, 8.0, 0.0, 8.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Stack(
                                  children: [
                                    Align(
                                      alignment: const AlignmentDirectional(0.0, 0.0),
                                      child: wrapWithModel(
                                        model: _model.amenitityIndicatorModel8,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: AmenitityIndicatorWidget(
                                          icon: Icon(
                                            Icons.fitness_center_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .gray600,
                                          ),
                                          background:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                          borderColor:
                                              FlutterFlowTheme.of(context)
                                                  .lineGray,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: SwitchListTile.adaptive(
                                      value: _model.amenityWorkoutValue ??=
                                          false,
                                      onChanged: (newValue) async {
                                        safeSetState(() => _model
                                            .amenityWorkoutValue = newValue);
                                      },
                                      title: Text(
                                        FFLocalizations.of(context).getText(
                                          'hu1bytza' /* Workout Facility */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'Poiret One',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                      tileColor: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      activeColor:
                                          FlutterFlowTheme.of(context).primary,
                                      activeTrackColor: const Color(0xFF392BBA),
                                      dense: false,
                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                      contentPadding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              16.0, 8.0, 0.0, 8.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(24.0, 12.0, 24.0, 12.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              FFLocalizations.of(context).getText(
                                'j964aodn' /* STEP */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Poiret One',
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            Text(
                              FFLocalizations.of(context).getText(
                                'mbsv29zw' /* 2/3 */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .headlineMedium
                                  .override(
                                    fontFamily: 'Poiret One',
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ],
                        ),
                        FFButtonWidget(
                          onPressed: () async {
                            await widget.propertyAmenities!.reference
                                .update(createAmenititiesRecordData(
                              ac: _model.amenityACValue,
                              heater: _model.amenityHeatingValue,
                              pool: _model.amenityPoolValue,
                              dogFriendly: _model.amenityPetsValue,
                              washer: _model.amenityWasherValue,
                              dryer: _model.amenityDryerValue,
                              workout: _model.amenityWorkoutValue,
                              evCharger: _model.amenityEVChargingValue,
                            ));

                            context.pushNamed(
                              'createProperty_3',
                              queryParameters: {
                                'propertyRef': serializeParam(
                                  widget.propertyRef,
                                  ParamType.Document,
                                ),
                              }.withoutNulls,
                              extra: <String, dynamic>{
                                'propertyRef': widget.propertyRef,
                              },
                            );
                          },
                          text: FFLocalizations.of(context).getText(
                            '5lojo25o' /* NEXT */,
                          ),
                          options: FFButtonOptions(
                            width: 120.0,
                            height: 50.0,
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
                            borderRadius: BorderRadius.circular(60.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
