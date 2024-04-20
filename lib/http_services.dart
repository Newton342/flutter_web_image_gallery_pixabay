import 'dart:convert';

import 'package:http/http.dart' as http;

class HTTPServices {
  // final String _baseUrl =
  //     'https://pixabay.com/api/?key=43423427-d18dfaf92065a4742211d156e';

  final String _domain = "www.pixabay.com";
  final String _userKey = "43423427-d18dfaf92065a4742211d156e";

  static dynamic getData() async {
    try {
      final key = {"key": HTTPServices()._userKey, "per_page": "30"};

      Uri a = Uri.https(HTTPServices()._domain, '/api/', key);
      print(a.path);
      print(a.queryParametersAll);
      http.Response response = await http.get(a);
      return jsonDecode(response.body);
    } catch (e) {
      print("Exception ------------------------>$e");
    }
  }
}
