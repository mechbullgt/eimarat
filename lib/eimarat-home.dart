import 'package:eimarat/screens/collections/fund-collections.dart';
import 'package:eimarat/screens/expenses/expenses-entry-home.dart';
import 'package:eimarat/screens/funds/all-funds.dart';
import 'package:eimarat/screens/home/cons-home.dart';
import 'package:eimarat/screens/sales/sales-entry-home.dart';
import 'package:flutter/material.dart';

class EImaratHome extends StatelessWidget {
  static const String routeName = "/supplieshome";
  final String titleText = "e-Imarat";
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
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Image.asset(
                    'assets/images/logo1.png',
                    fit: BoxFit.fitWidth,
                  ),
                  Padding(padding: EdgeInsets.only(top: 5)),
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
                          "Construction",
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
                          "Plumbing",
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
                          "all/Funds",
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
                          "all/Collections",
                          style: TextStyle(fontSize: 18),
                        ),
                      ]),
                ),
              ],
            ),
          ),
          body: TabBarView(
            physics: BouncingScrollPhysics(),
            children: [
              ConsHome(),
              SalesEntryHome(),
              FundsCollection(),
              FundsHome(),
            ],
          ),
        ));
  }
}
