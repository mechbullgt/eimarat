import 'package:eimarat/screens/sales/sales-entry-home.dart';
import 'package:eimarat/screens/stock/stock-update-home.dart';
import 'package:flutter/material.dart';

class EImaratHome extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: 3,
        child: new Scaffold(
          appBar: AppBar(
            title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "इमारत",
                    style: TextStyle(
                      fontSize: 60,
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
                  colors: <Color>[Color(0xff2c3e50), Color(0xff3498db)],
                ),
              ),
            ),
            bottom: TabBar(
              tabs: [
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
                        "Balance Sheet",
                        style: TextStyle(fontSize: 18),
                      ),
                    ]))
              ],
            ),
          ),
          body: TabBarView(
            children: [SalesEntryHome(), StockUpdateHome(), SalesEntryHome()],
          ),
        ));
  }
}
