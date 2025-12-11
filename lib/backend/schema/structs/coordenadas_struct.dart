// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class CoordenadasStruct extends FFFirebaseStruct {
  CoordenadasStruct({
    double? latitud,
    double? longitud,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _latitud = latitud,
        _longitud = longitud,
        super(firestoreUtilData);

  // "latitud" field.
  double? _latitud;
  double get latitud => _latitud ?? 0.0;
  set latitud(double? val) => _latitud = val;

  void incrementLatitud(double amount) => latitud = latitud + amount;

  bool hasLatitud() => _latitud != null;

  // "longitud" field.
  double? _longitud;
  double get longitud => _longitud ?? 0.0;
  set longitud(double? val) => _longitud = val;

  void incrementLongitud(double amount) => longitud = longitud + amount;

  bool hasLongitud() => _longitud != null;

  static CoordenadasStruct fromMap(Map<String, dynamic> data) =>
      CoordenadasStruct(
        latitud: castToType<double>(data['latitud']),
        longitud: castToType<double>(data['longitud']),
      );

  static CoordenadasStruct? maybeFromMap(dynamic data) => data is Map
      ? CoordenadasStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'latitud': _latitud,
        'longitud': _longitud,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'latitud': serializeParam(
          _latitud,
          ParamType.double,
        ),
        'longitud': serializeParam(
          _longitud,
          ParamType.double,
        ),
      }.withoutNulls;

  static CoordenadasStruct fromSerializableMap(Map<String, dynamic> data) =>
      CoordenadasStruct(
        latitud: deserializeParam(
          data['latitud'],
          ParamType.double,
          false,
        ),
        longitud: deserializeParam(
          data['longitud'],
          ParamType.double,
          false,
        ),
      );

  @override
  String toString() => 'CoordenadasStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is CoordenadasStruct &&
        latitud == other.latitud &&
        longitud == other.longitud;
  }

  @override
  int get hashCode => const ListEquality().hash([latitud, longitud]);
}

CoordenadasStruct createCoordenadasStruct({
  double? latitud,
  double? longitud,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    CoordenadasStruct(
      latitud: latitud,
      longitud: longitud,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

CoordenadasStruct? updateCoordenadasStruct(
  CoordenadasStruct? coordenadas, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    coordenadas
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addCoordenadasStructData(
  Map<String, dynamic> firestoreData,
  CoordenadasStruct? coordenadas,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (coordenadas == null) {
    return;
  }
  if (coordenadas.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && coordenadas.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final coordenadasData =
      getCoordenadasFirestoreData(coordenadas, forFieldValue);
  final nestedData =
      coordenadasData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = coordenadas.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getCoordenadasFirestoreData(
  CoordenadasStruct? coordenadas, [
  bool forFieldValue = false,
]) {
  if (coordenadas == null) {
    return {};
  }
  final firestoreData = mapToFirestore(coordenadas.toMap());

  // Add any Firestore field values
  coordenadas.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getCoordenadasListFirestoreData(
  List<CoordenadasStruct>? coordenadass,
) =>
    coordenadass?.map((e) => getCoordenadasFirestoreData(e, true)).toList() ??
    [];
