import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';

class AiImageRecord extends FirestoreRecord {
  AiImageRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "creator" field.
  DocumentReference? _creator;
  DocumentReference? get creator => _creator;
  bool hasCreator() => _creator != null;

  // "firstImage" field.
  String? _firstImage;
  String get firstImage => _firstImage ?? '';
  bool hasFirstImage() => _firstImage != null;

  // "generatedImages" field.
  List<String>? _generatedImages;
  List<String> get generatedImages => _generatedImages ?? const [];
  bool hasGeneratedImages() => _generatedImages != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  bool hasType() => _type != null;

  // "prompt" field.
  String? _prompt;
  String get prompt => _prompt ?? '';
  bool hasPrompt() => _prompt != null;

  // "refImage" field.
  String? _refImage;
  String get refImage => _refImage ?? '';
  bool hasRefImage() => _refImage != null;

  void _initializeFields() {
    _creator = snapshotData['creator'] as DocumentReference?;
    _firstImage = snapshotData['firstImage'] as String?;
    _generatedImages = getDataList(snapshotData['generatedImages']);
    _type = snapshotData['type'] as String?;
    _prompt = snapshotData['prompt'] as String?;
    _refImage = snapshotData['refImage'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('aiImage');

  static Stream<AiImageRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AiImageRecord.fromSnapshot(s));

  static Future<AiImageRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AiImageRecord.fromSnapshot(s));

  static AiImageRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AiImageRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AiImageRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AiImageRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AiImageRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AiImageRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAiImageRecordData({
  DocumentReference? creator,
  String? firstImage,
  String? type,
  String? prompt,
  String? refImage,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'creator': creator,
      'firstImage': firstImage,
      'type': type,
      'prompt': prompt,
      'refImage': refImage,
    }.withoutNulls,
  );

  return firestoreData;
}

class AiImageRecordDocumentEquality implements Equality<AiImageRecord> {
  const AiImageRecordDocumentEquality();

  @override
  bool equals(AiImageRecord? e1, AiImageRecord? e2) {
    const listEquality = ListEquality();
    return e1?.creator == e2?.creator &&
        e1?.firstImage == e2?.firstImage &&
        listEquality.equals(e1?.generatedImages, e2?.generatedImages) &&
        e1?.type == e2?.type &&
        e1?.prompt == e2?.prompt &&
        e1?.refImage == e2?.refImage;
  }

  @override
  int hash(AiImageRecord? e) => const ListEquality().hash([
        e?.creator,
        e?.firstImage,
        e?.generatedImages,
        e?.type,
        e?.prompt,
        e?.refImage
      ]);

  @override
  bool isValidKey(Object? o) => o is AiImageRecord;
}
