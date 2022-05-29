import '../const/endpoints.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserNetworkUtilities {
  Future<http.Response> addUser(url, body,
      {Map<String, String?>? queryParams}) async {
    //GlobalKey<ScaffoldState> _scaffoldKey;
    Uri url1 = (Uri.http(BASE_URL, url, queryParams));
    print("BODY $body");
    print(url1);
    // print(await getHeaders());

    // final http.Response response = await http.post(Uri.http(BASE_URL, url),
    //     body: json.encode({"name": "Ravinshu Makkar", "tech": "Flutter"}));
    final http.Response response = await http.post(
      url1,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
      },
      body: body,
    );
    print("BODY ${response.body}");
    print("STATUS CODE ${response.statusCode}");
    return response;
  }

  Future<http.Response> viewUser(url,
      {Map<String, String?>? queryParams, body}) async {
    //GlobalKey<ScaffoldState> _scaffoldKey;
    Uri url1 = (Uri.http(BASE_URL, url, queryParams));
    // print("BODY $body");
    print("$url1");
    final http.Response response = await http.get(
      url1,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
      },
    );
    print("BODY ${response.body}");
    print("STATUS CODE ${response.statusCode}");
    return response;
  }
}
