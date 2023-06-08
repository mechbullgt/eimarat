import 'package:eimarat/common-calls/common-calls.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConsHome extends StatefulWidget {
  CommonCalls commonCalls = new CommonCalls();
  static const String routeName = "/consHome";

  @override
  _ConsHomeState createState() => new _ConsHomeState();
}

class _ConsHomeState extends State<ConsHome> {
  @override
  void initState() {
    super.initState();
  }

  String dateTimeNow = DateFormat("EEE, MMM d, ''yy").format(DateTime.now());

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        // resizeToAvoidBottomPadding: false,
        // appBar: AppBar(
        //   title: Text(widget.title),
        // ),
        body: GridView.count(
            primary: false,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: <Widget>[
              GridTile(
                child: CommonCalls().getChildGoToCard(
                    context,
                    '/collectionshome',
                    Colors.orange,
                    Icons.account_balance_wallet,
                    'Pending Collections'),
              ),
              GridTile(
                child: CommonCalls().getChildGoToCard(context, '/fundshome',
                    Colors.green, Icons.attach_money, 'All Funds'),
              ),
              GridTile(
                child: CommonCalls().getChildGoToCard(context, '/stockhome',
                    Colors.purple, Icons.info_outline, 'Current Stock'),
              ),
              GridTile(
                child: CommonCalls().getChildGoToCard(context, '/exhome',
                    Colors.indigo, Icons.input, 'Expenses Entry'),
              ),
              GridTile(
                child: CommonCalls().getChildGoToCard(context, '/shome',
                    Colors.teal, Icons.keyboard, 'Sales Entry'),
              )
            ]));
  }
}
