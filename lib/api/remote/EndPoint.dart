import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:dealmart/api/model/BaseApiResponse.dart';
import 'package:dealmart/resources/Strings.dart';
import 'package:dealmart/utils/shared_utils.dart';
import 'package:http/http.dart' as http;
import '../AppConfig.dart';

const APPLICATION_JSON = "application/json";
const APPLICATION_MULTIPART = "multipart/form-data";
const FORM_ENCODED_URL = "application/x-www-form-urlencoded";
const POST = "post";
const GET = "get";

class EndPoint<R extends BaseApiResponse> {
  static final EndPoint shared = EndPoint._internal();
  EndPoint._internal() {}

  String refreshedToken='';
  HttpClient httpClient = HttpClient();
  String _baseUrl = AppConfig.shared.getBaseUrl();
  Map<String, String> _headers = Map<String, String>();
  Map<String, String> _headers33 = Map<String, String>();
  Map<String, dynamic> _parameters = new Map();
  RequestType _method_type = RequestType.post;
  bool _isNeedAuth = true;
  bool isAgain= false;
  static final _client = new http.Client();

  Uri _buildUrl(String function, {Map<String, String> params}) {
    String url;

    if (params == null) //params = new Map<String, String>();
        {
      url = Uri.http(_baseUrl, function).toString();
    } else {
      url = Uri.http(_baseUrl, function, params).toString();
    }

    print(url);
    return Uri.parse(url);
  }

  EndPoint setMethodType(RequestType type) {
    _method_type = type;
    return this;
  }

  EndPoint setNeedAuth(bool isAuth) {
    _isNeedAuth = isAuth;
    return this;
  }
  EndPoint setIsAgain(bool aa) {
    isAgain = aa;
    return this;
  }

  _getRequestType() {
    switch (_method_type) {
      case RequestType.post:
        return "post";
      case RequestType.get:
        return "get";
      case RequestType.delete:
        return "delete";
      case RequestType.put:
        return "put";
    }
  }

  RequestType getType(String method){
    switch (method) {
      case 'post':
        return RequestType.post;
      case 'get':
        return RequestType.get;
      case 'delete':
        return RequestType.delete;
      case "put":
        return RequestType.put;
    }
  }

  EndPoint addParameter(String key, dynamic value) {
    _parameters.putIfAbsent(key, value);
    return this;
  }

  EndPoint addAllBody(Map<String, dynamic> map) {
    _parameters.addAll(map);
    return this;
  }

  EndPoint addHeader(String key, String value) {
    _headers.putIfAbsent(key, () => value);
    return this;
  }

  EndPoint addHeader33(String key, String value) {
    _headers33.putIfAbsent(key, () => value);
    return this;
  }

  Map<String, String> _getHeader({String contentType = APPLICATION_JSON}) {
    if (contentType == null || contentType.trim().length == 0)
      contentType = APPLICATION_JSON;
    addHeader("Content-Type", contentType);
    if (Strings.english) {
      addHeader("Accept-Language", "en");
    } else {
      addHeader("Accept-Language", "ar");
    }

    if (_isNeedAuth) {
      if(userToken.isNotEmpty)
        addHeader("Authorization", "Bearer " + userToken);
    }
    print('headers ===>>  '+_headers.toString());

    return _headers;
  }


  Map<String, String> _getHeader33({String contentType = APPLICATION_JSON}) {
    if (contentType == null || contentType.trim().length == 0)
      contentType = APPLICATION_JSON;
    addHeader33("Content-Type", contentType);
    if (Strings.english) {
      addHeader33("Accept-Language", "en");
    } else {
      addHeader33("Accept-Language", "ar");
    }

    if (_isNeedAuth) {
        addHeader33("Authorization", "bearer " + refreshedToken);
    }
    print('headers ===>>  '+_headers33.toString());

    return _headers33;
  }

  String _getRowBody({Map bodyMap, String rowBody, bool hasToken}) {
    return bodyMap != null ? json.encode(bodyMap) : rowBody;
  }

  Future<Stream<R>> callStreamRequest(
      String method,
      String action, String body,
      responseCreator,
      {Map<String, String> params,
        bool isCustomParamters = false,
        List<String> paramList,
        Map bodyFields,
        String contentType,
        bool needFormat = false}) async {
    String url;
    if (isCustomParamters) {
      url = Uri.http(_baseUrl, action).toString() + "/" + paramList[0];
    } else {
      url = _buildUrl(action, params: params).toString();
    ///  print('>>>>>>>'+url);
    }

    if(body != null)
    print('Body ===>>  '+body??'');
    var req = http.Request(_getRequestType(), Uri.parse(url));
    

    req.headers.addAll(isAgain?_getHeader33(contentType: contentType):_getHeader(contentType: contentType));
    if (method == POST) {
      if (contentType == APPLICATION_JSON) {
        if (bodyFields != null || body != null)
          req.body = _getRowBody(bodyMap: bodyFields, rowBody: body);
      }
      else if (contentType == FORM_ENCODED_URL||contentType==APPLICATION_MULTIPART) {
        req.bodyFields = bodyFields;
      }
    }
    if (body != null) {
      req.body = body;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           body = body;
    }
    var streamResponse = await _client.send(req).timeout(Duration(seconds: 60));
    print('headers response ===>>  '+streamResponse.headers.toString());
    print('statusCode ===>>  '+streamResponse.statusCode.toString());


      return streamResponse.stream
          .transform(utf8.decoder)
          .transform(json.decoder)
          .map((map) {
        print('streamResponse >>> ' + json.encode(map));
        return responseCreator(map);
      });



  }





}

typedef T Creator<T>(Map<String, dynamic> json);

enum RequestType { get, post, delete, put }
