import 'dart:convert';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'controller/form_controller.dart';
import 'model/form.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'e-Imarat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'e-Imarat'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dateTimeNow = DateFormat("EEE, MMM d, ''yy").format(DateTime.now());

  final dateFormat = DateFormat("EEEE, MMMM d, yyyy 'at' h:mma");
  final timeFormat = DateFormat("h:mm a");
  DateTime date;
  TimeOfDay time;

  String _value = '';

  Future _selectDate() async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2020),
        lastDate: new DateTime(2022));
    if (picked != null) setState(() => _value = picked.toString());
  }

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // TextField Controllers
  TextEditingController dateController = TextEditingController();
  TextEditingController clientNameController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController bundlePieceController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController transHamaliController = TextEditingController();

  // Method to Submit Feedback and save it in Google Sheets
  void _submitForm() {
    // Validate returns true if the form is valid, or false
    // otherwise.
    if (_formKey.currentState.validate()) {
      // If the form is valid, proceed.
      FeedbackForm feedbackForm = FeedbackForm(
          dateController.text,
          clientNameController.text,
          productNameController.text,
          quantityController.text,
          bundlePieceController.text,
          rateController.text,
          transHamaliController.text);

      FormController formController = FormController((String response) {
        print("Response: $response");
        if (response == FormController.STATUS_SUCCESS) {
          // Feedback is saved succesfully in Google Sheets.
          _showSnackbar(
              "Submitted SUCCESSfully!", Colors.green, Duration(seconds: 30));
        } else {
          // Error Occurred while saving data in Google Sheets.
          _showSnackbar("Error Occurred!", Colors.red, Duration(seconds: 3));
        }
      });

      _showSnackbar("Submitting Feedback", Colors.blue, Duration(seconds: 2));

      // Submit 'feedbackForm' and save it in Google Sheets.
      formController.submitForm(feedbackForm);
    }
  }

  // Method to show snackbar with 'message'.
  _showSnackbar(String message, Color color, Duration time) {
    final snackBar = SnackBar(
      content: Text(message, style: TextStyle(fontSize: 20)),
      backgroundColor: color,
      duration: time,
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Sales Entry',
                        style: TextStyle(fontSize: 22),
                      ),
                      Expanded(
                        child: Divider(),
                      ),
                      Text(
                        '$dateTimeNow',
                        style: TextStyle(fontSize: 22),
                      ),
                    ],
                  )),
            ),
            Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(_value),
                      new RaisedButton(
                        onPressed: _selectDate,
                        child: new Text('Click me'),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      // DateTimePickerFormField(
                      //   format: dateFormat,
                      //   decoration: InputDecoration(labelText: 'Date'),
                      //   onChanged: (dt) => setState(() => date = dt),
                      // ),
                      // SizedBox(height: 16.0),
                      // Text('date.toString(): $date',
                      //     style: TextStyle(fontSize: 18.0)),
                      TextFormField(
                        // controller: dateController,
                        controller: dateController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter Valid Date';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          labelText: 'Sales Date (MM/DD/YYYY)',
                          border: OutlineInputBorder(),
                        ),
                        autofocus: false,
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        controller: clientNameController,
                        // validator: (value) {
                        //   if (!value.contains("@")) {
                        //     return 'Enter Valid Email';
                        //   }
                        //   return null;
                        // },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            labelText: 'Client Name',
                            border: OutlineInputBorder(),
                            hintText: 'Select Client Name'),
                        autofocus: false,
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        controller: productNameController,
                        // validator: (value) {
                        //   if (value.trim().length != 10) {
                        //     return 'Enter 10 Digit Mobile Number';
                        //   }
                        //   return null;
                        // },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            labelText: 'Product Name',
                            border: OutlineInputBorder()),
                        autofocus: false,
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        controller: quantityController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter Valid Quantity';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: 'Quantity',
                            border: OutlineInputBorder()),
                        autofocus: false,
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        controller: bundlePieceController,
                        // validator: (value) {
                        //   if (value.isEmpty) {
                        //     return 'Enter Valid Feedback';
                        //   }
                        //   return null;
                        // },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            labelText: 'Bundle / Piece',
                            border: OutlineInputBorder()),
                        autofocus: false,
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        controller: rateController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter Valid Rate';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Rate',
                          border: OutlineInputBorder(),
                        ),
                        autofocus: false,
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        controller: transHamaliController,
                        // validator: (value) {
                        //   if (value.isEmpty) {
                        //     return 'Enter Valid Feedback';
                        //   }
                        //   return null;
                        // },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Transportation Charge',
                          border: OutlineInputBorder(),
                        ),
                        autofocus: false,
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                    ],
                  ),
                )),
            RaisedButton(
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(15.0)),
              textColor: Colors.white,
              onPressed: _submitForm,
              child: Text(
                'Submit Sales Entry',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
