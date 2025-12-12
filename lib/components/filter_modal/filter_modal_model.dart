import '/flutter_flow/flutter_flow_util.dart';
import 'filter_modal_widget.dart' show FilterModalWidget;
import 'package:flutter/material.dart';

class FilterModalModel extends FlutterFlowModel<FilterModalWidget> {
  // State fields
  double minPrice = 0;
  double maxPrice = 5000000;
  int? selectedRooms;
  String? selectedType;
  double radiusKm = 50.0; // Default 50 km

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
