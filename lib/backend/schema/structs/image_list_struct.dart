// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class ImageListStruct extends FFFirebaseStruct {
  ImageListStruct({
    String? description,
    String? imageUrl,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _description = description,
        _imageUrl = imageUrl,
        super(firestoreUtilData);

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;

  bool hasDescription() => _description != null;

  // "imageUrl" field.
  String? _imageUrl;
  String get imageUrl => _imageUrl ?? '';
  set imageUrl(String? val) => _imageUrl = val;

  bool hasImageUrl() => _imageUrl != null;

  static ImageListStruct fromMap(Map<String, dynamic> data) => ImageListStruct(
        description: data['description'] as String?,
        imageUrl: data['imageUrl'] as String?,
      );

  static ImageListStruct? maybeFromMap(dynamic data) => data is Map
      ? ImageListStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'description': _description,
        'imageUrl': _imageUrl,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'description': serializeParam(
          _description,
          ParamType.String,
        ),
        'imageUrl': serializeParam(
          _imageUrl,
          ParamType.String,
        ),
      }.withoutNulls;

  static ImageListStruct fromSerializableMap(Map<String, dynamic> data) =>
      ImageListStruct(
        description: deserializeParam(
          data['description'],
          ParamType.String,
          false,
        ),
        imageUrl: deserializeParam(
          data['imageUrl'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ImageListStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ImageListStruct &&
        description == other.description &&
        imageUrl == other.imageUrl;
  }

  @override
  int get hashCode => const ListEquality().hash([description, imageUrl]);
}

ImageListStruct createImageListStruct({
  String? description,
  String? imageUrl,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ImageListStruct(
      description: description,
      imageUrl: imageUrl,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ImageListStruct? updateImageListStruct(
  ImageListStruct? imageList, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    imageList
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addImageListStructData(
  Map<String, dynamic> firestoreData,
  ImageListStruct? imageList,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (imageList == null) {
    return;
  }
  if (imageList.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && imageList.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final imageListData = getImageListFirestoreData(imageList, forFieldValue);
  final nestedData = imageListData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = imageList.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getImageListFirestoreData(
  ImageListStruct? imageList, [
  bool forFieldValue = false,
]) {
  if (imageList == null) {
    return {};
  }
  final firestoreData = mapToFirestore(imageList.toMap());

  // Add any Firestore field values
  imageList.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getImageListListFirestoreData(
  List<ImageListStruct>? imageLists,
) =>
    imageLists?.map((e) => getImageListFirestoreData(e, true)).toList() ?? [];
