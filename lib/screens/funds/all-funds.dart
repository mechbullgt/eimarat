import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FundsHome extends StatefulWidget {
  static const String routeName = "/fundshome";

  @override
  _FundsHomeState createState() => new _FundsHomeState();
}

class _FundsHomeState extends State<FundsHome> {
  bool _progressController = true;

  final String fundsURL =
      "https://script.google.com/macros/s/AKfycby71t6M6u6AGJ7RwYaDGVCRS4fH9PktvFGQjWDkm1mby97hIQlw/exec";

  Map fundsList = new Map();

  void getFundsList() async {
    var response = await http.get(fundsURL);

    if (response.statusCode == 200) {
      setState(() {
        fundsList = json.decode(response.body);
        _progressController = false;
      });
      // Future.delayed(const Duration(seconds: 10), () {
      //   setState(() {
      //     stockUpdateList = json.decode(response.body);
      //     _progressController = false;
      //   });
      // });

      // print('Loaded ${stockUpdateList.length} countries');
      // print(stockUpdateList);
      // print(stockUpdateList.keys.toList());
      // print(stockUpdateList.keys.runtimeType);
      // print(stockUpdateList.values.toList());
    } else {
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    super.initState();
    this.getFundsList();
  }

  @override
  Widget build(BuildContext context) {
    final Random randomVariable = Random();

    return new Scaffold(
        body: Scrollbar(
            child: new Center(
                child: _progressController
                    ? const CircularProgressIndicator()
                    : new Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        height: 300,
                        width: double.maxFinite,
                        child: Card(
                            elevation: 5,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                      width: 2.0, color: Colors.green),
                                ),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(7),
                                child: Stack(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 5),
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            fundsList['Total'].toString(),
                                            style: TextStyle(fontSize: 22),
                                          ),
                                          Text(
                                            fundsList['Cash'].toString(),
                                            style: TextStyle(fontSize: 22),
                                          ),
                                                                                    Text(
                                            fundsList['Bank'].toString(),
                                            style: TextStyle(fontSize: 22),
                                          )

                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ))))));
  }

  // String getFundsInCurrency(var key) {
  //   var roundOf = double.parse(key.toStringAsFixed(2));
  //   var amount = fundsList[key].toString();
  //   var currencyAmount1 = "₹ " + amount;
  //   var currencyAmount2 = "₹ " + roundOf.toString();
  //   return currencyAmount2;
  // }
}
