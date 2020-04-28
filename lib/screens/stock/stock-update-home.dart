import 'dart:convert';
import 'dart:math';

import 'package:eimarat/common-calls/common-calls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StockUpdateHome extends StatefulWidget {
  static const String routeName = "/stockhome";

  @override
  _StockUpdateHomeState createState() => new _StockUpdateHomeState();
}

class _StockUpdateHomeState extends State<StockUpdateHome> {
  String routeName = StockUpdateHome.routeName;
  AppBar commonAppBar;

  String selectedClient;
  bool _progressController = true;

  final String stockUpdateURL =
      "https://script.google.com/macros/s/AKfycbxyjnv0aGJiFmCrDt6TQ84TvXGkScrqsKiGtDgMlbXk5DaRSZg/exec";

  Map stockUpdateList = new Map();

  void getStockUpdateList() async {
    var response = await http.get(stockUpdateURL);

    if (response.statusCode == 200) {
      setState(() {
        stockUpdateList = json.decode(response.body);
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
    commonAppBar = CommonCalls().getAppBarForConstruction(
        CommonCalls().getPageNameAsPerRoute(routeName));

    this.getStockUpdateList();
  }

  @override
  Widget build(BuildContext context) {
    final Random randomVariable = Random();

    return new Scaffold(
        appBar: PreferredSize(
            child: commonAppBar, preferredSize: Size.fromHeight(75.0)),
        body: Scrollbar(
            child: new Center(
                child: _progressController
                    ? const CircularProgressIndicator()
                    : new GridView.builder(
                        shrinkWrap: true,
                        itemCount: stockUpdateList.length,
                        itemBuilder: (BuildContext context, int index) {
                          String key =
                              stockUpdateList.keys.toList().elementAt(index);
                          return GridTile(
                              child: Card(
                                  child: ListTile(
                                      leading: ExcludeSemantics(
                                          child: CircleAvatar(
                                              child: new Text(
                                                '${key[0]}',
                                              ),
                                              backgroundColor: Colors.primaries[
                                                  randomVariable.nextInt(Colors
                                                      .primaries.length)])),
                                      title: RichText(
                                          text: TextSpan(children: <TextSpan>[
                                        TextSpan(
                                          text: '$key',
                                          style: TextStyle(fontSize: 18,color: Colors.black),
                                        ),
                                                                                TextSpan(
                                          text: '\n----------\n',
                                          style: TextStyle(fontSize: 18,color: Colors.grey),
                                        ),

                                        TextSpan(
                                          text: stockUpdateList[key]
                                              .toStringAsFixed(0),
                                          style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.black),
                                        )
                                      ])),
                                      )));
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 1.7)))));
  }
}
