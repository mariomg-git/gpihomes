import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class NivelesRecord extends FirestoreRecord {
  NivelesRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "aFechaCreacion" field.
  DateTime? _aFechaCreacion;
  DateTime? get aFechaCreacion => _aFechaCreacion;
  bool hasAFechaCreacion() => _aFechaCreacion != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _aFechaCreacion = snapshotData['aFechaCreacion'] as DateTime?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('niveles')
          : FirebaseFirestore.instance.collectionGroup('niveles');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('niveles').doc(id);

  static Stream<NivelesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => NivelesRecord.fromSnapshot(s));

  static Future<NivelesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => NivelesRecord.fromSnapshot(s));

  static NivelesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      NivelesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static NivelesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      NivelesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'NivelesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is NivelesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createNivelesRecordData({
  DateTime? aFechaCreacion,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'aFechaCreacion': aFechaCreacion,
    }.withoutNulls,
  );

  return firestoreData;
}

class NivelesRecordDocumentEquality implements Equality<NivelesRecord> {
  const NivelesRecordDocumentEquality();

  @override
  bool equals(NivelesRecord? e1, NivelesRecord? e2) {
    return e1?.aFechaCreacion == e2?.aFechaCreacion;
  }

  @override
  int hash(NivelesRecord? e) => const ListEquality().hash([e?.aFechaCreacion]);

  @override
  bool isValidKey(Object? o) => o is NivelesRecord;
}
