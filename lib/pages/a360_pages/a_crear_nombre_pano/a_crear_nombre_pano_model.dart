import '/flutter_flow/flutter_flow_util.dart';
import 'a_crear_nombre_pano_widget.dart' show ACrearNombrePanoWidget;
import 'package:flutter/material.dart';

class ACrearNombrePanoModel extends FlutterFlowModel<ACrearNombrePanoWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
