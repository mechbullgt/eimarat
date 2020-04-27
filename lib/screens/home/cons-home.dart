import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConsHome extends StatefulWidget {
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
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            children: <Widget>[
              GridTile(
                child: getChildGoToCard('/collectionshome', Colors.blue,
                    Icons.account_balance_wallet, 'Pending Collections'),
              )
            ]));
  }

  getChildGoToCard(routeName, cardColor, cardIcon, cardText) {
    return InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(routeName);
          print('Tapped on $routeName');
        },
        child: Card(
          // color: cardColor,
          child: new Center(
              child: ListTile(
                  leading: ExcludeSemantics(
                      child: Stack(children: <Widget>[
                    CircleAvatar(
                      child: Icon(cardIcon),
                    ),
                  ])),
                  title: Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Text(
                      cardText,
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                  subtitle: Padding(
                      padding: EdgeInsets.only(top: 5, bottom: 5),
                      child: (Column(children: <Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Padding(padding: EdgeInsets.only(left: 55)),
                              Text(
                                'Go To',
                                style: TextStyle(fontSize: 16),
                              ),
                              Padding(padding: EdgeInsets.only(top: 50)),
                              Icon(Icons.arrow_right),
                            ])
                      ]))))),
        ));
  }
}
