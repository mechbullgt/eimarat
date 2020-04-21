import 'dart:convert';
import 'dart:ui';
import 'package:eimarat/resources/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';

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
  // Map clientsDetailsList = new Map();
  List clientsDetailsList = new List();

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
                                              const EdgeInsets.only(right: 0.0),
                                          child: billCardShareWidget(
                                              contentForBillsCountShare(index)),
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
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 140,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                        color: Colors.blueGrey.shade50,
                        elevation: 3,
                        child: Column(
                          children: <Widget>[
                            new ListTile(
                              leading: ExcludeSemantics(
                                  child: Stack(children: <Widget>[
                                CircleAvatar(
                                  child: new Text(clientsDetailsList[index]
                                          ['clientName']
                                      .toString()
                                      .substring(0, 1)),
                                ),
                              ])),
                              title: Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  clientsDetailsList[index]['clientName'],
                                  style: TextStyle(fontSize: 22),
                                ),
                              ),
                              subtitle: Padding(
                                  padding: EdgeInsets.only(top: 5,bottom: 5),
                                  child: (Column(
                                    children: <Widget>[
                                      Row(children: <Widget>[
                                        Icon(Icons.date_range),
                                        Text(
                                          getDateClientDetails(index),
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Text('   '),
                                        Icon(Icons.list),
                                        Text(
                                          getChalNoClientDetails(index),
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ]),
                                      Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Text(
                                                'Bill Amt: ₹ ' +
                                                    getBillAmtClientDetails(
                                                        index),
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              Text(
                                                ' | Paid Amt: ₹ ' +
                                                    getPaidAmountClientDetails(
                                                        index),
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ],
                                          ),
                                          Divider(),
                                          Text(
                                            'Bal Amt: ₹ ' +
                                                getBalAmountClientDetails(
                                                    index),
                                            style: TextStyle(fontSize: 20),
                                          )
                                        ],
                                      )
                                    ],
                                  ))),
                              trailing: billDetailsCardShareWidget(
                                  contentForClientDetailsShare(index)),
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

  // String getClientSubTDetails(int key) {
  //   var chalNo = getChalNoClientDetails(key);
  //   var paidAmt = getPaidAmountClientDetails(key);
  //   var billAmt = getBillAmtClientDetails(key);
  //   var balAmt = getBalAmountClientDetails(key);
  //   var date = getDateClientDetails(key);

  //   var subText =
  //       "Bill Amt. ₹ " +
  //       billAmt +
  //       "\nPaid Amt. ₹ " +
  //       paidAmt +
  //       "  |  Bal Amt. ₹ " +
  //       balAmt;
  //   return subText;
  // }

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
                  style: TextStyle(fontSize: 20))
            ]),
      ),
    );
  }

  Widget billCardShareWidget(var text) {
    return Stack(
      children: <Widget>[
        Positioned(
            top: -5,
            right: -25,
            child: Padding(
                padding: const EdgeInsets.only(right: 0),
                child: OutlineButton(
                  shape: CircleBorder(),
                  child: const Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                  onPressed: text.isEmpty
                      ? null
                      : () {
                          final RenderBox box = context.findRenderObject();
                          Share.share(text,
                              subject: text,
                              sharePositionOrigin:
                                  box.localToGlobal(Offset.zero) & box.size);
                        },
                )))
      ],
    );
  }

  Widget billDetailsCardShareWidget(var text) {
    return SizedBox(
      height: 60,
      width: 60,
      child: Stack(
        children: <Widget>[
          Positioned(
              top: 0,
              right: 0,
              left: 0,
              bottom: 0,
              child: Padding(
                  padding: const EdgeInsets.only(right: 0),
                  child: OutlineButton(
                    shape: CircleBorder(),
                    child: const Icon(
                      Icons.share,
                      color: Colors.blue,
                    ),
                    onPressed: text.isEmpty
                        ? null
                        : () {
                            final RenderBox box = context.findRenderObject();
                            Share.share(text,
                                subject: text,
                                sharePositionOrigin:
                                    box.localToGlobal(Offset.zero) & box.size);
                          },
                  )))
        ],
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
              style: TextStyle(color: Colors.white, fontSize: 19),
            ),
          ),
        ));
  }

  String getTotalBalanceForWidget(index) {
    var amt = countList[index]['totalBal'].toStringAsFixed(0);
    return '₹ ' + amt;
  }

  String contentForBillsCountShare(var index) {
    var noBills = countList[index]['challanCount'].toString();
    var balAmt = countList[index]['totalBal'].toStringAsFixed(0);
    var clientName = countList[index]['clientName'].toString();

    return 'Dear Sir,\nYour current balance is ₹ $balAmt/- against last $noBills bill/s. \n\nFrom: Imarat Supplies, Jagdalpur.\nTo: $clientName';
  }

  String contentForClientDetailsShare(int index) {
    var chNo = clientsDetailsList[index]['challanNumb'].toString();
    var date = clientsDetailsList[index]['date'].toString().substring(2, 10);
    var paidAmt = clientsDetailsList[index]['paidAmount'].toStringAsFixed(0);
    var billAmt = clientsDetailsList[index]['acutalAmount'].toStringAsFixed(0);
    var balAmt = clientsDetailsList[index]['balanceAmount'].toStringAsFixed(0);
    var clientName = clientsDetailsList[index]['clientName'].toString();

    return 'Dear Sir,\nYour bill $chNo is pending. \nBill Date:$date\nBill Amt: ₹ $billAmt\nAmt Paid: ₹ $paidAmt\nOutstanding Bill Amt: ₹ $balAmt \n\nFrom: Imarat Supplies, Jagdalpur.\nTo: $clientName';
  }

  String getDateClientDetails(int key) {
    return clientsDetailsList[key]['date'].substring(2, 10);
  }

  String getBalAmountClientDetails(int key) {
    return clientsDetailsList[key]['balanceAmount'].toStringAsFixed(0);
  }

  String getBillAmtClientDetails(int key) {
    return clientsDetailsList[key]['acutalAmount'].toStringAsFixed(0);
  }

  String getPaidAmountClientDetails(int key) {
    return clientsDetailsList[key]['paidAmount'].toStringAsFixed(0);
  }

  String getChalNoClientDetails(int key) {
    return clientsDetailsList[key]['challanNumb'].toString();
  }
}
