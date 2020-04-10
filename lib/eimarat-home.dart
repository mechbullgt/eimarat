import 'package:eimarat/screens/funds/expenses-entry-home.dart';
import 'package:eimarat/screens/sales/sales-entry-home.dart';
import 'package:eimarat/screens/stock/stock-update-home.dart';
import 'package:flutter/material.dart';

class EImaratHome extends StatelessWidget {
  final String titleText="e-Imarat";
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: 4,
        child: new Scaffold(
          appBar: AppBar(
            title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    titleText,
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Raleway',
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
                  colors: <Color>[Color(0xff9706f0), Color(0xfffac0d8)],
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
                          "इ",
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
              SalesEntryHome(),
              SalesEntryHome(),
              StockUpdateHome(),
              ExpensesEntryHome()
            ],
          ),
        ));
  }
}
