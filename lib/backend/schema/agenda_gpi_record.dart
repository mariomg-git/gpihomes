import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AgendaGpiRecord extends FirestoreRecord {
  AgendaGpiRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "idUser" field.
  String? _idUser;
  String get idUser => _idUser ?? '';
  bool hasIdUser() => _idUser != null;

  // "idPropiedad" field.
  String? _idPropiedad;
  String get idPropiedad => _idPropiedad ?? '';
  bool hasIdPropiedad() => _idPropiedad != null;

  // "selectedDay" field.
  DateTime? _selectedDay;
  DateTime? get selectedDay => _selectedDay;
  bool hasSelectedDay() => _selectedDay != null;

  // "startTime" field.
  DateTime? _startTime;
  DateTime? get startTime => _startTime;
  bool hasStartTime() => _startTime != null;

  // "endTime" field.
  DateTime? _endTime;
  DateTime? get endTime => _endTime;
  bool hasEndTime() => _endTime != null;

  // "daysOfWeek" field.
  List<String>? _daysOfWeek;
  List<String> get daysOfWeek => _daysOfWeek ?? const [];
  bool hasDaysOfWeek() => _daysOfWeek != null;

  void _initializeFields() {
    _idUser = snapshotData['idUser'] as String?;
    _idPropiedad = snapshotData['idPropiedad'] as String?;
    _selectedDay = snapshotData['selectedDay'] as DateTime?;
    _startTime = snapshotData['startTime'] as DateTime?;
    _endTime = snapshotData['endTime'] as DateTime?;
    _daysOfWeek = getDataList(snapshotData['daysOfWeek']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('agendaGpi');

  static Stream<AgendaGpiRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AgendaGpiRecord.fromSnapshot(s));

  static Future<AgendaGpiRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AgendaGpiRecord.fromSnapshot(s));

  static AgendaGpiRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AgendaGpiRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AgendaGpiRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AgendaGpiRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AgendaGpiRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AgendaGpiRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAgendaGpiRecordData({
  String? idUser,
  String? idPropiedad,
  DateTime? selectedDay,
  DateTime? startTime,
  DateTime? endTime,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'idUser': idUser,
      'idPropiedad': idPropiedad,
      'selectedDay': selectedDay,
      'startTime': startTime,
      'endTime': endTime,
    }.withoutNulls,
  );

  return firestoreData;
}

class AgendaGpiRecordDocumentEquality implements Equality<AgendaGpiRecord> {
  const AgendaGpiRecordDocumentEquality();

  @override
  bool equals(AgendaGpiRecord? e1, AgendaGpiRecord? e2) {
    const listEquality = ListEquality();
    return e1?.idUser == e2?.idUser &&
        e1?.idPropiedad == e2?.idPropiedad &&
        e1?.selectedDay == e2?.selectedDay &&
        e1?.startTime == e2?.startTime &&
        e1?.endTime == e2?.endTime &&
        listEquality.equals(e1?.daysOfWeek, e2?.daysOfWeek);
  }

  @override
  int hash(AgendaGpiRecord? e) => const ListEquality().hash([
        e?.idUser,
        e?.idPropiedad,
        e?.selectedDay,
        e?.startTime,
        e?.endTime,
        e?.daysOfWeek
      ]);

  @override
  bool isValidKey(Object? o) => o is AgendaGpiRecord;
}
