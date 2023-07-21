import 'package:eimarat/screens/collections/fund-collections.dart';
import 'package:eimarat/screens/expenses/expenses-entry-home.dart';
import 'package:eimarat/screens/demo/demo-home.dart';
import 'package:eimarat/screens/funds/all-funds.dart';
import 'package:eimarat/screens/home/cons-home.dart';
import 'package:eimarat/screens/sales/sales-entry-home.dart';
import 'package:eimarat/screens/transactions/transactions-home.dart';
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Image.asset(
                    'assets/images/logo1.png',
                    fit: BoxFit.fitWidth,
                  ),
                  Padding(padding: EdgeInsets.only(top: 5)),
                ]),
            centerTitle: false,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[Colors.blue, Colors.indigo, Colors.teal],
                ),
              ),
            ),
            bottom: new PreferredSize(
                preferredSize: new Size(0.0, 80.0),
                child: new Container(
                  height: 80.0,
                  child: new TabBar(
                    isScrollable: true,
                    tabs: [
                      Tab(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.message),
                              SizedBox(
                                height: 4.0,
                              ),
                              Text(
                                "Demo",
                                style: TextStyle(fontSize: 18),
                              ),
                            ]),
                      ),
                      Tab(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.message),
                              SizedBox(
                                height: 4.0,
                              ),
                              Text(
                                "Transactions",
                                style: TextStyle(fontSize: 18),
                              ),
                            ]),
                      ),
                      Tab(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.store),
                              SizedBox(
                                height: 4.0,
                              ),
                              Text(
                                "Store",
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
                                "Insights",
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
                                "Utilities",
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
                    ],
                  ),
                )),
          ),
          body: TabBarView(
            physics: BouncingScrollPhysics(),
            children: [
              DemoHome(),
              TransactionsHome(),
              ConsHome(),
              SalesEntryHome(),
              FundsCollection(),
              FundsHome(),
            ],
          ),
        ));
  }
}
