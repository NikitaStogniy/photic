import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';

class PendingRecord extends FirestoreRecord {
  PendingRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  bool hasId() => _id != null;

  // "genRef" field.
  DocumentReference? _genRef;
  DocumentReference? get genRef => _genRef;
  bool hasGenRef() => _genRef != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _id = snapshotData['id'] as String?;
    _genRef = snapshotData['genRef'] as DocumentReference?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('pending')
          : FirebaseFirestore.instance.collectionGroup('pending');

  static DocumentReference createDoc(DocumentReference parent) =>
      parent.collection('pending').doc();

  static Stream<PendingRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PendingRecord.fromSnapshot(s));

  static Future<PendingRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PendingRecord.fromSnapshot(s));

  static PendingRecord fromSnapshot(DocumentSnapshot snapshot) =>
      PendingRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PendingRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PendingRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PendingRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PendingRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPendingRecordData({
  String? id,
  DocumentReference? genRef,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'id': id,
      'genRef': genRef,
    }.withoutNulls,
  );

  return firestoreData;
}

class PendingRecordDocumentEquality implements Equality<PendingRecord> {
  const PendingRecordDocumentEquality();

  @override
  bool equals(PendingRecord? e1, PendingRecord? e2) {
    return e1?.id == e2?.id && e1?.genRef == e2?.genRef;
  }

  @override
  int hash(PendingRecord? e) => const ListEquality().hash([e?.id, e?.genRef]);

  @override
  bool isValidKey(Object? o) => o is PendingRecord;
}
