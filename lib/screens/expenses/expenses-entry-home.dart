import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:eimarat/common-calls/common-calls.dart';
import 'package:eimarat/controller/expenses-form_controller.dart';
import 'package:eimarat/model/expenses-form.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpensesEntryHome extends StatefulWidget {
  static const String routeName = "/exhome";

  @override
  _ExpensesEntryHomeState createState() => new _ExpensesEntryHomeState();
}

class _ExpensesEntryHomeState extends State<ExpensesEntryHome> {
  String routeName = ExpensesEntryHome.routeName;
  AppBar commonAppBar;

  // String selectedClient;
  String selectedPayMode;

  // final String clientListURL =
  //     "https://script.google.com/macros/s/AKfycbyIaIR_Ix2KsuX6eYrn3EtywbHwmvn1IAYI3BkhoGK5lTTflrkB/exec";
  // final String productsListURL =
  //     "https://script.google.com/macros/s/AKfycbybYyrjOjw0tPGVcSbqMjKgvoXMHoiyYIeb3YQDp_KK1b4sfFw/exec";

  // List dataClientsList = List();
  List dataPayModes = ['Cash', 'Bank'];

  // Future<String> getClientsList() async {
  //   var res = await http.get(Uri.encodeFull(clientListURL),
  //       headers: {"Accept": "application/json"});

  //   Map<String, dynamic> resBody = json.decode(res.body);
  //   setState(() {
  //     dataClientsList = resBody['clientNamesAPI'];
  //   });
  //   return "Success";
  // }

  // Future<String> getProductsList() async {
  //   var res = await http.get(Uri.encodeFull(productsListURL),
  //       headers: {"Accept": "application/json"});

  //   Map<String, dynamic> resBody = json.decode(res.body);
  //   setState(() {
  //     dataPayModes = resBody['productsListAPI'];
  //   });
  //   return "Success";
  // }

  @override
  void initState() {
    super.initState();
    commonAppBar = CommonCalls().getAppBarForConstruction(
        CommonCalls().getPageNameAsPerRoute(routeName));
  }

  final FocusNode _purposeNode = FocusNode();
  final FocusNode _payModeNode = FocusNode();
  final FocusNode _amountNode = FocusNode();
  final FocusNode _remarksNode = FocusNode();

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
  TextEditingController purposeController = TextEditingController();
  TextEditingController payModeController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController remarksController = TextEditingController();

  // Method to Submit Feedback and save it in Google Sheets
  void _submitForm() {
    // Validate returns true if the form is valid, or false
    // otherwise.
    if (_formKey.currentState.validate()) {
      // If the form is valid, proceed.
      ExpensesForm feedbackForm = ExpensesForm(
          dateController.text,
          purposeController.text,
          payModeController.text,
          amountController.text,
          remarksController.text);

      ExpensesController formController = ExpensesController((String response) {
        print("Response: $response");
        if (response == ExpensesController.STATUS_SUCCESS) {
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
          child: commonAppBar, preferredSize: Size.fromHeight(75.0)),

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
                          'Expenses Entry',
                          style: TextStyle(fontSize: 22),
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
                          labelText: 'Expenses Date (MM/DD/YYYY)',
                          hasFloatingPlaceholder: false,
                          icon: const Icon(Icons.date_range),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (dt) {
                          setState(() => date2 = dt);
                          print('Selected date: $date2');
                        },
                        autofocus: false,
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        controller: purposeController,
                        focusNode: _purposeNode,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter Valid Purpose';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            icon: const Icon(Icons.assignment),
                            labelText: 'Add Expense Purpose',
                            border: OutlineInputBorder()),
                        autofocus: false,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (term) {
                          _fieldFocusChange(
                              context, _purposeNode, _payModeNode);
                        },
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      new FormField(
                        builder: (FormFieldState state) {
                          return InputDecorator(
                              decoration: InputDecoration(
                                icon: const Icon(Icons.account_balance_wallet),
                                labelText: 'Expense/Pay Mode',
                                border: OutlineInputBorder(),
                              ),
                              child: new DropdownButtonHideUnderline(
                                child: new DropdownButton(
                                  hint: new Text("Select Pay Mode"),
                                  items: dataPayModes.map((item) {
                                    return new DropdownMenuItem(
                                      child: new Text(item),
                                      value: item.toString(),
                                    );
                                  }).toList(),
                                  autofocus: false,
                                  onChanged: (newVal) {
                                    setState(() {
                                      payModeController.text = newVal;
                                      selectedPayMode = newVal;
                                    });
                                  },
                                  value: selectedPayMode,
                                ),
                              ));
                        },
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        controller: amountController,
                        focusNode: _amountNode,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter Valid Amount';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            icon: const Icon(Icons.attach_money),
                            labelText: 'Amount',
                            border: OutlineInputBorder()),
                        autofocus: false,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (term) {
                          _fieldFocusChange(context, _amountNode, _remarksNode);
                        },
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        controller: remarksController,
                        focusNode: _remarksNode,
                        // validator: (value) {
                        //   if (value.isEmpty) {
                        //     return 'Enter Valid Feedback';
                        //   }
                        //   return null;
                        // },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            icon: const Icon(Icons.comment),
                            labelText: 'Remarks',
                            border: OutlineInputBorder()),
                        autofocus: false,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (term) {
                          _remarksNode.unfocus();
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
                    purposeController.clear();
                    payModeController.clear();
                    amountController.clear();
                    remarksController.clear();
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
                    'Submit Expenses Entry',
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
