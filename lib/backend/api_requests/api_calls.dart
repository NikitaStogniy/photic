import 'dart:convert';
import 'dart:typed_data';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start DEB Group Code

class DebGroup {
  static String baseUrl = 'https://photiqphalicruth.scade.pro/api/v1';
  static Map<String, String> headers = {
    'Authorization': 'Basic dXNlcjpiZ3NRRXJadFhiR2pDcmZjenZhU3BoWmZTd0NB',
  };
  static FaceSwapCall faceSwapCall = FaceSwapCall();
  static StatusCheckCall statusCheckCall = StatusCheckCall();
  static ApplyMaskCall applyMaskCall = ApplyMaskCall();
}

class FaceSwapCall {
  Future<ApiCallResponse> call({
    String? firstImage = '',
    String? secondImage = '',
  }) async {
    final ffApiRequestBody = '''
{
  "image_from": "${firstImage}",
  "image_to": "${secondImage}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'FaceSwap',
      apiUrl: '${DebGroup.baseUrl}/flow/swap/execute',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Basic dXNlcjpiZ3NRRXJadFhiR2pDcmZjenZhU3BoWmZTd0NB',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  dynamic id(dynamic response) => getJsonField(
        response,
        r'''$.id''',
      );
}

class StatusCheckCall {
  Future<ApiCallResponse> call({
    String? id = '3805',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'StatusCheck',
      apiUrl: '${DebGroup.baseUrl}/task/${id}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Basic dXNlcjpiZ3NRRXJadFhiR2pDcmZjenZhU3BoWmZTd0NB',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  dynamic result(dynamic response) => getJsonField(
        response,
        r'''$.result.image''',
      );
  dynamic status(dynamic response) => getJsonField(
        response,
        r'''$.status''',
      );
  dynamic from(dynamic response) => getJsonField(
        response,
        r'''$.data.image_from''',
      );
  dynamic to(dynamic response) => getJsonField(
        response,
        r'''$.data.image_to''',
      );
  dynamic textResult(dynamic response) => getJsonField(
        response,
        r'''$.result.image_0.url''',
      );
}

class ApplyMaskCall {
  Future<ApiCallResponse> call({
    String? imageUrl = '',
    String? maskImageUrl = '',
  }) async {
    final ffApiRequestBody = '''
{
    "start_node_id": "55f68523-fc5f-41fe-a75d-7cdfa5ed9773",
    "end_node_id": "656719a2-2b17-4ba2-a7ef-f31a11514c79",
    "result_node_id": "656719a2-2b17-4ba2-a7ef-f31a11514c79",
    "node_settings": {
        "55f68523-fc5f-41fe-a75d-7cdfa5ed9773": {
            "data": {
                "image": "${imageUrl}",
                "mask": "${maskImageUrl}",
                "promt": "naked"
            }
        }
    }
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'applyMask',
      apiUrl: '${DebGroup.baseUrl}/scade/flow/82/execute',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Basic dXNlcjpiZ3NRRXJadFhiR2pDcmZjenZhU3BoWmZTd0NB',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  dynamic image(dynamic response) => getJsonField(
        response,
        r'''$''',
      );
  dynamic id(dynamic response) => getJsonField(
        response,
        r'''$.id''',
      );
}

/// End DEB Group Code

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list);
  } catch (_) {
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar);
  } catch (_) {
    return isList ? '[]' : '{}';
  }
}
