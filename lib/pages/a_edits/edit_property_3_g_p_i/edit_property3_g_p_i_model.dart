import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'edit_property3_g_p_i_widget.dart' show EditProperty3GPIWidget;
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class EditProperty3GPIModel extends FlutterFlowModel<EditProperty3GPIWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for pricePropiedad widget.
  FocusNode? pricePropiedadFocusNode;
  TextEditingController? pricePropiedadTextController;
  String? Function(BuildContext, String?)?
      pricePropiedadTextControllerValidator;
  String? _pricePropiedadTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'fsrg5efe' /* Field is required */,
      );
    }

    if (val.isEmpty) {
      return 'Requires at least 1 characters.';
    }

    return null;
  }

  // State field(s) for telPropiedad widget.
  FocusNode? telPropiedadFocusNode;
  TextEditingController? telPropiedadTextController;
  final telPropiedadMask = MaskTextInputFormatter(mask: '(###) ###-####');
  String? Function(BuildContext, String?)? telPropiedadTextControllerValidator;
  String? _telPropiedadTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'cjn2ds13' /* Field is required */,
      );
    }

    if (val.length < 10) {
      return 'Requires at least 10 characters.';
    }
    if (val.length > 10) {
      return 'Maximum 10 characters allowed, currently ${val.length}.';
    }

    return null;
  }

  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // State field(s) for DropDownTipo widget.
  String? dropDownTipoValue;
  FormFieldController<String>? dropDownTipoValueController;
  // State field(s) for notes widget.
  FocusNode? notesFocusNode;
  TextEditingController? notesTextController;
  String? Function(BuildContext, String?)? notesTextControllerValidator;

  @override
  void initState(BuildContext context) {
    pricePropiedadTextControllerValidator =
        _pricePropiedadTextControllerValidator;
    telPropiedadTextControllerValidator = _telPropiedadTextControllerValidator;
  }

  @override
  void dispose() {
    pricePropiedadFocusNode?.dispose();
    pricePropiedadTextController?.dispose();

    telPropiedadFocusNode?.dispose();
    telPropiedadTextController?.dispose();

    notesFocusNode?.dispose();
    notesTextController?.dispose();
  }
}
