import 'package:eimarat/eimarat-home.dart';
import 'package:eimarat/imarat-root-home.dart';
import 'package:eimarat/screens/collections/fund-collections.dart';
import 'package:eimarat/screens/expenses/expenses-entry-home.dart';
import 'package:eimarat/screens/funds/all-funds.dart';
import 'package:eimarat/screens/home/cons-home.dart';
import 'package:eimarat/screens/sales/sales-entry-home.dart';
import 'package:eimarat/screens/stock/stock-update-home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled = false;
    return new GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: EImaratHome(),
          // home: ImaratRootHome(),
          routes: <String, WidgetBuilder>{
            ConsHome.routeName:(BuildContext contect)=>ConsHome(),
            EImaratHome.routeName:(BuildContext context)=>EImaratHome(),
            FundsHome.routeName: (BuildContext context) => FundsHome(),
            FundsCollection.routeName:(BuildContext context)=> FundsCollection(),
            SalesEntryHome.routeName: (BuildContext context) =>
                SalesEntryHome(),
            StockUpdateHome.routeName: (BuildContext context) =>
                StockUpdateHome(),
            ExpensesEntryHome.routeName: (BuildContext context) =>
                ExpensesEntryHome(),
          },
        ));
  }
}
