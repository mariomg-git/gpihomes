// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class FavoritosDataTypeStruct extends FFFirebaseStruct {
  FavoritosDataTypeStruct({
    DocumentReference? idPropiedadType,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _idPropiedadType = idPropiedadType,
        super(firestoreUtilData);

  // "idPropiedadType" field.
  DocumentReference? _idPropiedadType;
  DocumentReference? get idPropiedadType => _idPropiedadType;
  set idPropiedadType(DocumentReference? val) => _idPropiedadType = val;

  bool hasIdPropiedadType() => _idPropiedadType != null;

  static FavoritosDataTypeStruct fromMap(Map<String, dynamic> data) =>
      FavoritosDataTypeStruct(
        idPropiedadType: data['idPropiedadType'] as DocumentReference?,
      );

  static FavoritosDataTypeStruct? maybeFromMap(dynamic data) => data is Map
      ? FavoritosDataTypeStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'idPropiedadType': _idPropiedadType,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'idPropiedadType': serializeParam(
          _idPropiedadType,
          ParamType.DocumentReference,
        ),
      }.withoutNulls;

  static FavoritosDataTypeStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      FavoritosDataTypeStruct(
        idPropiedadType: deserializeParam(
          data['idPropiedadType'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['properties'],
        ),
      );

  @override
  String toString() => 'FavoritosDataTypeStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is FavoritosDataTypeStruct &&
        idPropiedadType == other.idPropiedadType;
  }

  @override
  int get hashCode => const ListEquality().hash([idPropiedadType]);
}

FavoritosDataTypeStruct createFavoritosDataTypeStruct({
  DocumentReference? idPropiedadType,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    FavoritosDataTypeStruct(
      idPropiedadType: idPropiedadType,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

FavoritosDataTypeStruct? updateFavoritosDataTypeStruct(
  FavoritosDataTypeStruct? favoritosDataType, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    favoritosDataType
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addFavoritosDataTypeStructData(
  Map<String, dynamic> firestoreData,
  FavoritosDataTypeStruct? favoritosDataType,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (favoritosDataType == null) {
    return;
  }
  if (favoritosDataType.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && favoritosDataType.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final favoritosDataTypeData =
      getFavoritosDataTypeFirestoreData(favoritosDataType, forFieldValue);
  final nestedData =
      favoritosDataTypeData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = favoritosDataType.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getFavoritosDataTypeFirestoreData(
  FavoritosDataTypeStruct? favoritosDataType, [
  bool forFieldValue = false,
]) {
  if (favoritosDataType == null) {
    return {};
  }
  final firestoreData = mapToFirestore(favoritosDataType.toMap());

  // Add any Firestore field values
  favoritosDataType.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getFavoritosDataTypeListFirestoreData(
  List<FavoritosDataTypeStruct>? favoritosDataTypes,
) =>
    favoritosDataTypes
        ?.map((e) => getFavoritosDataTypeFirestoreData(e, true))
        .toList() ??
    [];
