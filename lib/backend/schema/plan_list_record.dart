import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PlanListRecord extends FirestoreRecord {
  PlanListRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "Plan" field.
  PlanStruct? _plan;
  PlanStruct get plan => _plan ?? PlanStruct();
  bool hasPlan() => _plan != null;

  // "Description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "packageId" field.
  String? _packageId;
  String get packageId => _packageId ?? '';
  bool hasPackageId() => _packageId != null;

  void _initializeFields() {
    _plan = PlanStruct.maybeFromMap(snapshotData['Plan']);
    _description = snapshotData['Description'] as String?;
    _packageId = snapshotData['packageId'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('PlanList');

  static Stream<PlanListRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PlanListRecord.fromSnapshot(s));

  static Future<PlanListRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PlanListRecord.fromSnapshot(s));

  static PlanListRecord fromSnapshot(DocumentSnapshot snapshot) =>
      PlanListRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PlanListRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PlanListRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PlanListRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PlanListRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPlanListRecordData({
  PlanStruct? plan,
  String? description,
  String? packageId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'Plan': PlanStruct().toMap(),
      'Description': description,
      'packageId': packageId,
    }.withoutNulls,
  );

  // Handle nested data for "Plan" field.
  addPlanStructData(firestoreData, plan, 'Plan');

  return firestoreData;
}

class PlanListRecordDocumentEquality implements Equality<PlanListRecord> {
  const PlanListRecordDocumentEquality();

  @override
  bool equals(PlanListRecord? e1, PlanListRecord? e2) {
    return e1?.plan == e2?.plan &&
        e1?.description == e2?.description &&
        e1?.packageId == e2?.packageId;
  }

  @override
  int hash(PlanListRecord? e) =>
      const ListEquality().hash([e?.plan, e?.description, e?.packageId]);

  @override
  bool isValidKey(Object? o) => o is PlanListRecord;
}
