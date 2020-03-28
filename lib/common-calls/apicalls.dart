// import 'dart:async';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// Future<ClientNames> fetchClientNames() async {
//   final response =
//       await http.get('https://script.google.com/macros/s/AKfycbyIaIR_Ix2KsuX6eYrn3EtywbHwmvn1IAYI3BkhoGK5lTTflrkB/exec');

//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return ClientNames.fromJson(json.decode(response.body));
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load album');
//   }
// }