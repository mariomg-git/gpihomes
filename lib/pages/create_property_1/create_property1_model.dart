import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'create_property1_widget.dart' show CreateProperty1Widget;
import 'package:flutter/material.dart';

class CreateProperty1Model extends FlutterFlowModel<CreateProperty1Widget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  // State field(s) for propertyName widget.
  FocusNode? propertyNameFocusNode;
  TextEditingController? propertyNameTextController;
  String? Function(BuildContext, String?)? propertyNameTextControllerValidator;
  String? _propertyNameTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        '1djl64fp' /* Field is required */,
      );
    }

    if (val.length < 10) {
      return 'Requires at least 10 characters.';
    }

    return null;
  }

  // State field(s) for propertStreet widget.
  FocusNode? propertStreetFocusNode;
  TextEditingController? propertStreetTextController;
  String? Function(BuildContext, String?)? propertStreetTextControllerValidator;
  String? _propertStreetTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        '10aii9x7' /* Field is required */,
      );
    }

    if (val.isEmpty) {
      return 'Requires at least 1 characters.';
    }

    return null;
  }

  // State field(s) for propertyNumber widget.
  FocusNode? propertyNumberFocusNode;
  TextEditingController? propertyNumberTextController;
  String? Function(BuildContext, String?)?
      propertyNumberTextControllerValidator;
  String? _propertyNumberTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'oe3ye8yv' /* Field is required */,
      );
    }

    if (val.isEmpty) {
      return 'Requires at least 1 characters.';
    }

    return null;
  }

  // State field(s) for propertyNeighborhood widget.
  FocusNode? propertyNeighborhoodFocusNode;
  TextEditingController? propertyNeighborhoodTextController;
  String? Function(BuildContext, String?)?
      propertyNeighborhoodTextControllerValidator;
  String? _propertyNeighborhoodTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'qk512n4k' /* Field is required */,
      );
    }

    if (val.isEmpty) {
      return 'Requires at least 1 characters.';
    }

    return null;
  }

  // State field(s) for propertyCity widget.
  FocusNode? propertyCityFocusNode;
  TextEditingController? propertyCityTextController;
  String? Function(BuildContext, String?)? propertyCityTextControllerValidator;
  String? _propertyCityTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'obam3jjc' /* Field is required */,
      );
    }

    if (val.isEmpty) {
      return 'Requires at least 1 characters.';
    }

    return null;
  }

  // State field(s) for propertyState widget.
  FocusNode? propertyStateFocusNode;
  TextEditingController? propertyStateTextController;
  String? Function(BuildContext, String?)? propertyStateTextControllerValidator;
  String? _propertyStateTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'qs6nzyqy' /* Field is required */,
      );
    }

    if (val.isEmpty) {
      return 'Requires at least 1 characters.';
    }

    return null;
  }

  // State field(s) for propertyZcode widget.
  FocusNode? propertyZcodeFocusNode;
  TextEditingController? propertyZcodeTextController;
  String? Function(BuildContext, String?)? propertyZcodeTextControllerValidator;
  String? _propertyZcodeTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'l205gmu2' /* Field is required */,
      );
    }

    if (val.isEmpty) {
      return 'Requires at least 1 characters.';
    }

    return null;
  }

  // State field(s) for propertyDescription widget.
  FocusNode? propertyDescriptionFocusNode;
  TextEditingController? propertyDescriptionTextController;
  String? Function(BuildContext, String?)?
      propertyDescriptionTextControllerValidator;
  String? _propertyDescriptionTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'z33zu48g' /* Field is required */,
      );
    }

    if (val.length < 10) {
      return 'Requires at least 10 characters.';
    }

    return null;
  }

  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  PropertiesRecord? newProperty;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  AmenititiesRecord? amenitiesRecord;

  @override
  void initState(BuildContext context) {
    propertyNameTextControllerValidator = _propertyNameTextControllerValidator;
    propertStreetTextControllerValidator =
        _propertStreetTextControllerValidator;
    propertyNumberTextControllerValidator =
        _propertyNumberTextControllerValidator;
    propertyNeighborhoodTextControllerValidator =
        _propertyNeighborhoodTextControllerValidator;
    propertyCityTextControllerValidator = _propertyCityTextControllerValidator;
    propertyStateTextControllerValidator =
        _propertyStateTextControllerValidator;
    propertyZcodeTextControllerValidator =
        _propertyZcodeTextControllerValidator;
    propertyDescriptionTextControllerValidator =
        _propertyDescriptionTextControllerValidator;
  }

  @override
  void dispose() {
    propertyNameFocusNode?.dispose();
    propertyNameTextController?.dispose();

    propertStreetFocusNode?.dispose();
    propertStreetTextController?.dispose();

    propertyNumberFocusNode?.dispose();
    propertyNumberTextController?.dispose();

    propertyNeighborhoodFocusNode?.dispose();
    propertyNeighborhoodTextController?.dispose();

    propertyCityFocusNode?.dispose();
    propertyCityTextController?.dispose();

    propertyStateFocusNode?.dispose();
    propertyStateTextController?.dispose();

    propertyZcodeFocusNode?.dispose();
    propertyZcodeTextController?.dispose();

    propertyDescriptionFocusNode?.dispose();
    propertyDescriptionTextController?.dispose();
  }
}
