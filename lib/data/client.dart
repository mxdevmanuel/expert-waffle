import 'package:http/http.dart' as http;

class HttpClient {
  String baseUrl;
  HttpClient(this.baseUrl);

  Future<http.Response> get() {}
}
