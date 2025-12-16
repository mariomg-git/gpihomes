import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'modal360_select_prop_model.dart';
export 'modal360_select_prop_model.dart';

class Modal360SelectPropWidget extends StatefulWidget {
  const Modal360SelectPropWidget({
    super.key,
    required this.idProper,
  });

  final String? idProper;

  @override
  State<Modal360SelectPropWidget> createState() =>
      _Modal360SelectPropWidgetState();
}

class _Modal360SelectPropWidgetState extends State<Modal360SelectPropWidget> {
  late Modal360SelectPropModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Modal360SelectPropModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Align(
          alignment: const AlignmentDirectional(0.0, 0.0),
          child: Container(
            width: MediaQuery.sizeOf(context).width * 1.0,
            height: 25.0,
            decoration: const BoxDecoration(),
          ),
        ),
        Align(
          alignment: const AlignmentDirectional(0.0, 0.0),
          child: Container(
            width: MediaQuery.sizeOf(context).width * 1.0,
            height: 50.0,
            decoration: const BoxDecoration(),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 30.0,
                    borderWidth: 1.0,
                    buttonSize: 44.0,
                    fillColor: Colors.black,
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 30.0,
                    ),
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: const AlignmentDirectional(0.0, 0.0),
          child: Container(
            width: MediaQuery.sizeOf(context).width * 0.95,
            height: MediaQuery.sizeOf(context).height * 0.8,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 5.0,
                  color: Color(0x3B1D2429),
                  offset: Offset(
                    0.0,
                    -3.0,
                  ),
                )
              ],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(0.0),
                bottomRight: Radius.circular(0.0),
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          // DEBUG: Mostrar UID del usuario actual
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                border: Border.all(color: Colors.blue),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'DEBUG INFO:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue.shade900,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Usuario actual: ${currentUserUid ?? "NULL"}',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    'Auth UID: ${currentUserReference?.id ?? "NULL"}',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          StreamBuilder<List<PropertiesRecord>>(
                            stream: queryPropertiesRecord(
                              queryBuilder: (propertiesRecord) {
                                // DEBUG: Log de la consulta
                                print('🔍 DEBUG Modal360SelectProp - Iniciando consulta de propiedades');
                                print('🔍 Usuario actual (currentUserUid): $currentUserUid');
                                print('🔍 Usuario reference: ${currentUserReference?.id}');
                                
                                return propertiesRecord
                                    .where(
                                      'idUser',
                                      isEqualTo: currentUserUid,
                                    )
                                    .orderBy('lastUpdated',
                                        descending: true);
                              },
                            ),
                            builder: (context, snapshot) {
                              // DEBUG: Log del estado del snapshot
                              print('🔍 DEBUG Modal360SelectProp - Snapshot State:');
                              print('🔍 connectionState: ${snapshot.connectionState}');
                              print('🔍 hasData: ${snapshot.hasData}');
                              print('🔍 hasError: ${snapshot.hasError}');
                              if (snapshot.hasError) {
                                print('🔍 ERROR: ${snapshot.error}');
                              }
                              
                              // Customize what your widget looks like when it's loading.
                              if (!snapshot.hasData) {
                                return Center(
                                  child: SizedBox(
                                    width: 50.0,
                                    height: 50.0,
                                    child: SpinKitThreeBounce(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      size: 50.0,
                                    ),
                                  ),
                                );
                              }
                              List<PropertiesRecord>
                                  listViewPropertiesRecordList = snapshot.data!;
                              
                              // DEBUG: Log de propiedades encontradas
                              print('🔍 DEBUG Modal360SelectProp - Propiedades encontradas:');
                              print('🔍 Total de propiedades: ${listViewPropertiesRecordList.length}');
                              
                              for (var i = 0; i < listViewPropertiesRecordList.length; i++) {
                                final prop = listViewPropertiesRecordList[i];
                                print('🔍 Propiedad #${i + 1}:');
                                print('   - ID: ${prop.reference.id}');
                                print('   - Nombre: ${prop.propertyName}');
                                print('   - idUser: ${prop.idUser}');
                                print('   - Dirección: ${prop.propertyStreet} ${prop.propertyNumber}');
                                print('   - Tipo: ${prop.tipoPropiedad}');
                                print('   - Estado: ${prop.status}');
                                print('   - Última actualización: ${prop.lastUpdated}');
                              }
                              
                              if (listViewPropertiesRecordList.isEmpty) {
                                return Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(24.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.home_outlined,
                                          size: 80,
                                          color: FlutterFlowTheme.of(context).secondaryText,
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          'No tienes propiedades publicadas',
                                          style: FlutterFlowTheme.of(context).headlineSmall,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Publica una propiedad primero para agregar tours virtuales',
                                          textAlign: TextAlign.center,
                                          style: FlutterFlowTheme.of(context).bodyMedium,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }

                              return ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: listViewPropertiesRecordList.length,
                                itemBuilder: (context, listViewIndex) {
                                  final listViewPropertiesRecord =
                                      listViewPropertiesRecordList[
                                          listViewIndex];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                      vertical: 6.0,
                                    ),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        context.pushNamed(
                                          'aCrearNombrePano',
                                          queryParameters: {
                                            'idProperty': serializeParam(
                                              listViewPropertiesRecord
                                                  .reference.id,
                                              ParamType.String,
                                            ),
                                          }.withoutNulls,
                                        );
                                      },
                                      child: Card(
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12),
                                            border: Border.all(
                                              color: FlutterFlowTheme.of(context)
                                                  .alternate,
                                              width: 1,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // Imagen de la propiedad
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: listViewPropertiesRecord
                                                          .mainImage.isNotEmpty
                                                      ? Image.network(
                                                          listViewPropertiesRecord
                                                              .mainImage,
                                                          width: 100,
                                                          height: 100,
                                                          fit: BoxFit.cover,
                                                          errorBuilder: (context,
                                                              error, stackTrace) {
                                                            return Container(
                                                              width: 100,
                                                              height: 100,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .alternate,
                                                              child: Icon(
                                                                Icons.home,
                                                                size: 40,
                                                                color: FlutterFlowTheme
                                                                        .of(context)
                                                                    .secondaryText,
                                                              ),
                                                            );
                                                          },
                                                        )
                                                      : Container(
                                                          width: 100,
                                                          height: 100,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .alternate,
                                                          child: Icon(
                                                            Icons.home,
                                                            size: 40,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryText,
                                                          ),
                                                        ),
                                                ),
                                                const SizedBox(width: 12),
                                                // Información de la propiedad
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      // Nombre de la propiedad
                                                      Text(
                                                        listViewPropertiesRecord
                                                            .propertyName,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Poiret One',
                                                                  fontSize: 18.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      const SizedBox(height: 4),
                                                      // Dirección
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .location_on_outlined,
                                                            size: 14,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryText,
                                                          ),
                                                          const SizedBox(width: 4),
                                                          Expanded(
                                                            child: Text(
                                                              '${listViewPropertiesRecord.propertyStreet} ${listViewPropertiesRecord.propertyNumber}',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodySmall
                                                                  .override(
                                                                    fontFamily:
                                                                        'Poiret One',
                                                                    fontSize:
                                                                        13.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                  ),
                                                              maxLines: 1,
                                                              overflow: TextOverflow
                                                                  .ellipsis,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 4),
                                                      // Precio
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .attach_money,
                                                            size: 16,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .success,
                                                          ),
                                                          Text(
                                                            NumberFormat.currency(
                                                              locale: 'es_MX',
                                                              symbol: '\$',
                                                              decimalDigits: 0,
                                                            ).format(
                                                                listViewPropertiesRecord
                                                                    .price),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Poiret One',
                                                                  fontSize: 15.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: FlutterFlowTheme
                                                                          .of(
                                                                              context)
                                                                      .success,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 8),
                                                      // Badges (Tipo y Estado)
                                                      Row(
                                                        children: [
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                              horizontal: 8,
                                                              vertical: 4,
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: listViewPropertiesRecord
                                                                          .tipoPropiedad ==
                                                                      'Renta'
                                                                  ? FlutterFlowTheme.of(
                                                                          context)
                                                                      .info
                                                                      .withOpacity(
                                                                          0.2)
                                                                  : FlutterFlowTheme.of(
                                                                          context)
                                                                      .success
                                                                      .withOpacity(
                                                                          0.2),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12),
                                                            ),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Icon(
                                                                  listViewPropertiesRecord
                                                                              .tipoPropiedad ==
                                                                          'Renta'
                                                                      ? Icons
                                                                          .key
                                                                      : Icons
                                                                          .sell,
                                                                  size: 12,
                                                                  color: listViewPropertiesRecord
                                                                              .tipoPropiedad ==
                                                                          'Renta'
                                                                      ? FlutterFlowTheme.of(
                                                                              context)
                                                                          .info
                                                                      : FlutterFlowTheme.of(
                                                                              context)
                                                                          .success,
                                                                ),
                                                                const SizedBox(
                                                                    width: 4),
                                                                Text(
                                                                  listViewPropertiesRecord
                                                                      .tipoPropiedad,
                                                                  style: TextStyle(
                                                                    fontSize:
                                                                        11,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: listViewPropertiesRecord.tipoPropiedad ==
                                                                            'Renta'
                                                                        ? FlutterFlowTheme.of(context)
                                                                            .info
                                                                        : FlutterFlowTheme.of(context)
                                                                            .success,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          const SizedBox(width: 8),
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                              horizontal: 8,
                                                              vertical: 4,
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: listViewPropertiesRecord
                                                                          .status ==
                                                                      'Revisado'
                                                                  ? FlutterFlowTheme.of(
                                                                          context)
                                                                      .success
                                                                      .withOpacity(
                                                                          0.2)
                                                                  : FlutterFlowTheme.of(
                                                                          context)
                                                                      .warning
                                                                      .withOpacity(
                                                                          0.2),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12),
                                                            ),
                                                            child: Text(
                                                              listViewPropertiesRecord
                                                                  .status,
                                                              style: TextStyle(
                                                                fontSize: 11,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: listViewPropertiesRecord
                                                                            .status ==
                                                                        'Revisado'
                                                                    ? FlutterFlowTheme.of(
                                                                            context)
                                                                        .success
                                                                    : FlutterFlowTheme.of(
                                                                            context)
                                                                        .warning,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                // Icono de flecha
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  size: 20.0,
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
