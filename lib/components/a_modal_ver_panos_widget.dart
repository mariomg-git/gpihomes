import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'a_modal_ver_panos_model.dart';
export 'a_modal_ver_panos_model.dart';

class AModalVerPanosWidget extends StatefulWidget {
  const AModalVerPanosWidget({
    super.key,
    this.idVirtualTour,
  });

  final String? idVirtualTour;

  @override
  State<AModalVerPanosWidget> createState() => _AModalVerPanosWidgetState();
}

class _AModalVerPanosWidgetState extends State<AModalVerPanosWidget> {
  late AModalVerPanosModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AModalVerPanosModel());

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
      width: MediaQuery.sizeOf(context).width * 1.0,
      height: MediaQuery.sizeOf(context).height * 1.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Stack(
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 1.0,
            height: MediaQuery.sizeOf(context).height * 1.0,
            child: custom_widgets.APreview360Propiedad(
              width: MediaQuery.sizeOf(context).width * 1.0,
              height: MediaQuery.sizeOf(context).height * 1.0,
              paramReference: widget.idVirtualTour,
            ),
          ),
        ],
      ),
    );
  }
}
