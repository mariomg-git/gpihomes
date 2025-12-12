import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'filter_modal_model.dart';
export 'filter_modal_model.dart';

class FilterModalWidget extends StatefulWidget {
  const FilterModalWidget({super.key});

  @override
  State<FilterModalWidget> createState() => _FilterModalWidgetState();
}

class _FilterModalWidgetState extends State<FilterModalWidget> {
  late FilterModalModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FilterModalModel());
    
    // Inicializar con valores guardados de FFAppState
    _model.minPrice = FFAppState().filterMinPrice;
    _model.maxPrice = FFAppState().filterMaxPrice;
    _model.selectedRooms = FFAppState().filterRooms;
    _model.selectedType = FFAppState().filterType;
    _model.radiusKm = FFAppState().filterRadiusKm;

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 40.0,
                height: 4.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).alternate,
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            // Título
            Text(
              'Filtros',
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    fontFamily: 'Playfair Display',
                    color: FlutterFlowTheme.of(context).primaryText,
                    fontSize: 24.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 24.0),
            // Rango de precio
            Text(
              'Rango de Precio',
              style: FlutterFlowTheme.of(context).titleMedium.override(
                    fontFamily: 'Inter',
                    fontSize: 16.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 12.0),
            RangeSlider(
              values: RangeValues(
                _model.minPrice,
                _model.maxPrice,
              ),
              min: 0,
              max: 5000000,
              divisions: 100,
              activeColor: FlutterFlowTheme.of(context).primary,
              inactiveColor: FlutterFlowTheme.of(context).alternate,
              labels: RangeLabels(
                formatNumber(
                  _model.minPrice,
                  formatType: FormatType.decimal,
                  decimalType: DecimalType.automatic,
                  currency: '\$',
                ),
                formatNumber(
                  _model.maxPrice,
                  formatType: FormatType.decimal,
                  decimalType: DecimalType.automatic,
                  currency: '\$',
                ),
              ),
              onChanged: (values) {
                safeSetState(() {
                  _model.minPrice = values.start;
                  _model.maxPrice = values.end;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatNumber(
                    _model.minPrice,
                    formatType: FormatType.decimal,
                    decimalType: DecimalType.automatic,
                    currency: '\$',
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Inter',
                        color: FlutterFlowTheme.of(context).secondaryText,
                        letterSpacing: 0.0,
                      ),
                ),
                Text(
                  formatNumber(
                    _model.maxPrice,
                    formatType: FormatType.decimal,
                    decimalType: DecimalType.automatic,
                    currency: '\$',
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Inter',
                        color: FlutterFlowTheme.of(context).secondaryText,
                        letterSpacing: 0.0,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 24.0),
            // Número de habitaciones
            Text(
              'Habitaciones',
              style: FlutterFlowTheme.of(context).titleMedium.override(
                    fontFamily: 'Inter',
                    fontSize: 16.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 12.0),
            Row(
              children: [1, 2, 3, 4, 5].map((rooms) {
                final isSelected = _model.selectedRooms == rooms;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: InkWell(
                    onTap: () {
                      safeSetState(() {
                        _model.selectedRooms = isSelected ? null : rooms;
                      });
                    },
                    child: Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? FlutterFlowTheme.of(context).primary
                            : FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: isSelected
                              ? FlutterFlowTheme.of(context).primary
                              : FlutterFlowTheme.of(context).alternate,
                          width: 2.0,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          rooms.toString(),
                          style: FlutterFlowTheme.of(context)
                              .titleMedium
                              .override(
                                fontFamily: 'Inter',
                                color: isSelected
                                    ? Colors.white
                                    : FlutterFlowTheme.of(context).primaryText,
                                fontSize: 16.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24.0),
            // Tipo de propiedad
            Text(
              'Tipo de Propiedad',
              style: FlutterFlowTheme.of(context).titleMedium.override(
                    fontFamily: 'Inter',
                    fontSize: 16.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 12.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: ['Casa', 'Departamento', 'Terreno', 'Local'].map((type) {
                final isSelected = _model.selectedType == type;
                return InkWell(
                  onTap: () {
                    safeSetState(() {
                      _model.selectedType = isSelected ? null : type;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 10.0,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? FlutterFlowTheme.of(context).primary
                          : FlutterFlowTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        color: isSelected
                            ? FlutterFlowTheme.of(context).primary
                            : FlutterFlowTheme.of(context).alternate,
                        width: 2.0,
                      ),
                    ),
                    child: Text(
                      type,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Inter',
                            color: isSelected
                                ? Colors.white
                                : FlutterFlowTheme.of(context).primaryText,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24.0),
            // Radio de distancia
            Text(
              'Radio de Distancia',
              style: FlutterFlowTheme.of(context).titleMedium.override(
                    fontFamily: 'Inter',
                    fontSize: 16.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 12.0),
            Slider(
              value: _model.radiusKm,
              min: 1,
              max: 100,
              divisions: 99,
              activeColor: FlutterFlowTheme.of(context).primary,
              inactiveColor: FlutterFlowTheme.of(context).alternate,
              label: '${_model.radiusKm.toInt()} km',
              onChanged: (value) {
                safeSetState(() {
                  _model.radiusKm = value;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '1 km',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Inter',
                        color: FlutterFlowTheme.of(context).secondaryText,
                        letterSpacing: 0.0,
                      ),
                ),
                Text(
                  '${_model.radiusKm.toInt()} km',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Inter',
                        color: FlutterFlowTheme.of(context).primary,
                        fontSize: 16.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Text(
                  '100 km',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Inter',
                        color: FlutterFlowTheme.of(context).secondaryText,
                        letterSpacing: 0.0,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 32.0),
            // Botones de acción
            Row(
              children: [
                Expanded(
                  child: FFButtonWidget(
                    onPressed: () {
                      // Limpiar filtros
                      safeSetState(() {
                        _model.minPrice = 0;
                        _model.maxPrice = 5000000;
                        _model.selectedRooms = null;
                        _model.selectedType = null;
                        _model.radiusKm = 50.0;
                      });
                    },
                    text: 'Limpiar',
                    options: FFButtonOptions(
                      height: 50.0,
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 0.0),
                      iconPadding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      textStyle:
                          FlutterFlowTheme.of(context).titleMedium.override(
                                fontFamily: 'Inter',
                                color: FlutterFlowTheme.of(context).primaryText,
                                fontSize: 16.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                              ),
                      elevation: 0.0,
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).alternate,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  flex: 2,
                  child: FFButtonWidget(
                    onPressed: () {
                      // Guardar en FFAppState para recordar valores
                      FFAppState().filterMinPrice = _model.minPrice;
                      FFAppState().filterMaxPrice = _model.maxPrice;
                      FFAppState().filterRooms = _model.selectedRooms;
                      FFAppState().filterType = _model.selectedType;
                      FFAppState().filterRadiusKm = _model.radiusKm;
                      
                      // Aplicar filtros y cerrar
                      Navigator.pop(context, {
                        'minPrice': _model.minPrice,
                        'maxPrice': _model.maxPrice,
                        'rooms': _model.selectedRooms,
                        'type': _model.selectedType,
                        'radiusKm': _model.radiusKm,
                      });
                    },
                    text: 'Aplicar Filtros',
                    options: FFButtonOptions(
                      height: 50.0,
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 0.0),
                      iconPadding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle:
                          FlutterFlowTheme.of(context).titleMedium.override(
                                fontFamily: 'Inter',
                                color: Colors.white,
                                fontSize: 16.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                              ),
                      elevation: 3.0,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
          ],
        ),
      ),
    );
  }
}
