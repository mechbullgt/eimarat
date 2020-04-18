import 'dart:convert';
import 'dart:ui';
import 'package:eimarat/resources/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FundsCollection extends StatefulWidget {
  final Endpoints endpoints = Endpoints();

  static const String routeName = "/collectionshome";

  @override
  _FundsCollectionState createState() => new _FundsCollectionState();
}

class _FundsCollectionState extends State<FundsCollection> {
  bool _progressController = true;
  bool toggle = false;

  final String fundsCollectionCountURL =
      Endpoints().getEndpoint('getClientBillCounts');
  final String fundsClientDetailsURL =
      Endpoints().getEndpoint('getClientDetails');

  // Map collectionCountList = new Map();
  List countList = new List();
  Map clientsDetailsList = new Map();

  void getcollectionCountList() async {
    var response = await http.get(fundsCollectionCountURL);

    if (response.statusCode == 200) {
      setState(() {
        countList = json.decode(response.body);
        print('Got Client Count List');
        _progressController = false;
      });
    } else {
      print(response.statusCode);
    }
  }

  void getClientDetails() async {
    var response = await http.get(fundsClientDetailsURL);

    if (response.statusCode == 200) {
      setState(() {
        clientsDetailsList = json.decode(response.body);
        print('Got Client Details List');
        _progressController = false;
      });
    } else {
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    super.initState();
    this.getcollectionCountList();
    this.getClientDetails();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Scrollbar(
            child:
                new Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      _progressController
          ? const CircularProgressIndicator()
          : SingleChildScrollView(
              child:
                  new Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: countList.length,
                      itemBuilder: (BuildContext context, int index) {
                        // print(index);
                        // String key = countList[index]['rowCounter'].toString();
                        return Container(
                            width: 150,
                            child: Card(
                                color: Colors.blue.shade900,
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          top: BorderSide(
                                              color: Colors.red, width: 2.0))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Stack(
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 0.0),
                                          child: totalBillsWidget(index),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 60.0),
                                          child: totalBalanceWidget(index),
                                        ),
                                        clientNameWidget(index)
                                      ],
                                    ),
                                  ),
                                )));
                      }))
            ])),
      _progressController
          ? const CircularProgressIndicator()
          : new Container(
              height: (MediaQuery.of(context).size.height) / 1.7,
              child: Card(
                  child: new ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: clientsDetailsList.length,
                itemBuilder: (BuildContext contect, int index) {
                  String key =
                      clientsDetailsList.keys.toList().elementAt(index);
                  return Container(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                      child: Card(
                        shape: StadiumBorder(),
                        color: Colors.blueGrey.shade50,
                        elevation: 3,
                        child: Column(
                          children: <Widget>[
                            new ListTile(
                              leading: ExcludeSemantics(
                                  child: Stack(children: <Widget>[
                                CircleAvatar(
                                  child: new Text(key),
                                ),
                                // Positioned(
                                //   right: 0,
                                //   child: new Container(
                                //     padding: EdgeInsets.all(2),
                                //     decoration: new BoxDecoration(
                                //       color: Colors.red,
                                //       borderRadius:
                                //           BorderRadius.circular(6),
                                //     ),
                                //     constraints: BoxConstraints(
                                //       minWidth: 15,
                                //       minHeight: 15,
                                //     ),
                                //     child: new Text(
                                //       collectionCountList[key].toString(),
                                //       style: new TextStyle(
                                //         color: Colors.white,
                                //         fontSize: 12,
                                //       ),
                                //       textAlign: TextAlign.center,
                                //     ),
                                //   ),
                                // )
                              ])),
                              title:
                                  Text(clientsDetailsList[key]['clientName']),
                              subtitle: Text(
                                getClientSubTDetails(key),
                                style: TextStyle(fontSize: 16),
                              ),
                              trailing: Text(
                                getClientBalanceAmount(key),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                              isThreeLine: true,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )))
    ])));
  }

  String getClientBalanceAmount(var key) {
    var balanceAmt =
        clientsDetailsList[key]['balanceAmount'].toStringAsFixed(0);
    return 'Bal Amt.' + '\n' + '₹ ' + balanceAmt;
  }

  String getClientSubTDetails(String key) {
    var chalNo = clientsDetailsList[key]['challanNumb'].toStringAsFixed(0);
    var paidAmt = clientsDetailsList[key]['paidAmount'].toStringAsFixed(0);
    var billAmt = clientsDetailsList[key]['acutalAmount'].toStringAsFixed(0);
    var date = clientsDetailsList[key]['date'].substring(2, 10);
    var subText = 'Date: ' +
        date +
        " | " +
        'Ch.No.:' +
        chalNo +
        "\n" +
        "Paid Amt. ₹ " +
        paidAmt +
        " | " +
        "Bill Amt. ₹ " +
        billAmt;
    return subText;
  }

  Widget totalBalanceWidget(var index) {
    return Align(
      alignment: Alignment.topCenter,
      child: RichText(
        text: TextSpan(
            text: 'Bal Amt. \n',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15),
            children: <TextSpan>[
              TextSpan(
                  text: getTotalBalanceForWidget(index),
                  style: TextStyle(fontSize: 25))
            ]),
      ),
    );
  }

  Widget totalBillsWidget(var index) {
    return Align(
      alignment: Alignment.topLeft,
      child: RichText(
        text: TextSpan(
            text: 'Bills',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15),
            children: <TextSpan>[
              TextSpan(
                  text: '\n' + countList[index]['challanCount'].toString(),
                  style: TextStyle(fontSize: 12))
            ]),
      ),
    );
  }

  Widget clientNameWidget(var index) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              text: countList[index]['clientName'].toString(),
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ));
  }

  String getTotalBalanceForWidget(index) {
    var amt = countList[index]['totalBal'].toString();
    return '₹ ' + amt;
  }
}
