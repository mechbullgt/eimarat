import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class StockUpdateHome extends StatefulWidget {
  static const String routeName = "/stockhome";

  @override
  _StockUpdateHomeState createState() => new _StockUpdateHomeState();
  }
  
  class _StockUpdateHomeState extends State<StockUpdateHome>{
  String selectedClient;

  final String stockUpdateURL =
      "https://script.google.com/macros/s/AKfycbxyjnv0aGJiFmCrDt6TQ84TvXGkScrqsKiGtDgMlbXk5DaRSZg/exec";

  Map stockUpdateList = new Map();

  void getStockUpdateList() async {
    var response = await http.get(stockUpdateURL);

    if(response.statusCode == 200) {
      setState(() => stockUpdateList = json.decode(response.body));
      // print('Loaded ${stockUpdateList.length} countries');
      // print(stockUpdateList);
      // print(stockUpdateList.keys.toList());
      // print(stockUpdateList.keys.runtimeType);
      // print(stockUpdateList.values.toList());
    } else{
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
      body: new Container(
          padding: new EdgeInsets.all(32.0),
          child: new Center(
            child: new Column(
              children: <Widget>[
                /*Listview diplay rows for different widgets,
                Listview.builder automatically builds its child widgets with a
                template and a list*/
                new Expanded(child: new ListView.builder(
                  itemCount: stockUpdateList.length,
                  itemBuilder: (BuildContext context, int index){
                    String key = stockUpdateList.keys.toList().elementAt(index);
                    return new Row(
                      children: <Widget>[
                        new Text('${key} : '),
                        new Text(stockUpdateList[key].toString())
                      ],
                    );
                  },

                ))

              ],
            ),
          )
      ),
    );
  }
  }