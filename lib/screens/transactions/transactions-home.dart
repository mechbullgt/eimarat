import 'dart:convert';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:eimarat/common-calls/common-calls.dart';
import 'package:eimarat/controller/sales-form_controller.dart';
import 'package:eimarat/model/sales-form.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class TransactionsHome extends StatefulWidget {
  static const String routeName = "/shome";

  @override
  _TransactionsHomeState createState() => new _TransactionsHomeState();
}

class _TransactionsHomeState extends State<TransactionsHome> {
  String routeName = TransactionsHome.routeName;
  AppBar commonAppBar;

  String selectedTransactionType;
  String selectedProduct;

  final String transactionTypeListURL =
      "https://script.google.com/macros/s/AKfycbxeikis3XBiWCqdSVGHxlaQfiPL13AUxB8DhUPklXrN2XMop4Bspm-vCsrH2MH-FhhEoQ/exec";

  final String productsListURL =
      "https://script.google.com/macros/s/AKfycbybYyrjOjw0tPGVcSbqMjKgvoXMHoiyYIeb3YQDp_KK1b4sfFw/exec";

  List dataTransactionsTypeList = List();
  List dataProductsList = List();

  Future<String> getTransactionsTypeList() async {
    var res = await http.get(Uri.encodeFull(transactionTypeListURL),
        headers: {"Accept": "application/json"});
    // print('getTransactionsTypeList()');
    // print(res.body);
    Map<String, dynamic> resBody = json.decode(res.body);
    setState(() {
      dataTransactionsTypeList = resBody['transactionTypeListAPI'];
      print(dataTransactionsTypeList);
    });
    return "Success";
  }

  Future<String> getProductsList() async {
    var res = await http.get(Uri.encodeFull(productsListURL),
        headers: {"Accept": "application/json"});

    Map<String, dynamic> resBody = json.decode(res.body);
    setState(() {
      dataProductsList = resBody['productsListAPI'];
    });
    return "Success";
  }

  @override
  void initState() {
    super.initState();
    commonAppBar = CommonCalls()
        .getBlankAppBar(CommonCalls().getPageNameAsPerRoute(routeName));

    this.getTransactionsTypeList();
    this.getProductsList();
  }

  final FocusNode _quantityFocus = FocusNode();
  final FocusNode _bundlePieceFocus = FocusNode();
  final FocusNode _rateFocus = FocusNode();
  final FocusNode _transFocus = FocusNode();

  String dateTimeNow = DateFormat("EEE, MMM d, ''yy").format(DateTime.now());

//  DateTime dateTimeNow2 = DateTime.parse(DateFormat("dd-MM-yyyy").format(DateTime.now()));

  // For date picker
  DateTime date1;
  DateTime date2;
  DateTime date3;

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
      appBar: PreferredSize(
          child: commonAppBar, preferredSize: Size.fromHeight(0.0)),

      key: _scaffoldKey,
      // resizeToAvoidBottomPadding: false,
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      OutlineButton(
                        child: Text(
                          'Transactions Update ',
                          style: TextStyle(fontSize: 12),
                        ),
                        onPressed: () {},
                        shape: StadiumBorder(),
                        borderSide: BorderSide(
                            color: Colors.blue,
                            style: BorderStyle.solid,
                            width: 1),
                        textColor: Colors.black,
                      ),
                      Expanded(child: Container()),
                      OutlineButton(
                        shape: StadiumBorder(),
                        textColor: Colors.black,
                        child: Text(
                          '$dateTimeNow',
                          style: TextStyle(fontSize: 20),
                        ),
                        borderSide: BorderSide(
                            color: Colors.blue,
                            style: BorderStyle.solid,
                            width: 1),
                        onPressed: () {},
                      )
                    ],
                  )),
            ),
            Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 5, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      DateTimePickerFormField(
                        controller: dateController,
                        inputType: InputType.date,
                        format: DateFormat("MM/dd/yyyy"),
                        initialDate: DateTime.now(),
                        editable: false,
                        decoration: InputDecoration(
                          labelText: 'Sales Date (MM/DD/YYYY)',
                          hasFloatingPlaceholder: false,
                          icon: const Icon(Icons.date_range),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (dt) {
                          setState(() => date2 = dt);
                          print('Selected date: $date2');
                        },
                      ),
                      SizedBox(height: 10.0),
                      new FormField(
                        builder: (FormFieldState state) {
                          return InputDecorator(
                              decoration: InputDecoration(
                                icon: const Icon(Icons.account_circle),
                                labelText: 'Transaction Type',
                                border: OutlineInputBorder(),
                              ),
                              child: new DropdownButtonHideUnderline(
                                child: new DropdownButton(
                                  hint: new Text("Select Transaction"),
                                  items: dataTransactionsTypeList.map((item) {
                                    return new DropdownMenuItem(
                                      child: new Text(item),
                                      value: item.toString(),
                                    );
                                  }).toList(),
                                  autofocus: false,
                                  onChanged: (newVal) {
                                    setState(() {
                                      clientNameController.text = newVal;
                                      selectedTransactionType = newVal;
                                    });
                                  },
                                  value: selectedTransactionType,
                                ),
                              ));
                        },
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      new FormField(
                        builder: (FormFieldState state) {
                          return InputDecorator(
                              decoration: InputDecoration(
                                icon: const Icon(Icons.shopping_cart),
                                labelText: 'Product Name',
                                border: OutlineInputBorder(),
                              ),
                              child: new DropdownButtonHideUnderline(
                                child: new DropdownButton(
                                  hint: new Text("Select Product"),
                                  items: dataProductsList.map((item) {
                                    return new DropdownMenuItem(
                                      child: new Text(item),
                                      value: item.toString(),
                                    );
                                  }).toList(),
                                  autofocus: false,
                                  onChanged: (newVal) {
                                    setState(() {
                                      productNameController.text = newVal;
                                      selectedProduct = newVal;
                                    });
                                  },
                                  value: selectedProduct,
                                ),
                              ));
                        },
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        controller: quantityController,
                        focusNode: _quantityFocus,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter Valid Quantity';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            icon: const Icon(Icons.code),
                            labelText: 'Quantity',
                            border: OutlineInputBorder()),
                        autofocus: false,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (term) {
                          _fieldFocusChange(
                              context, _quantityFocus, _bundlePieceFocus);
                        },
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        controller: bundlePieceController,
                        focusNode: _bundlePieceFocus,
                        // validator: (value) {
                        //   if (value.isEmpty) {
                        //     return 'Enter Valid Feedback';
                        //   }
                        //   return null;
                        // },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            icon: const Icon(Icons.plus_one),
                            labelText: 'Bundle / Piece',
                            border: OutlineInputBorder()),
                        autofocus: false,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (term) {
                          _fieldFocusChange(
                              context, _bundlePieceFocus, _rateFocus);
                        },
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        controller: rateController,
                        focusNode: _rateFocus,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter Valid Rate';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.attach_money),
                          labelText: 'Rate',
                          border: OutlineInputBorder(),
                        ),
                        autofocus: false,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (term) {
                          _fieldFocusChange(context, _rateFocus, _transFocus);
                        },
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        controller: transHamaliController,
                        focusNode: _transFocus,
                        // validator: (value) {
                        //   if (value.isEmpty) {
                        //     return 'Enter Valid Feedback';
                        //   }
                        //   return null;
                        // },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.directions_car),
                          labelText: 'Transportation Charge',
                          border: OutlineInputBorder(),
                        ),
                        autofocus: false,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (term) {
                          _transFocus.unfocus();
                        },
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                    ],
                  ),
                )),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  color: Colors.red.shade400,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15.0)),
                  textColor: Colors.white,
                  onPressed: () {
                    _formKey.currentState.reset();
                    dateController.clear();
                    selectedTransactionType = null;
                    selectedProduct = null;
                    quantityController.clear();
                    bundlePieceController.clear();
                    rateController.clear();
                    transHamaliController.clear();
                  },
                  child: Text(
                    'Clear Previous Data',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                RaisedButton(
                  color: Colors.green.shade400,
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
            )
          ],
        ),
      ),
    );
  }
}

_fieldFocusChange(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}
