// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PlanStruct extends FFFirebaseStruct {
  PlanStruct({
    String? name,
    int? limit,
    int? used,
    DateTime? deadline,
    double? price,
    String? description,
    List<String>? featureList,
    int? inpaintLimit,
    int? inpaintUsed,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _name = name,
        _limit = limit,
        _used = used,
        _deadline = deadline,
        _price = price,
        _description = description,
        _featureList = featureList,
        _inpaintLimit = inpaintLimit,
        _inpaintUsed = inpaintUsed,
        super(firestoreUtilData);

  // "Name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;
  bool hasName() => _name != null;

  // "Limit" field.
  int? _limit;
  int get limit => _limit ?? 0;
  set limit(int? val) => _limit = val;
  void incrementLimit(int amount) => _limit = limit + amount;
  bool hasLimit() => _limit != null;

  // "Used" field.
  int? _used;
  int get used => _used ?? 0;
  set used(int? val) => _used = val;
  void incrementUsed(int amount) => _used = used + amount;
  bool hasUsed() => _used != null;

  // "Deadline" field.
  DateTime? _deadline;
  DateTime? get deadline => _deadline;
  set deadline(DateTime? val) => _deadline = val;
  bool hasDeadline() => _deadline != null;

  // "Price" field.
  double? _price;
  double get price => _price ?? 0.0;
  set price(double? val) => _price = val;
  void incrementPrice(double amount) => _price = price + amount;
  bool hasPrice() => _price != null;

  // "Description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;
  bool hasDescription() => _description != null;

  // "FeatureList" field.
  List<String>? _featureList;
  List<String> get featureList => _featureList ?? const [];
  set featureList(List<String>? val) => _featureList = val;
  void updateFeatureList(Function(List<String>) updateFn) =>
      updateFn(_featureList ??= []);
  bool hasFeatureList() => _featureList != null;

  // "InpaintLimit" field.
  int? _inpaintLimit;
  int get inpaintLimit => _inpaintLimit ?? 0;
  set inpaintLimit(int? val) => _inpaintLimit = val;
  void incrementInpaintLimit(int amount) =>
      _inpaintLimit = inpaintLimit + amount;
  bool hasInpaintLimit() => _inpaintLimit != null;

  // "inpaintUsed" field.
  int? _inpaintUsed;
  int get inpaintUsed => _inpaintUsed ?? 0;
  set inpaintUsed(int? val) => _inpaintUsed = val;
  void incrementInpaintUsed(int amount) => _inpaintUsed = inpaintUsed + amount;
  bool hasInpaintUsed() => _inpaintUsed != null;

  static PlanStruct fromMap(Map<String, dynamic> data) => PlanStruct(
        name: data['Name'] as String?,
        limit: castToType<int>(data['Limit']),
        used: castToType<int>(data['Used']),
        deadline: data['Deadline'] as DateTime?,
        price: castToType<double>(data['Price']),
        description: data['Description'] as String?,
        featureList: getDataList(data['FeatureList']),
        inpaintLimit: castToType<int>(data['InpaintLimit']),
        inpaintUsed: castToType<int>(data['inpaintUsed']),
      );

  static PlanStruct? maybeFromMap(dynamic data) =>
      data is Map ? PlanStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'Name': _name,
        'Limit': _limit,
        'Used': _used,
        'Deadline': _deadline,
        'Price': _price,
        'Description': _description,
        'FeatureList': _featureList,
        'InpaintLimit': _inpaintLimit,
        'inpaintUsed': _inpaintUsed,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'Name': serializeParam(
          _name,
          ParamType.String,
        ),
        'Limit': serializeParam(
          _limit,
          ParamType.int,
        ),
        'Used': serializeParam(
          _used,
          ParamType.int,
        ),
        'Deadline': serializeParam(
          _deadline,
          ParamType.DateTime,
        ),
        'Price': serializeParam(
          _price,
          ParamType.double,
        ),
        'Description': serializeParam(
          _description,
          ParamType.String,
        ),
        'FeatureList': serializeParam(
          _featureList,
          ParamType.String,
          true,
        ),
        'InpaintLimit': serializeParam(
          _inpaintLimit,
          ParamType.int,
        ),
        'inpaintUsed': serializeParam(
          _inpaintUsed,
          ParamType.int,
        ),
      }.withoutNulls;

  static PlanStruct fromSerializableMap(Map<String, dynamic> data) =>
      PlanStruct(
        name: deserializeParam(
          data['Name'],
          ParamType.String,
          false,
        ),
        limit: deserializeParam(
          data['Limit'],
          ParamType.int,
          false,
        ),
        used: deserializeParam(
          data['Used'],
          ParamType.int,
          false,
        ),
        deadline: deserializeParam(
          data['Deadline'],
          ParamType.DateTime,
          false,
        ),
        price: deserializeParam(
          data['Price'],
          ParamType.double,
          false,
        ),
        description: deserializeParam(
          data['Description'],
          ParamType.String,
          false,
        ),
        featureList: deserializeParam<String>(
          data['FeatureList'],
          ParamType.String,
          true,
        ),
        inpaintLimit: deserializeParam(
          data['InpaintLimit'],
          ParamType.int,
          false,
        ),
        inpaintUsed: deserializeParam(
          data['inpaintUsed'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'PlanStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is PlanStruct &&
        name == other.name &&
        limit == other.limit &&
        used == other.used &&
        deadline == other.deadline &&
        price == other.price &&
        description == other.description &&
        listEquality.equals(featureList, other.featureList) &&
        inpaintLimit == other.inpaintLimit &&
        inpaintUsed == other.inpaintUsed;
  }

  @override
  int get hashCode => const ListEquality().hash([
        name,
        limit,
        used,
        deadline,
        price,
        description,
        featureList,
        inpaintLimit,
        inpaintUsed
      ]);
}

PlanStruct createPlanStruct({
  String? name,
  int? limit,
  int? used,
  DateTime? deadline,
  double? price,
  String? description,
  int? inpaintLimit,
  int? inpaintUsed,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PlanStruct(
      name: name,
      limit: limit,
      used: used,
      deadline: deadline,
      price: price,
      description: description,
      inpaintLimit: inpaintLimit,
      inpaintUsed: inpaintUsed,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PlanStruct? updatePlanStruct(
  PlanStruct? plan, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    plan
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPlanStructData(
  Map<String, dynamic> firestoreData,
  PlanStruct? plan,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (plan == null) {
    return;
  }
  if (plan.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue && plan.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final planData = getPlanFirestoreData(plan, forFieldValue);
  final nestedData = planData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = plan.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPlanFirestoreData(
  PlanStruct? plan, [
  bool forFieldValue = false,
]) {
  if (plan == null) {
    return {};
  }
  final firestoreData = mapToFirestore(plan.toMap());

  // Add any Firestore field values
  plan.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPlanListFirestoreData(
  List<PlanStruct>? plans,
) =>
    plans?.map((e) => getPlanFirestoreData(e, true)).toList() ?? [];
