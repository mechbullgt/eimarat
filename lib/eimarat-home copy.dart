import 'package:eimarat/screens/collections/fund-collections.dart';
import 'package:eimarat/screens/expenses/expenses-entry-home.dart';
import 'package:eimarat/screens/funds/all-funds.dart';
import 'package:eimarat/screens/home/cons-home.dart';
import 'package:eimarat/screens/sales/sales-entry-home.dart';
import 'package:eimarat/screens/stock/stock-update-home.dart';
import 'package:flutter/material.dart';

class EImaratHome extends StatelessWidget {
  static const String routeName = "/supplieshome";
  final String titleText = "e-Imarat";
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: 6,
        child: new Scaffold(
          appBar: AppBar(
            title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    titleText,
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ]),
            centerTitle: true,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[Colors.blue, Colors.indigo, Colors.teal],
                ),
              ),
            ),
            bottom: TabBar(
              isScrollable: true,
              tabs: [
                                Tab(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Root",
                          style: TextStyle(fontSize: 18),
                        ),
                      ]),
                ),

                Tab(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Collections",
                          style: TextStyle(fontSize: 18),
                        ),
                      ]),
                ),
                Tab(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Funds",
                          style: TextStyle(fontSize: 18),
                        ),
                      ]),
                ),
                Tab(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Sales Entry",
                          style: TextStyle(fontSize: 18),
                        ),
                      ]),
                ),
                Tab(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      Text(
                        "Stock Update",
                        style: TextStyle(fontSize: 18),
                      ),
                    ])),
                Tab(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      Text(
                        "Expenses Entry",
                        style: TextStyle(fontSize: 18),
                      ),
                    ]))
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ConsHome(),
              FundsCollection(),
              FundsHome(),
              SalesEntryHome(),
              StockUpdateHome(),
              ExpensesEntryHome()
            ],
          ),
        ));
  }
}
