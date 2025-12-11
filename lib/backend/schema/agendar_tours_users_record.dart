import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AgendarToursUsersRecord extends FirestoreRecord {
  AgendarToursUsersRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "idCurrentUser" field.
  String? _idCurrentUser;
  String get idCurrentUser => _idCurrentUser ?? '';
  bool hasIdCurrentUser() => _idCurrentUser != null;

  // "idPropiedad" field.
  String? _idPropiedad;
  String get idPropiedad => _idPropiedad ?? '';
  bool hasIdPropiedad() => _idPropiedad != null;

  // "startDateTime" field.
  DateTime? _startDateTime;
  DateTime? get startDateTime => _startDateTime;
  bool hasStartDateTime() => _startDateTime != null;

  // "endDateTime" field.
  DateTime? _endDateTime;
  DateTime? get endDateTime => _endDateTime;
  bool hasEndDateTime() => _endDateTime != null;

  void _initializeFields() {
    _idCurrentUser = snapshotData['idCurrentUser'] as String?;
    _idPropiedad = snapshotData['idPropiedad'] as String?;
    _startDateTime = snapshotData['startDateTime'] as DateTime?;
    _endDateTime = snapshotData['endDateTime'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('agendarToursUsers');

  static Stream<AgendarToursUsersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AgendarToursUsersRecord.fromSnapshot(s));

  static Future<AgendarToursUsersRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => AgendarToursUsersRecord.fromSnapshot(s));

  static AgendarToursUsersRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AgendarToursUsersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AgendarToursUsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AgendarToursUsersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AgendarToursUsersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AgendarToursUsersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAgendarToursUsersRecordData({
  String? idCurrentUser,
  String? idPropiedad,
  DateTime? startDateTime,
  DateTime? endDateTime,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'idCurrentUser': idCurrentUser,
      'idPropiedad': idPropiedad,
      'startDateTime': startDateTime,
      'endDateTime': endDateTime,
    }.withoutNulls,
  );

  return firestoreData;
}

class AgendarToursUsersRecordDocumentEquality
    implements Equality<AgendarToursUsersRecord> {
  const AgendarToursUsersRecordDocumentEquality();

  @override
  bool equals(AgendarToursUsersRecord? e1, AgendarToursUsersRecord? e2) {
    return e1?.idCurrentUser == e2?.idCurrentUser &&
        e1?.idPropiedad == e2?.idPropiedad &&
        e1?.startDateTime == e2?.startDateTime &&
        e1?.endDateTime == e2?.endDateTime;
  }

  @override
  int hash(AgendarToursUsersRecord? e) => const ListEquality().hash(
      [e?.idCurrentUser, e?.idPropiedad, e?.startDateTime, e?.endDateTime]);

  @override
  bool isValidKey(Object? o) => o is AgendarToursUsersRecord;
}
