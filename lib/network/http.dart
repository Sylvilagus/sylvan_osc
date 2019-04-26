/**
 * Created by Sylva Lee
 */

import 'package:http/http.dart' as http;
import 'dart:convert';

typedef EntityConverter<Entity> = Entity Function(String string);

abstract class Request {
  String url;
  Map<String, dynamic> params;
  Map<String, dynamic> headers;
  Encoding encoding;

  Request.url(this.url, {this.params, this.headers, this.encoding});

  Request param(String key, dynamic value) {
    params ??= Map();
    params[key] = value;
    return this;
  }

  Request header(String key, String value) {
    headers ??= Map();
    headers[key] = value;
    return this;
  }

  Future<String> execute() async {
    var response = await doRequest();
    return response.body;
  }

  Future<Entity> executeWithConverter<Entity>(EntityConverter<Entity> converter) async {
    var response = await doRequest();
    return converter(response.body);
  }

  Future<http.Response> doRequest();
}

class Post extends Request {
  Post.url(String url,
      {Map<String, dynamic> params,
      Map<String, dynamic> headers,
      Encoding encoding = const Utf8Codec()})
      : super.url(url, params: params, headers: headers, encoding: encoding);

  //future里返回future，结果还是future而不是future<future>
  @override
  Future<http.Response> doRequest() async {
    return await http.post(url,
        headers: headers, body: params, encoding: encoding);
  }
}

class Get extends Request {
  Get.url(String url,
      {Map<String, dynamic> params,
      Map<String, dynamic> headers,
      Encoding encoding = const Utf8Codec()})
      : super.url(url, params: params, headers: headers, encoding: encoding);

  //future里返回future，结果还是future而不是future<future>
  @override
  Future<http.Response> doRequest() async {
    var sb = StringBuffer();
    params.forEach((k, v) {
      if (sb.length != 0) {
        sb.write("&");
      }
      sb.write("$k=$v");
    });
    return await http.post("$url?${sb.toString()}",
        headers: headers, encoding: encoding);
  }
}
