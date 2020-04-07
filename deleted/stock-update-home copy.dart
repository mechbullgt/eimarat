import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StockUpdateHome extends StatefulWidget {
  static const String routeName = "/stockhome";

  @override
  _StockUpdateHomeState createState() => new _StockUpdateHomeState();
}

class _StockUpdateHomeState extends State<StockUpdateHome> {
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
    this.getStockUpdateList();
  }

  @override
  Widget build(BuildContext context) {
    //_getData();

    return new Scaffold(
        body: Container(
            padding: new EdgeInsets.only(top: 5),
            child: new Container(
                child: _progressController
                    ? const CircularProgressIndicator()
                    : new Column(children: <Widget>[
                        /*Listview diplay rows for different widgets,
                Listview.builder automatically builds its child widgets with a
                template and a list*/
                        new Expanded(
                            child: new ListView.builder(
                                itemCount: stockUpdateList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  String key = stockUpdateList.keys
                                      .toList()
                                      .elementAt(index);
                                  return new Container(
                                      child: new Column(
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          new Row(
                                            children: <Widget>[
                                              new CircleAvatar(
                                                  child: new Text('${key[0]}')),]),
                                              // new Padding(
                                              //     padding: EdgeInsets.only(
                                              //         left: 10)),
                                              // new Flexible(
                                              //     child: 
                                                new Text(
                                                '$key',
                                                style: new TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 25.0),
                                                textAlign: TextAlign.center,
                                              ),]),
                                               new Row (children : <Widget>[
                                                 new Text(
                                                stockUpdateList[key]
                                                    .toStringAsFixed(0),
                                                style: new TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 25.0),
                                                textAlign: TextAlign.right,
                                              ),
                                             
                                      new Column(children: <Widget>[
                                        new Row(
                                          children: <Widget>[
                                            new Row(
                                              children: <Widget>[],
                                            )
                                          ],
                                        )
                                      ]),
                                    ],
                                  )]));
                                }))
                      ]))));
  }
}
