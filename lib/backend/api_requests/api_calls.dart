import 'dart:convert';
import 'dart:typed_data';

import '../../flutter_flow/flutter_flow_util.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start DEB Group Code

class DebGroup {
  static String baseUrl = 'https://api-testing.piiixy.com/api/v1';
  static Map<String, String> headers = {
    'Authorization':
        'Basic OGIxMWM3ZmEtZmVlMy00YWUwLWEwMmYtZjBlNTY2MjA0MGY4OlFSZ0VWd3RCb2hIQm5JdnoyQzRZQnpoY3FhUEpMSg==',
  };
  static StableDiffusionCall stableDiffusionCall = StableDiffusionCall();
  static MidjourneyCall midjourneyCall = MidjourneyCall();
  static FaceSwapCall faceSwapCall = FaceSwapCall();
  static StatusCheckCall statusCheckCall = StatusCheckCall();
  static ApplyMaskCall applyMaskCall = ApplyMaskCall();
}

class StableDiffusionCall {
  Future<ApiCallResponse> call({
    String? query = '',
  }) {
    final ffApiRequestBody = '''
{
  "data": {
    "query": "${query}"
  }
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'StableDiffusion',
      apiUrl: '${DebGroup.baseUrl}/flow/sd/execute',
      callType: ApiCallType.POST,
      headers: {
        ...DebGroup.headers,
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

class MidjourneyCall {
  Future<ApiCallResponse> call({
    String? query = '',
  }) {
    final ffApiRequestBody = '''
{
  "data": {
    "query": "${query}"
  }
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Midjourney',
      apiUrl: '${DebGroup.baseUrl}/flow/mj/execute',
      callType: ApiCallType.POST,
      headers: {
        ...DebGroup.headers,
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

class FaceSwapCall {
  Future<ApiCallResponse> call({
    String? firstImage = '',
    String? secondImage = '',
  }) {
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
        ...DebGroup.headers,
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
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'StatusCheck',
      apiUrl: '${DebGroup.baseUrl}/task/${id}',
      callType: ApiCallType.GET,
      headers: {
        ...DebGroup.headers,
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
  }) {
    final ffApiRequestBody = '''
{
  "image_url": "${imageUrl}",
  "mask_image_url": "${maskImageUrl}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'applyMask',
      apiUrl: '${DebGroup.baseUrl}/flow/photiq/execute',
      callType: ApiCallType.POST,
      headers: {
        ...DebGroup.headers,
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
}

/// End DEB Group Code

class ImgToImgCall {
  static Future<ApiCallResponse> call({
    String? img = 'img',
    String? promt = '',
  }) {
    final ffApiRequestBody = '''
{
  "version": "2b017d9b67edd2ee1401238df49d75da53c523f36e363881e057f5dc3ed3c5b2",
  "input": {
    "image": "${img}",
    "prompt": "highres, highest quality, ultra detailed, (detailed face), (detailed eyes), cinematic lighting, best quality, hyper detailed, ${promt}",
    "num_images_per_prompt": 4,
    "strength": 0.5,
    "num_inference_steps": 150,
    "guidance_scale": 12.5,
    "negative_prompt": "disfigured, kitsch, ugly, oversaturated, greain, low-res, Deformed, blurry, bad anatomy, disfigured, poorly drawn face, mutation, mutated, extra limb, ugly, poorly drawn hands, missing limb, blurry, floating limbs, disconnected limbs, malformed hands, blur, out of focus, long neck, long body, ugly, disgusting, poorly drawn, childish, mutilated, mangled, old, surreal, calligraphy, sign, writing, watermark, text, body out of frame, extra legs, extra arms, extra feet, out of frame, poorly drawn feet, cross-eye, blurry, bad anatomy"
  }
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'imgToImg',
      apiUrl: 'https://api.replicate.com/v1/predictions',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Token r8_bDawEAdPWzh3hO4SWnaJrKPnWek47rv3rVgPr',
        'Content-Type': 'application/json',
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

  static dynamic id(dynamic response) => getJsonField(
        response,
        r'''$.id''',
      );
}

class StatusCall {
  static Future<ApiCallResponse> call({
    String? id = 'ptrl7y36wjfg3frvplvfrioesu',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'status',
      apiUrl: 'https://api.replicate.com/v1/predictions',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Token r8_bDawEAdPWzh3hO4SWnaJrKPnWek47rv3rVgPr',
        'Content-Type': 'application/json',
      },
      params: {
        'id': id,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic output(dynamic response) => getJsonField(
        response,
        r'''$.results[0].output''',
        true,
      );
  static dynamic status(dynamic response) => getJsonField(
        response,
        r'''$.results[:].status''',
        true,
      );
}

class TextToImgCall {
  static Future<ApiCallResponse> call({
    String? prompt = '',
  }) {
    final ffApiRequestBody = '''
{
  "version": "2b017d9b67edd2ee1401238df49d75da53c523f36e363881e057f5dc3ed3c5b2",
  "input": {
    "prompt": "mdjrny-v4 style ${prompt}",
    "num_outputs": 4,
    "strength": 0.6,
    "num_inference_steps": 100,
    "guidance_scale": 10,
    "negative_prompt": "deformed, blotches, blurry, saturated, maximalist, cripple, ugly, additional arms, additional legs, additional head, two heads, multiple people, group of people, blur"
  }
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'textToImg',
      apiUrl: 'https://api.replicate.com/v1/predictions',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Token r8_bDawEAdPWzh3hO4SWnaJrKPnWek47rv3rVgPr',
        'Content-Type': 'application/json',
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

  static dynamic id(dynamic response) => getJsonField(
        response,
        r'''$.id''',
      );
}

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
