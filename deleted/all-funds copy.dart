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
                    : new ListView.builder(
                        shrinkWrap: true,
                        itemCount: fundsList.length,
                        itemBuilder: (BuildContext context, int index) {
                          var key = fundsList.keys.toList().elementAt(index);
                          return ListTile(
                              leading: ExcludeSemantics(
                                  child: CircleAvatar(
                                      child: new Text(
                                        '${key[0]}',
                                      ),
                                      backgroundColor: Colors.primaries[
                                          randomVariable.nextInt(
                                              Colors.primaries.length)])),
                              title: Text(
                                '$key',
                                style: TextStyle(fontSize: 22),
                              ),
                              subtitle: new Text(
                                getFundsInCurrency(key),
                                style: TextStyle(fontSize: 22),
                              ));
                        }))));
  }

  String getFundsInCurrency (var key) {
    var roundOf = double.parse(fundsList[key].toStringAsFixed(2));
    var amount = fundsList[key].toString();
    var currencyAmount1 = "₹ "+amount;
    var currencyAmount2 = "₹ "+roundOf.toString();
  return currencyAmount2;
  }
}
