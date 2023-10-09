import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class StylesRecord extends FirestoreRecord {
  StylesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "prompt" field.
  String? _prompt;
  String get prompt => _prompt ?? '';
  bool hasPrompt() => _prompt != null;

  // "preview" field.
  String? _preview;
  String get preview => _preview ?? '';
  bool hasPreview() => _preview != null;

  // "gender" field.
  String? _gender;
  String get gender => _gender ?? '';
  bool hasGender() => _gender != null;

  // "big" field.
  String? _big;
  String get big => _big ?? '';
  bool hasBig() => _big != null;

  // "isPro" field.
  bool? _isPro;
  bool get isPro => _isPro ?? false;
  bool hasIsPro() => _isPro != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _prompt = snapshotData['prompt'] as String?;
    _preview = snapshotData['preview'] as String?;
    _gender = snapshotData['gender'] as String?;
    _big = snapshotData['big'] as String?;
    _isPro = snapshotData['isPro'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('styles');

  static Stream<StylesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => StylesRecord.fromSnapshot(s));

  static Future<StylesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => StylesRecord.fromSnapshot(s));

  static StylesRecord fromSnapshot(DocumentSnapshot snapshot) => StylesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static StylesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      StylesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'StylesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is StylesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createStylesRecordData({
  String? name,
  String? prompt,
  String? preview,
  String? gender,
  String? big,
  bool? isPro,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'prompt': prompt,
      'preview': preview,
      'gender': gender,
      'big': big,
      'isPro': isPro,
    }.withoutNulls,
  );

  return firestoreData;
}

class StylesRecordDocumentEquality implements Equality<StylesRecord> {
  const StylesRecordDocumentEquality();

  @override
  bool equals(StylesRecord? e1, StylesRecord? e2) {
    return e1?.name == e2?.name &&
        e1?.prompt == e2?.prompt &&
        e1?.preview == e2?.preview &&
        e1?.gender == e2?.gender &&
        e1?.big == e2?.big &&
        e1?.isPro == e2?.isPro;
  }

  @override
  int hash(StylesRecord? e) => const ListEquality()
      .hash([e?.name, e?.prompt, e?.preview, e?.gender, e?.big, e?.isPro]);

  @override
  bool isValidKey(Object? o) => o is StylesRecord;
}
