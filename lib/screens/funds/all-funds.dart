import 'dart:convert';
import 'package:eimarat/common-calls/common-calls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pie_chart/pie_chart.dart';

class FundsHome extends StatefulWidget {
  static const String routeName = "/fundshome";

  @override
  _FundsHomeState createState() => new _FundsHomeState();
}

class _FundsHomeState extends State<FundsHome> {
  String routeName = FundsHome.routeName;
  AppBar commonAppBar;

  bool _progressController = true;
  bool toggle = false;

  final Color cashInBank = Color(0xff3498db);
  final Color cashInHand = Color(0xff2ecc71);
  final Color cashPending = Color(0xffe74c3c);

  Map<String, double> dataMap = Map();
  // List<Color> colorList = [
  //   Colors.blue.shade700,
  //   Colors.green.shade500,
  //   Colors.red.shade700,
  // ];

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
      // print('runtimeType');
      // print((fundsList['Cash']).runtimeType);
      dataMap.putIfAbsent("Cash", () => (fundsList['Cash'] * -1));
      dataMap.putIfAbsent("Bank", () => (fundsList['Bank']));
      dataMap.putIfAbsent("Collection", () => (fundsList['Bank']));
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
    commonAppBar = CommonCalls().getAppBarForConstruction(
        CommonCalls().getPageNameAsPerRoute(routeName));

    this.getFundsList();
  }

  @override
  Widget build(BuildContext context) {
    double cardIconSize = 42;
    return new Scaffold(
      appBar: PreferredSize(child:commonAppBar , preferredSize: Size.fromHeight(75.0)),
        body: Scrollbar(
            child: new Padding(
                            padding: EdgeInsets.fromLTRB(5, 5, 5, 0),

      child: _progressController
          ? const CircularProgressIndicator()
          : new SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Card(
                      elevation: 5,
                      child: Container(
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                          child: Column(children: <Widget>[
                            Container(
                              child: Stack(
                                overflow: Overflow.visible,
                                children: <Widget>[
                                  Card(
                                      child: Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(10, 10, 10, 15),
                                    child: PieChart(
                                      dataMap: dataMap,
                                      animationDuration:
                                          Duration(milliseconds: 800),
                                      chartLegendSpacing: 32.0,
                                      chartRadius:
                                          MediaQuery.of(context).size.width /
                                              1.4,
                                      showChartValuesInPercentage: true,
                                      showChartValues: false,
                                      showChartValuesOutside: true,
                                      chartValueBackgroundColor:
                                          Colors.grey[200],
                                      colorList: [
                                        cashInHand,
                                        cashInBank,
                                        cashPending
                                      ],
                                      showLegends: false,
                                      legendPosition: LegendPosition.bottom,
                                      decimalPlaces: 1,
                                      showChartValueLabel: true,
                                      initialAngle: 0,
                                      chartValueStyle:
                                          defaultChartValueStyle.copyWith(
                                        color: Colors.blueGrey[900]
                                            .withOpacity(0.9),
                                      ),
                                      chartType: ChartType.ring,
                                    ),
                                  )),
                                  Positioned.fill(
                                      child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      getTotalValue(),
                                      style: TextStyle(
                                          fontSize: 50.0,
                                          color: Colors.green.shade800,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ))
                                ],
                              ),
                            ),
                            Card(
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    color: cashInHand,
                                    elevation: 3,
                                    child: Column(
                                      children: <Widget>[
                                        new ListTile(
                                          leading: Icon(Icons.offline_bolt,
                                              size: cardIconSize),
                                          title: Text('Cash In Hand',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 22)),
                                          trailing: Text(getCashValue(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 22)),
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                            Card(
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    color: cashInBank,
                                    elevation: 10,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new ListTile(
                                          leading: Icon(Icons.domain,
                                              size: cardIconSize),
                                          title: Text('Cash In Bank',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 22)),
                                          trailing: Text(getBankValue(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 22)),
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                            Card(
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    color: cashPending,
                                    elevation: 10,
                                    child: Column(
                                      children: <Widget>[
                                        new ListTile(
                                          leading: Icon(Icons.do_not_disturb_on,
                                              size: cardIconSize),
                                          title: Text('Pending Collection',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 22)),
                                          trailing: Text(getBankValue(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 22)),
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                            Card(
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    color: Color(0xff16a085),
                                    elevation: 10,
                                    child: Column(
                                      children: <Widget>[
                                        new ListTile(
                                          leading: Icon(Icons.donut_large,
                                              size: cardIconSize),
                                          title: Text('Total Funds',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 22)),
                                          trailing: Text(getTotalValue(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 22)),
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
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
    var currencyAmount = "₹ " + roundOf.toString();
    return currencyAmount;
  }

  void togglePieChart() {
    setState(() {
      toggle = !toggle;
    });
  }

  String getCashValue() {
    return (getFundsInCurrency(fundsList['Cash'] * -1));
  }

  String getBankValue() {
    return getFundsInCurrency(fundsList['Bank']);
  }

  String getTotalValue() {
    return getFundsInCurrency(fundsList['Total']);
  }
}
