import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PropertiesRecord extends FirestoreRecord {
  PropertiesRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "propertyName" field.
  String? _propertyName;
  String get propertyName => _propertyName ?? '';
  bool hasPropertyName() => _propertyName != null;

  // "propertyDescription" field.
  String? _propertyDescription;
  String get propertyDescription => _propertyDescription ?? '';
  bool hasPropertyDescription() => _propertyDescription != null;

  // "mainImage" field.
  String? _mainImage;
  String get mainImage => _mainImage ?? '';
  bool hasMainImage() => _mainImage != null;

  // "isDraft" field.
  bool? _isDraft;
  bool get isDraft => _isDraft ?? false;
  bool hasIsDraft() => _isDraft != null;

  // "userRef" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  bool hasUserRef() => _userRef != null;

  // "propertyNeighborhood" field.
  String? _propertyNeighborhood;
  String get propertyNeighborhood => _propertyNeighborhood ?? '';
  bool hasPropertyNeighborhood() => _propertyNeighborhood != null;

  // "ratingSummary" field.
  double? _ratingSummary;
  double get ratingSummary => _ratingSummary ?? 0.0;
  bool hasRatingSummary() => _ratingSummary != null;

  // "taxRate" field.
  double? _taxRate;
  double get taxRate => _taxRate ?? 0.0;
  bool hasTaxRate() => _taxRate != null;

  // "cleaningFee" field.
  int? _cleaningFee;
  int get cleaningFee => _cleaningFee ?? 0;
  bool hasCleaningFee() => _cleaningFee != null;

  // "notes" field.
  String? _notes;
  String get notes => _notes ?? '';
  bool hasNotes() => _notes != null;

  // "minNightStay" field.
  double? _minNightStay;
  double get minNightStay => _minNightStay ?? 0.0;
  bool hasMinNightStay() => _minNightStay != null;

  // "lastUpdated" field.
  DateTime? _lastUpdated;
  DateTime? get lastUpdated => _lastUpdated;
  bool hasLastUpdated() => _lastUpdated != null;

  // "minNights" field.
  int? _minNights;
  int get minNights => _minNights ?? 0;
  bool hasMinNights() => _minNights != null;

  // "isLive" field.
  bool? _isLive;
  bool get isLive => _isLive ?? false;
  bool hasIsLive() => _isLive != null;

  // "coordenadas" field.
  List<CoordenadasStruct>? _coordenadas;
  List<CoordenadasStruct> get coordenadas => _coordenadas ?? const [];
  bool hasCoordenadas() => _coordenadas != null;

  // "propertyStreet" field.
  String? _propertyStreet;
  String get propertyStreet => _propertyStreet ?? '';
  bool hasPropertyStreet() => _propertyStreet != null;

  // "propertyNumber" field.
  String? _propertyNumber;
  String get propertyNumber => _propertyNumber ?? '';
  bool hasPropertyNumber() => _propertyNumber != null;

  // "propertyCity" field.
  String? _propertyCity;
  String get propertyCity => _propertyCity ?? '';
  bool hasPropertyCity() => _propertyCity != null;

  // "propertyState" field.
  String? _propertyState;
  String get propertyState => _propertyState ?? '';
  bool hasPropertyState() => _propertyState != null;

  // "propertyZipCode" field.
  String? _propertyZipCode;
  String get propertyZipCode => _propertyZipCode ?? '';
  bool hasPropertyZipCode() => _propertyZipCode != null;

  // "propertyCoords" field.
  LatLng? _propertyCoords;
  LatLng? get propertyCoords => _propertyCoords;
  bool hasPropertyCoords() => _propertyCoords != null;

  // "price" field.
  double? _price;
  double get price => _price ?? 0.0;
  bool hasPrice() => _price != null;

  // "telPropiedad" field.
  int? _telPropiedad;
  int get telPropiedad => _telPropiedad ?? 0;
  bool hasTelPropiedad() => _telPropiedad != null;

  // "tipoPropiedad" field.
  String? _tipoPropiedad;
  String get tipoPropiedad => _tipoPropiedad ?? '';
  bool hasTipoPropiedad() => _tipoPropiedad != null;

  // "tipoVendedor" field.
  String? _tipoVendedor;
  String get tipoVendedor => _tipoVendedor ?? '';
  bool hasTipoVendedor() => _tipoVendedor != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "idUser" field.
  String? _idUser;
  String get idUser => _idUser ?? '';
  bool hasIdUser() => _idUser != null;

  // "fechaDisponibleProp" field.
  DateTime? _fechaDisponibleProp;
  DateTime? get fechaDisponibleProp => _fechaDisponibleProp;
  bool hasFechaDisponibleProp() => _fechaDisponibleProp != null;

  // "roomsPropiedad" field.
  int? _roomsPropiedad;
  int get roomsPropiedad => _roomsPropiedad ?? 0;
  bool hasRoomsPropiedad() => _roomsPropiedad != null;

  // "bathsPropiedad" field.
  int? _bathsPropiedad;
  int get bathsPropiedad => _bathsPropiedad ?? 0;
  bool hasBathsPropiedad() => _bathsPropiedad != null;

  // "images" field.
  List<ImageListStruct>? _images;
  List<ImageListStruct> get images => _images ?? const [];
  bool hasImages() => _images != null;

  void _initializeFields() {
    _propertyName = snapshotData['propertyName'] as String?;
    _propertyDescription = snapshotData['propertyDescription'] as String?;
    _mainImage = snapshotData['mainImage'] as String?;
    _isDraft = snapshotData['isDraft'] as bool?;
    _userRef = snapshotData['userRef'] as DocumentReference?;
    _propertyNeighborhood = snapshotData['propertyNeighborhood'] as String?;
    _ratingSummary = castToType<double>(snapshotData['ratingSummary']);
    _taxRate = castToType<double>(snapshotData['taxRate']);
    _cleaningFee = castToType<int>(snapshotData['cleaningFee']);
    _notes = snapshotData['notes'] as String?;
    _minNightStay = castToType<double>(snapshotData['minNightStay']);
    _lastUpdated = snapshotData['lastUpdated'] as DateTime?;
    _minNights = castToType<int>(snapshotData['minNights']);
    _isLive = snapshotData['isLive'] as bool?;
    _coordenadas = getStructList(
      snapshotData['coordenadas'],
      CoordenadasStruct.fromMap,
    );
    _propertyStreet = snapshotData['propertyStreet'] as String?;
    _propertyNumber = snapshotData['propertyNumber'] as String?;
    _propertyCity = snapshotData['propertyCity'] as String?;
    _propertyState = snapshotData['propertyState'] as String?;
    _propertyZipCode = snapshotData['propertyZipCode'] as String?;
    _propertyCoords = snapshotData['propertyCoords'] as LatLng?;
    _price = castToType<double>(snapshotData['price']);
    _telPropiedad = castToType<int>(snapshotData['telPropiedad']);
    _tipoPropiedad = snapshotData['tipoPropiedad'] as String?;
    _tipoVendedor = snapshotData['tipoVendedor'] as String?;
    _status = snapshotData['status'] as String?;
    _idUser = snapshotData['idUser'] as String?;
    _fechaDisponibleProp = snapshotData['fechaDisponibleProp'] as DateTime?;
    _roomsPropiedad = castToType<int>(snapshotData['roomsPropiedad']);
    _bathsPropiedad = castToType<int>(snapshotData['bathsPropiedad']);
    _images = getStructList(
      snapshotData['images'],
      ImageListStruct.fromMap,
    );
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('properties');

  static Stream<PropertiesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PropertiesRecord.fromSnapshot(s));

  static Future<PropertiesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PropertiesRecord.fromSnapshot(s));

  static PropertiesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      PropertiesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PropertiesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PropertiesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PropertiesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PropertiesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPropertiesRecordData({
  String? propertyName,
  String? propertyDescription,
  String? mainImage,
  bool? isDraft,
  DocumentReference? userRef,
  String? propertyNeighborhood,
  double? ratingSummary,
  double? taxRate,
  int? cleaningFee,
  String? notes,
  double? minNightStay,
  DateTime? lastUpdated,
  int? minNights,
  bool? isLive,
  String? propertyStreet,
  String? propertyNumber,
  String? propertyCity,
  String? propertyState,
  String? propertyZipCode,
  LatLng? propertyCoords,
  double? price,
  int? telPropiedad,
  String? tipoPropiedad,
  String? tipoVendedor,
  String? status,
  String? idUser,
  DateTime? fechaDisponibleProp,
  int? roomsPropiedad,
  int? bathsPropiedad,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'propertyName': propertyName,
      'propertyDescription': propertyDescription,
      'mainImage': mainImage,
      'isDraft': isDraft,
      'userRef': userRef,
      'propertyNeighborhood': propertyNeighborhood,
      'ratingSummary': ratingSummary,
      'taxRate': taxRate,
      'cleaningFee': cleaningFee,
      'notes': notes,
      'minNightStay': minNightStay,
      'lastUpdated': lastUpdated,
      'minNights': minNights,
      'isLive': isLive,
      'propertyStreet': propertyStreet,
      'propertyNumber': propertyNumber,
      'propertyCity': propertyCity,
      'propertyState': propertyState,
      'propertyZipCode': propertyZipCode,
      'propertyCoords': propertyCoords,
      'price': price,
      'telPropiedad': telPropiedad,
      'tipoPropiedad': tipoPropiedad,
      'tipoVendedor': tipoVendedor,
      'status': status,
      'idUser': idUser,
      'fechaDisponibleProp': fechaDisponibleProp,
      'roomsPropiedad': roomsPropiedad,
      'bathsPropiedad': bathsPropiedad,
    }.withoutNulls,
  );

  return firestoreData;
}

class PropertiesRecordDocumentEquality implements Equality<PropertiesRecord> {
  const PropertiesRecordDocumentEquality();

  @override
  bool equals(PropertiesRecord? e1, PropertiesRecord? e2) {
    const listEquality = ListEquality();
    return e1?.propertyName == e2?.propertyName &&
        e1?.propertyDescription == e2?.propertyDescription &&
        e1?.mainImage == e2?.mainImage &&
        e1?.isDraft == e2?.isDraft &&
        e1?.userRef == e2?.userRef &&
        e1?.propertyNeighborhood == e2?.propertyNeighborhood &&
        e1?.ratingSummary == e2?.ratingSummary &&
        e1?.taxRate == e2?.taxRate &&
        e1?.cleaningFee == e2?.cleaningFee &&
        e1?.notes == e2?.notes &&
        e1?.minNightStay == e2?.minNightStay &&
        e1?.lastUpdated == e2?.lastUpdated &&
        e1?.minNights == e2?.minNights &&
        e1?.isLive == e2?.isLive &&
        listEquality.equals(e1?.coordenadas, e2?.coordenadas) &&
        e1?.propertyStreet == e2?.propertyStreet &&
        e1?.propertyNumber == e2?.propertyNumber &&
        e1?.propertyCity == e2?.propertyCity &&
        e1?.propertyState == e2?.propertyState &&
        e1?.propertyZipCode == e2?.propertyZipCode &&
        e1?.propertyCoords == e2?.propertyCoords &&
        e1?.price == e2?.price &&
        e1?.telPropiedad == e2?.telPropiedad &&
        e1?.tipoPropiedad == e2?.tipoPropiedad &&
        e1?.tipoVendedor == e2?.tipoVendedor &&
        e1?.status == e2?.status &&
        e1?.idUser == e2?.idUser &&
        e1?.fechaDisponibleProp == e2?.fechaDisponibleProp &&
        e1?.roomsPropiedad == e2?.roomsPropiedad &&
        e1?.bathsPropiedad == e2?.bathsPropiedad &&
        listEquality.equals(e1?.images, e2?.images);
  }

  @override
  int hash(PropertiesRecord? e) => const ListEquality().hash([
        e?.propertyName,
        e?.propertyDescription,
        e?.mainImage,
        e?.isDraft,
        e?.userRef,
        e?.propertyNeighborhood,
        e?.ratingSummary,
        e?.taxRate,
        e?.cleaningFee,
        e?.notes,
        e?.minNightStay,
        e?.lastUpdated,
        e?.minNights,
        e?.isLive,
        e?.coordenadas,
        e?.propertyStreet,
        e?.propertyNumber,
        e?.propertyCity,
        e?.propertyState,
        e?.propertyZipCode,
        e?.propertyCoords,
        e?.price,
        e?.telPropiedad,
        e?.tipoPropiedad,
        e?.tipoVendedor,
        e?.status,
        e?.idUser,
        e?.fechaDisponibleProp,
        e?.roomsPropiedad,
        e?.bathsPropiedad,
        e?.images
      ]);

  @override
  bool isValidKey(Object? o) => o is PropertiesRecord;
}
