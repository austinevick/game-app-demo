import 'package:http/http.dart';

class HttpClient {
  static final _client = Client();

  static const customHeader = {'content-type': 'application/json'};

  static Future<Response> getRequest(String url, {String? token}) {
    return _client.get(Uri.parse(url),
        headers: {...customHeader, 'Authorization': 'Bearer $token'});
  }

  static Future<Response> postRequest(String url, Object body,
      {String? token, Map<String, String>? headers}) {
    return _client.post(Uri.parse(url),
        headers: {...headers ?? {}, 'Authorization': 'Bearer $token'},
        body: body);
  }
}
