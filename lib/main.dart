import 'package:eimarat/eimarat-home.dart';
import 'package:eimarat/screens/sales/sales-entry-home.dart';
import 'package:eimarat/screens/stock/stock-update-home.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
      home: EImaratHome(),
      routes: <String, WidgetBuilder>{
        SalesEntryHome.routeName: (BuildContext context) => SalesEntryHome(),
        StockUpdateHome.routeName: (BuildContext context) => StockUpdateHome(),
      },
    );
  }
}
