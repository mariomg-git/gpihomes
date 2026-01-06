import '/backend/backend.dart';
import '/components/filter_modal/filter_modal_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:math';
import 'home_page_m_a_i_n_model.dart';
export 'home_page_m_a_i_n_model.dart';

class HomePageMAINWidget extends StatefulWidget {
  const HomePageMAINWidget({super.key});

  @override
  State<HomePageMAINWidget> createState() => _HomePageMAINWidgetState();
}

class _HomePageMAINWidgetState extends State<HomePageMAINWidget> {
  late HomePageMAINModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageMAINModel());
    
    // Inicializar con valores guardados de FFAppState
    _model.filterMinPrice = FFAppState().filterMinPrice;
    _model.filterMaxPrice = FFAppState().filterMaxPrice;
    _model.filterRooms = FFAppState().filterRooms;
    _model.filterType = FFAppState().filterType;
    _model.filterRadiusKm = FFAppState().filterRadiusKm;

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  // Haversine formula to calculate distance between two coordinates in kilometers
  double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadiusKm = 6371.0;
    
    double dLat = _degreesToRadians(lat2 - lat1);
    double dLon = _degreesToRadians(lon2 - lon1);
    
    lat1 = _degreesToRadians(lat1);
    lat2 = _degreesToRadians(lat2);
    
    double a = (sin(dLat / 2) * sin(dLat / 2)) +
        (sin(dLon / 2) * sin(dLon / 2)) * cos(lat1) * cos(lat2);
    double c = 2 * asin(sqrt(a));
    
    return earthRadiusKm * c;
  }
  
  double _degreesToRadians(double degrees) {
    return degrees * pi / 180.0;
  }

  @override
  Widget build(BuildContext context) {
    return Title(
        title: 'homePage_MAIN',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: const Color(0x7A908888),
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  child: Container(
                    width: double.infinity,
                    height: 400.0,
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
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).accent3,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              24.0, 12.0, 24.0, 8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                'assets/images/GPI-Homes-black.png',
                                width: 200.0,
                                height: 50.0,
                                fit: BoxFit.contain,
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 15.0, 0.0, 0.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    final filterResults = await showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      enableDrag: false,
                                      context: context,
                                      builder: (context) {
                                        return Padding(
                                          padding: MediaQuery.viewInsetsOf(context),
                                          child: const FilterModalWidget(),
                                        );
                                      },
                                    );
                                    
                                    if (filterResults != null) {
                                      safeSetState(() {
                                        _model.filterMinPrice = filterResults['minPrice'] ?? 0;
                                        _model.filterMaxPrice = filterResults['maxPrice'] ?? 5000000;
                                        _model.filterRooms = filterResults['rooms'];
                                        _model.filterType = filterResults['type'];
                                        _model.filterRadiusKm = filterResults['radiusKm'] ?? 50.0;
                                        
                                        // Update FFAppState for map circle - this will trigger map rebuild
                                        FFAppState().radioCircle = _model.filterRadiusKm;
                                      });
                                    }
                                  },
                                  text: FFLocalizations.of(context).getText(
                                    'orqu6q11' /* Filters */,
                                  ),
                                  icon: const Icon(
                                    Icons.filter_list_alt,
                                    size: 25.0,
                                  ),
                                  options: FFButtonOptions(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.25,
                                    height: 40.0,
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        5.0, 0.0, 5.0, 0.0),
                                    iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: const Color(0x9B4B39EF),
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
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              5.0, 0.0, 5.0, 0.0),
                          child: Stack(
                            children: [
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width * 1.0,
                                height: 300.0,
                                child: custom_widgets.MapPropiedades(
                                  width: MediaQuery.sizeOf(context).width * 1.0,
                                  height: 300.0,
                                  actionPaarama: () async {
                                    safeSetState(() {});
                                  },                                tipoPropiedad: 'Renta',                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                  child: StreamBuilder<List<PropertiesRecord>>(
                    stream: queryPropertiesRecord(
                      queryBuilder: (propertiesRecord) => propertiesRecord
                          .where(
                            'tipoPropiedad',
                            isEqualTo: 'Renta',
                          )
                          .where(
                            'status',
                            isEqualTo: 'Revisado',
                          ),
                    ),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return Center(
                          child: SizedBox(
                            width: 50.0,
                            height: 50.0,
                            child: SpinKitThreeBounce(
                              color: FlutterFlowTheme.of(context).primary,
                              size: 50.0,
                            ),
                          ),
                        );
                      }
                      List<PropertiesRecord> allProperties = snapshot.data!;
                      
                      // DEBUG: Log inicial
                      print('========== FILTRO DEBUG ==========');
                      print('Total propiedades RAW: ${allProperties.length}');
                      print('Ubicación mapa: ${FFAppState().ubicacionMapaPrinc}');
                      print('Radio filtro: ${_model.filterRadiusKm} km');
                      print('Aplicar filtro distancia: ${_model.applyDistanceFilter}');
                      
                      // Filtrar propiedades válidas primero
                      allProperties = allProperties.where((p) {
                        bool hasPrice = p.hasPrice();
                        bool hasCoords = p.hasPropertyCoords();
                        if (!hasPrice) print('⚠️ ${p.propertyName} - Sin precio');
                        if (!hasCoords) print('⚠️ ${p.propertyName} - Sin coordenadas');
                        return hasPrice; // Al menos debe tener precio
                      }).toList();
                      
                      print('Total propiedades VÁLIDAS: ${allProperties.length}');
                      
                      // Apply filters
                      List<PropertiesRecord> listViewPropertiesRecordList = allProperties.where((property) {
                        // Price filter - solo si no es el rango completo
                        if (_model.filterMinPrice > 0 || _model.filterMaxPrice < 5000000) {
                          if (property.price < _model.filterMinPrice || property.price > _model.filterMaxPrice) {
                            print('Filtrado por precio: ${property.propertyName}');
                            return false;
                          }
                        }
                        
                        // Rooms filter
                        if (_model.filterRooms != null && property.roomsPropiedad != _model.filterRooms) {
                          print('Filtrado por habitaciones: ${property.propertyName}');
                          return false;
                        }
                        
                        // Property type filter
                        if (_model.filterType != null && property.tipoVendedor != _model.filterType) {
                          print('Filtrado por tipo: ${property.propertyName}');
                          return false;
                        }
                        
                        // Distance filter - SIEMPRE aplicar si hay ubicación
                        if (_model.applyDistanceFilter && FFAppState().ubicacionMapaPrinc != null && property.propertyCoords != null) {
                          double distance = _calculateDistance(
                            FFAppState().ubicacionMapaPrinc!.latitude,
                            FFAppState().ubicacionMapaPrinc!.longitude,
                            property.propertyCoords!.latitude,
                            property.propertyCoords!.longitude,
                          );
                          print('${property.propertyName} - Distancia: ${distance.toStringAsFixed(2)} km');
                          if (distance > _model.filterRadiusKm) {
                            print('  ❌ Fuera del radio (>${_model.filterRadiusKm} km)');
                            return false;
                          }
                          print('  ✅ Dentro del radio');
                        } else if (_model.applyDistanceFilter && property.propertyCoords == null) {
                          print('${property.propertyName} - ⚠️ Sin coordenadas, excluido del filtro de distancia');
                          return false; // Excluir propiedades sin coordenadas cuando se aplica filtro de distancia
                        }
                        
                        return true;
                      }).toList();
                      
                      print('Propiedades después del filtro: ${listViewPropertiesRecordList.length}');
                      print('==================================');

                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: listViewPropertiesRecordList.length,
                        itemBuilder: (context, listViewIndex) {
                          final listViewPropertiesRecord =
                              listViewPropertiesRecordList[listViewIndex];
                          return Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 12.0),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 8.0,
                                    color: Color(0x1A000000),
                                    offset: Offset(
                                      0.0,
                                      2.0,
                                    ),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.pushNamed(
                                    'propertyDetails',
                                    queryParameters: {
                                      'propertyRef': serializeParam(
                                        listViewPropertiesRecord,
                                        ParamType.Document,
                                      ),
                                    }.withoutNulls,
                                    extra: <String, dynamic>{
                                      'propertyRef': listViewPropertiesRecord,
                                    },
                                  );
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Hero(
                                      tag: valueOrDefault<String>(
                                        listViewPropertiesRecord.mainImage,
                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/sample-app-property-finder-834ebu/assets/jyeiyll24v90/pixasquare-4ojhpgKpS68-unsplash.jpg' '$listViewIndex',
                                      ),
                                      transitionOnUserGestures: true,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(0.0),
                                          bottomRight: Radius.circular(0.0),
                                          topLeft: Radius.circular(12.0),
                                          topRight: Radius.circular(12.0),
                                        ),
                                        child: CachedNetworkImage(
                                          fadeInDuration:
                                              const Duration(milliseconds: 500),
                                          fadeOutDuration:
                                              const Duration(milliseconds: 500),
                                          imageUrl: valueOrDefault<String>(
                                            listViewPropertiesRecord.mainImage,
                                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/sample-app-property-finder-834ebu/assets/jyeiyll24v90/pixasquare-4ojhpgKpS68-unsplash.jpg',
                                          ),
                                          width: double.infinity,
                                          height: 190.0,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) => Container(
                                            color: FlutterFlowTheme.of(context).accent1,
                                            child: Center(
                                              child: Icon(
                                                Icons.home_outlined,
                                                size: 48.0,
                                                color: FlutterFlowTheme.of(context).accent3,
                                              ),
                                            ),
                                          ),
                                          errorWidget: (context, url, error) => Container(
                                            color: FlutterFlowTheme.of(context).accent1,
                                            child: Center(
                                              child: Icon(
                                                Icons.broken_image_outlined,
                                                size: 48.0,
                                                color: FlutterFlowTheme.of(context).error,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          16.0, 12.0, 16.0, 8.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              listViewPropertiesRecord
                                                  .propertyName
                                                  .maybeHandleOverflow(
                                                maxChars: 36,
                                                replacement: '…',
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineSmall
                                                      .override(
                                                        fontFamily:
                                                            'Poiret One',
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 8.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              listViewPropertiesRecord
                                                  .propertyNeighborhood
                                                  .maybeHandleOverflow(
                                                maxChars: 90,
                                                replacement: '…',
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Poiret One',
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    StreamBuilder<List<ReviewsRecord>>(
                                      stream: queryReviewsRecord(
                                        queryBuilder: (reviewsRecord) =>
                                            reviewsRecord.where(
                                          'propertyRef',
                                          isEqualTo: listViewPropertiesRecord
                                              .reference,
                                        ),
                                      ),
                                      builder: (context, snapshot) {
                                        // Customize what your widget looks like when it's loading.
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: SizedBox(
                                              width: 50.0,
                                              height: 50.0,
                                              child: SpinKitThreeBounce(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                size: 50.0,
                                              ),
                                            ),
                                          );
                                        }
                                        List<ReviewsRecord>
                                            containerReviewsRecordList =
                                            snapshot.data!;

                                        return Container(
                                          height: 40.0,
                                          decoration: const BoxDecoration(),
                                          child: Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 24.0, 12.0),
                                            child: StreamBuilder<
                                                List<ReviewsRecord>>(
                                              stream: queryReviewsRecord(
                                                queryBuilder: (reviewsRecord) =>
                                                    reviewsRecord.where(
                                                  'propertyRef',
                                                  isEqualTo:
                                                      listViewPropertiesRecord
                                                          .reference,
                                                ),
                                                singleRecord: true,
                                              ),
                                              builder: (context, snapshot) {
                                                // Customize what your widget looks like when it's loading.
                                                if (!snapshot.hasData) {
                                                  return Center(
                                                    child: SizedBox(
                                                      width: 50.0,
                                                      height: 50.0,
                                                      child: SpinKitThreeBounce(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        size: 50.0,
                                                      ),
                                                    ),
                                                  );
                                                }
                                                List<ReviewsRecord>
                                                    ratingBarReviewsRecordList =
                                                    snapshot.data!;
                                                final ratingBarReviewsRecord =
                                                    ratingBarReviewsRecordList
                                                            .isNotEmpty
                                                        ? ratingBarReviewsRecordList
                                                            .first
                                                        : null;

                                                return Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    const Icon(
                                                      Icons.star_rounded,
                                                      color: Color(0xFFFFA130),
                                                      size: 24.0,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  4.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Text(
                                                        functions.ratingSummaryList(
                                                            containerReviewsRecordList
                                                                .toList()),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Poiret One',
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  2.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          'jex417fd' /* Rating */,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Poiret One',
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 80.0),
              ],
            ),
          ),
        ));
  }
}
