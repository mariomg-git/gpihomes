import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class VirtualToursRecord extends FirestoreRecord {
  VirtualToursRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "aFechaCreacion" field.
  DateTime? _aFechaCreacion;
  DateTime? get aFechaCreacion => _aFechaCreacion;
  bool hasAFechaCreacion() => _aFechaCreacion != null;

  // "nombre" field.
  String? _nombre;
  String get nombre => _nombre ?? '';
  bool hasNombre() => _nombre != null;

  // "idPropiedad" field.
  String? _idPropiedad;
  String get idPropiedad => _idPropiedad ?? '';
  bool hasIdPropiedad() => _idPropiedad != null;

  void _initializeFields() {
    _aFechaCreacion = snapshotData['aFechaCreacion'] as DateTime?;
    _nombre = snapshotData['nombre'] as String?;
    _idPropiedad = snapshotData['idPropiedad'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('virtualTours');

  static Stream<VirtualToursRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => VirtualToursRecord.fromSnapshot(s));

  static Future<VirtualToursRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => VirtualToursRecord.fromSnapshot(s));

  static VirtualToursRecord fromSnapshot(DocumentSnapshot snapshot) =>
      VirtualToursRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static VirtualToursRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      VirtualToursRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'VirtualToursRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is VirtualToursRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createVirtualToursRecordData({
  DateTime? aFechaCreacion,
  String? nombre,
  String? idPropiedad,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'aFechaCreacion': aFechaCreacion,
      'nombre': nombre,
      'idPropiedad': idPropiedad,
    }.withoutNulls,
  );

  return firestoreData;
}

class VirtualToursRecordDocumentEquality
    implements Equality<VirtualToursRecord> {
  const VirtualToursRecordDocumentEquality();

  @override
  bool equals(VirtualToursRecord? e1, VirtualToursRecord? e2) {
    return e1?.aFechaCreacion == e2?.aFechaCreacion &&
        e1?.nombre == e2?.nombre &&
        e1?.idPropiedad == e2?.idPropiedad;
  }

  @override
  int hash(VirtualToursRecord? e) =>
      const ListEquality().hash([e?.aFechaCreacion, e?.nombre, e?.idPropiedad]);

  @override
  bool isValidKey(Object? o) => o is VirtualToursRecord;
}
