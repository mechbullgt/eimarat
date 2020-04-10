import 'package:eimarat/eimarat-home.dart';
import 'package:eimarat/screens/funds/all-funds.dart';
import 'package:eimarat/screens/funds/expenses-entry-home.dart';
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
          routes: <String, WidgetBuilder>{
            FundsHome.routeName: (BuildContext context) => FundsHome(),
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
