import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ToursRecord extends FirestoreRecord {
  ToursRecord._(
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
          ? parent.collection('tours')
          : FirebaseFirestore.instance.collectionGroup('tours');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('tours').doc(id);

  static Stream<ToursRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ToursRecord.fromSnapshot(s));

  static Future<ToursRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ToursRecord.fromSnapshot(s));

  static ToursRecord fromSnapshot(DocumentSnapshot snapshot) => ToursRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ToursRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ToursRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ToursRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ToursRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createToursRecordData({
  DateTime? aFechaCreacion,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'aFechaCreacion': aFechaCreacion,
    }.withoutNulls,
  );

  return firestoreData;
}

class ToursRecordDocumentEquality implements Equality<ToursRecord> {
  const ToursRecordDocumentEquality();

  @override
  bool equals(ToursRecord? e1, ToursRecord? e2) {
    return e1?.aFechaCreacion == e2?.aFechaCreacion;
  }

  @override
  int hash(ToursRecord? e) => const ListEquality().hash([e?.aFechaCreacion]);

  @override
  bool isValidKey(Object? o) => o is ToursRecord;
}
