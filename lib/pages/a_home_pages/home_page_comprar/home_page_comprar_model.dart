import '/flutter_flow/flutter_flow_util.dart';
import 'home_page_comprar_widget.dart' show HomePageComprarWidget;
import 'package:flutter/material.dart';

class HomePageComprarModel extends FlutterFlowModel<HomePageComprarWidget> {
  // Filter state fields
  double filterMinPrice = 0;
  double filterMaxPrice = 5000000;
  int? filterRooms;
  String? filterType;
  double filterRadiusKm = 50.0;
  bool applyDistanceFilter = true; // Aplicar filtro de distancia igual que en Renta

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
