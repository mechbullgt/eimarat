import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:eimarat/model/sales-form.dart';

/// FormController is a class which does work of saving FeedbackForm in Google Sheets using 
/// HTTP GET request on Google App Script Web URL and parses response and sends result callback.
class FormController {
  // Callback function to give response of status of current request.
  final void Function(String) callback;

  // Google App Script Web URL.
  static const String URL = "https://script.google.com/macros/s/AKfycby1hqWxA1nlELW6BoVLQ1dlBt5ithuI4I2ZwRcT91npSVty-ZlL/exec";
  
  // Success Status Message
  static const STATUS_SUCCESS = "SUCCESS";

  // Default Contructor
  FormController(this.callback);

  /// Async function which saves feedback, parses [feedbackForm] parameters
  /// and sends HTTP GET request on [URL]. On successful response, [callback] is called.
  void submitForm(FeedbackForm feedbackForm) async {
    try {
      await http.get(
        URL + feedbackForm.toParams()
      ).then((response){
        print("Response:"+response.body);
        callback(convert.jsonDecode(response.body)['status']);
      });    
    } catch (e) {
      print(e);
    }
  }
}