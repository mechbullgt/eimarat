import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

final String url =
      "https://script.google.com/macros/s/AKfycbyIaIR_Ix2KsuX6eYrn3EtywbHwmvn1IAYI3BkhoGK5lTTflrkB/exec";

  Future<String> getClientsList() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
 if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return "Success";
  } else {
     // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
  }

  List returnClientsList (var res){
    Map<String, dynamic> resBody = json.decode(res.body);
    List data = List(); //edited line
    data = resBody['clientNamesAPI'];
    return data;
  }