import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pie_chart/pie_chart.dart';

class FundsHome extends StatefulWidget {
  static const String routeName = "/fundshome";

  @override
  _FundsHomeState createState() => new _FundsHomeState();
}

class _FundsHomeState extends State<FundsHome> {
  bool _progressController = true;
  bool toggle = false;
  Map<String, double> dataMap = Map();
  List<Color> colorList = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
  ];

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
      print('runtimeType');
      print((fundsList['Cash']).runtimeType);
      dataMap.putIfAbsent("Cash", () => (fundsList['Cash'] * -1));
      dataMap.putIfAbsent("Bank", () => (fundsList['Bank']));
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
    return new Scaffold(
        body: Scrollbar(
            child: new Center(
      child: _progressController
          ? const CircularProgressIndicator()
          : new Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              // height: double.infinity,
              // width: double.maxFinite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Card(
                      elevation: 5,
                      child: Container(
                          padding: EdgeInsets.fromLTRB(5,5,5, 0),
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(width: 2.0, color: Colors.green),
                            ),
                            color: Colors.white,
                          ),
                          child: Column(children: <Widget>[
                            Card(
                                child: PieChart(
                              dataMap: dataMap,
                              animationDuration: Duration(milliseconds: 800),
                              chartLegendSpacing: 32.0,
                              chartRadius:
                                  MediaQuery.of(context).size.width / 2.7,
                              showChartValuesInPercentage: true,
                              showChartValues: true,
                              showChartValuesOutside: false,
                              chartValueBackgroundColor: Colors.grey[200],
                              colorList: colorList,
                              showLegends: true,
                              legendPosition: LegendPosition.bottom,
                              decimalPlaces: 1,
                              showChartValueLabel: true,
                              initialAngle: 0,
                              chartValueStyle: defaultChartValueStyle.copyWith(
                                color: Colors.blueGrey[900].withOpacity(0.9),
                              ),
                              chartType: ChartType.ring,
                            )
                                ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: Colors.pink,
                              elevation: 10,
                              child: Column(
                                // mainAxisSize:
                                //     MainAxisSize.min,
                                children: <Widget>[
                                  new ListTile(
                                    leading: Icon(Icons.people, size: 50),
                                    title: Text('Total Cash + Bank',
                                        style: TextStyle(color: Colors.white)),
                                    subtitle: Text(getTotalValue(),
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ],
                              ),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: Colors.pink,
                              elevation: 10,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new ListTile(
                                    leading: Icon(Icons.album, size: 70),
                                    title: Text('Cash In Hand',
                                        style: TextStyle(color: Colors.white)),
                                    subtitle: Text(getCashValue(),
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ],
                              ),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: Colors.pink,
                              elevation: 10,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new ListTile(
                                    leading: Icon(Icons.album, size: 70),
                                    title: Text('Cash In Bank',
                                        style: TextStyle(color: Colors.white)),
                                    subtitle: Text(getBankValue(),
                                        style: TextStyle(color: Colors.white)),
                                  )
                                ],
                              ),
                            )
                          ])))
                ],
              ),
            ),
    ))

        // floatingActionButton: FloatingActionButton(
        //   onPressed: togglePieChart,
        //   child: Icon(Icons.insert_chart),
        // ),
        );
  }

  String getFundsInCurrency(var key) {
    var roundOf = double.parse(key.toStringAsFixed(2));
    var amount = fundsList[key].toString();
    var currencyAmount1 = "₹ " + amount;
    var currencyAmount2 = "₹ " + roundOf.toString();
    return currencyAmount2;
  }

  void togglePieChart() {
    setState(() {
      toggle = !toggle;
    });
  }

  String getCashValue() {
    return getFundsInCurrency(fundsList['Cash']);
  }

  String getBankValue() {
    return getFundsInCurrency(fundsList['Bank']);
  }

  String getTotalValue() {
    return getFundsInCurrency(fundsList['Total']);
  }
}
