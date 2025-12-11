import 'package:flutter/material.dart';
import '/backend/backend.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _cardNumber = prefs.getString('ff_cardNumber') ?? _cardNumber;
    });
    _safeInit(() {
      _cardHolderName = prefs.getString('ff_cardHolderName') ?? _cardHolderName;
    });
    _safeInit(() {
      _cardName = prefs.getString('ff_cardName') ?? _cardName;
    });
    _safeInit(() {
      _zipCode = prefs.getString('ff_zipCode') ?? _zipCode;
    });
    _safeInit(() {
      _globalVar1 = prefs.getString('ff_globalVar1') ?? _globalVar1;
    });
    _safeInit(() {
      _globalVar2 = prefs.getString('ff_globalVar2') ?? _globalVar2;
    });
    _safeInit(() {
      _globalVar3 = prefs.getString('ff_globalVar3') ?? _globalVar3;
    });
    _safeInit(() {
      _globalVar4 = prefs.getString('ff_globalVar4') ?? _globalVar4;
    });
    _safeInit(() {
      _calleMaps = prefs.getString('ff_calleMaps') ?? _calleMaps;
    });
    _safeInit(() {
      _numeroMaps = prefs.getString('ff_numeroMaps') ?? _numeroMaps;
    });
    _safeInit(() {
      _barrioMaps = prefs.getString('ff_barrioMaps') ?? _barrioMaps;
    });
    _safeInit(() {
      _ciudadMaps = prefs.getString('ff_ciudadMaps') ?? _ciudadMaps;
    });
    _safeInit(() {
      _estadoMaps = prefs.getString('ff_estadoMaps') ?? _estadoMaps;
    });
    _safeInit(() {
      _cpostalMaps = prefs.getString('ff_cpostalMaps') ?? _cpostalMaps;
    });
    _safeInit(() {
      if (prefs.containsKey('ff_coordsMaps')) {
        try {
          final serializedData = prefs.getString('ff_coordsMaps') ?? '{}';
          _coordsMaps =
              CoordenadasStruct.fromSerializableMap(jsonDecode(serializedData));
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
    });
    _safeInit(() {
      _coordenadasMaps =
          latLngFromString(prefs.getString('ff_coordenadasMaps')) ??
              _coordenadasMaps;
    });
    _safeInit(() {
      _tipoPropiedad = prefs.getString('ff_tipoPropiedad') ?? _tipoPropiedad;
    });
    _safeInit(() {
      _continuarVisible =
          prefs.getBool('ff_continuarVisible') ?? _continuarVisible;
    });
    _safeInit(() {
      _stateNivelid = prefs.getString('ff_stateNivelid') ?? _stateNivelid;
    });
    _safeInit(() {
      _stateidVirtualTour =
          prefs.getString('ff_stateidVirtualTour') ?? _stateidVirtualTour;
    });
    _safeInit(() {
      _fInicioContrato = prefs.containsKey('ff_fInicioContrato')
          ? DateTime.fromMillisecondsSinceEpoch(
              prefs.getInt('ff_fInicioContrato')!)
          : _fInicioContrato;
    });
    _safeInit(() {
      _ubicacionMapaPrinc =
          latLngFromString(prefs.getString('ff_ubicacionMapaPrinc')) ??
              _ubicacionMapaPrinc;
    });
    _safeInit(() {
      _radioCircle = prefs.getDouble('ff_radioCircle') ?? _radioCircle;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _cardNumber = '';
  String get cardNumber => _cardNumber;
  set cardNumber(String value) {
    _cardNumber = value;
    prefs.setString('ff_cardNumber', value);
  }

  String _cardHolderName = '';
  String get cardHolderName => _cardHolderName;
  set cardHolderName(String value) {
    _cardHolderName = value;
    prefs.setString('ff_cardHolderName', value);
  }

  String _cardName = '';
  String get cardName => _cardName;
  set cardName(String value) {
    _cardName = value;
    prefs.setString('ff_cardName', value);
  }

  String _zipCode = '';
  String get zipCode => _zipCode;
  set zipCode(String value) {
    _zipCode = value;
    prefs.setString('ff_zipCode', value);
  }

  String _globalVar1 = '';
  String get globalVar1 => _globalVar1;
  set globalVar1(String value) {
    _globalVar1 = value;
    prefs.setString('ff_globalVar1', value);
  }

  String _globalVar2 = '';
  String get globalVar2 => _globalVar2;
  set globalVar2(String value) {
    _globalVar2 = value;
    prefs.setString('ff_globalVar2', value);
  }

  String _globalVar3 = '';
  String get globalVar3 => _globalVar3;
  set globalVar3(String value) {
    _globalVar3 = value;
    prefs.setString('ff_globalVar3', value);
  }

  String _globalVar4 = '';
  String get globalVar4 => _globalVar4;
  set globalVar4(String value) {
    _globalVar4 = value;
    prefs.setString('ff_globalVar4', value);
  }

  String _calleMaps = '';
  String get calleMaps => _calleMaps;
  set calleMaps(String value) {
    _calleMaps = value;
    prefs.setString('ff_calleMaps', value);
  }

  String _numeroMaps = '';
  String get numeroMaps => _numeroMaps;
  set numeroMaps(String value) {
    _numeroMaps = value;
    prefs.setString('ff_numeroMaps', value);
  }

  String _barrioMaps = '';
  String get barrioMaps => _barrioMaps;
  set barrioMaps(String value) {
    _barrioMaps = value;
    prefs.setString('ff_barrioMaps', value);
  }

  String _ciudadMaps = '';
  String get ciudadMaps => _ciudadMaps;
  set ciudadMaps(String value) {
    _ciudadMaps = value;
    prefs.setString('ff_ciudadMaps', value);
  }

  String _estadoMaps = '';
  String get estadoMaps => _estadoMaps;
  set estadoMaps(String value) {
    _estadoMaps = value;
    prefs.setString('ff_estadoMaps', value);
  }

  String _cpostalMaps = '';
  String get cpostalMaps => _cpostalMaps;
  set cpostalMaps(String value) {
    _cpostalMaps = value;
    prefs.setString('ff_cpostalMaps', value);
  }

  CoordenadasStruct _coordsMaps = CoordenadasStruct();
  CoordenadasStruct get coordsMaps => _coordsMaps;
  set coordsMaps(CoordenadasStruct value) {
    _coordsMaps = value;
    prefs.setString('ff_coordsMaps', value.serialize());
  }

  void updateCoordsMapsStruct(Function(CoordenadasStruct) updateFn) {
    updateFn(_coordsMaps);
    prefs.setString('ff_coordsMaps', _coordsMaps.serialize());
  }

  LatLng? _coordenadasMaps;
  LatLng? get coordenadasMaps => _coordenadasMaps;
  set coordenadasMaps(LatLng? value) {
    _coordenadasMaps = value;
    value != null
        ? prefs.setString('ff_coordenadasMaps', value.serialize())
        : prefs.remove('ff_coordenadasMaps');
  }

  String _tipoPropiedad = '';
  String get tipoPropiedad => _tipoPropiedad;
  set tipoPropiedad(String value) {
    _tipoPropiedad = value;
    prefs.setString('ff_tipoPropiedad', value);
  }

  bool _continuarVisible = false;
  bool get continuarVisible => _continuarVisible;
  set continuarVisible(bool value) {
    _continuarVisible = value;
    prefs.setBool('ff_continuarVisible', value);
  }

  String _stateNivelid = '';
  String get stateNivelid => _stateNivelid;
  set stateNivelid(String value) {
    _stateNivelid = value;
    prefs.setString('ff_stateNivelid', value);
  }

  String _stateidVirtualTour = '';
  String get stateidVirtualTour => _stateidVirtualTour;
  set stateidVirtualTour(String value) {
    _stateidVirtualTour = value;
    prefs.setString('ff_stateidVirtualTour', value);
  }

  DateTime? _fInicioContrato;
  DateTime? get fInicioContrato => _fInicioContrato;
  set fInicioContrato(DateTime? value) {
    _fInicioContrato = value;
    value != null
        ? prefs.setInt('ff_fInicioContrato', value.millisecondsSinceEpoch)
        : prefs.remove('ff_fInicioContrato');
  }

  LatLng? _ubicacionMapaPrinc;
  LatLng? get ubicacionMapaPrinc => _ubicacionMapaPrinc;
  set ubicacionMapaPrinc(LatLng? value) {
    _ubicacionMapaPrinc = value;
    value != null
        ? prefs.setString('ff_ubicacionMapaPrinc', value.serialize())
        : prefs.remove('ff_ubicacionMapaPrinc');
  }

  double _radioCircle = 1.0;
  double get radioCircle => _radioCircle;
  set radioCircle(double value) {
    _radioCircle = value;
    prefs.setDouble('ff_radioCircle', value);
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
