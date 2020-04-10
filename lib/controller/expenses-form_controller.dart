import 'dart:convert' as convert;
import 'package:eimarat/model/expenses-form.dart';
import 'package:http/http.dart' as http;

/// FormController is a class which does work of saving FeedbackForm in Google Sheets using 
/// HTTP GET request on Google App Script Web URL and parses response and sends result callback.
class ExpensesController {
  // Callback function to give response of status of current request.
  final void Function(String) callback;

  // Google App Script Web URL.
  static const String URL = "https://script.google.com/macros/s/AKfycbxiIbJ2FhldN71Pf3L1lT0fr5nsA7FkX9yaU6rNZpvNG8mGeW__/exec";
  
  // Success Status Message
  static const STATUS_SUCCESS = "SUCCESS";

  // Default Contructor
  ExpensesController(this.callback);

  /// Async function which saves feedback, parses [feedbackForm] parameters
  /// and sends HTTP GET request on [URL]. On successful response, [callback] is called.
  void submitForm(ExpensesForm feedbackForm) async {
    var expensesURL = URL+feedbackForm.toParams();
    print("expensesURL:"+expensesURL);
    try {
      await http.get(expensesURL).then((response){
        print("Response:"+response.body);
        callback(convert.jsonDecode(response.body)['status']);
      });    
    } catch (e) {
      print(e);
    }
  }
}