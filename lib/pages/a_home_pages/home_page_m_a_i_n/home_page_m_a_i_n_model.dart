import '/flutter_flow/flutter_flow_util.dart';
import 'home_page_m_a_i_n_widget.dart' show HomePageMAINWidget;
import 'package:flutter/material.dart';

class HomePageMAINModel extends FlutterFlowModel<HomePageMAINWidget> {
  // Filter state fields
  double filterMinPrice = 0;
  double filterMaxPrice = 5000000;
  int? filterRooms;
  String? filterType;
  double filterRadiusKm = 50.0;
  bool applyDistanceFilter = true; // Aplicar filtro de distancia desde el inicio

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
