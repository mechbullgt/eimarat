import 'dart:convert';
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

  final Color cashInBank = Color(0xff3498db);
  final Color cashInHand = Color(0xff2ecc71);
  final Color cashPending = Color(0xffe74c3c);

  Map<String, double> dataMap = Map();
  // List<Color> colorList = [
  //   Colors.blue.shade700,
  //   Colors.green.shade500,
  //   Colors.red.shade700,
  // ];

  final String fundsCollectionCountURL =
      "https://script.google.com/macros/s/AKfycbzrv0imLQU3sbIYcpq4_WwxtSK4QO-dAnauIKpM3wKCK1vFRJc/exec";
  final String fundsClientDetailsURL =
      Endpoints().getEndpoint('getClientDetails');

  Map fundsList = new Map();
  Map clientsDetailsList = new Map();

  void getFundsList() async {
    var response = await http.get(fundsCollectionCountURL);

    if (response.statusCode == 200) {
      setState(() {
        fundsList = json.decode(response.body);
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
        print('Client Details iIst');
        print(clientsDetailsList);
        _progressController = false;
      });
    } else {
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    super.initState();
    this.getFundsList();
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
              child: new Column(mainAxisSize: MainAxisSize.min,
                  // padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                  // height: MediaQuery.of(context).size.height * 0.35,
                  // width: 10,
                  children: <Widget>[
                  SizedBox(
                      // height: (MediaQuery.of(context).size.height - 300) / 2,
                      height: 200,
                      child: ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: fundsList.length,
                          itemBuilder: (BuildContext context, int index) {
                            String key =
                                fundsList.keys.toList().elementAt(index);
                            return Container(
                                // shape: StadiumBorder(),
                                // color: Colors.blueGrey.shade50,
                                // elevation: 3,
                                child: Text(key)
                                    // Column(children: <Widget>[
                                    
                              //     leading: ExcludeSemantics(
                              //         child: Stack(children: <Widget>[
                              //   CircleAvatar(
                              //     child: new Text('${key[0]}'),
                              //   ),
                              //   Positioned(
                              //     right: 0,
                              //     child: new Container(
                              //       padding: EdgeInsets.all(2),
                              //       decoration: new BoxDecoration(
                              //         color: Colors.red,
                              //         borderRadius:
                              //             BorderRadius.circular(6),
                              //       ),
                              //       constraints: BoxConstraints(
                              //         minWidth: 15,
                              //         minHeight: 15,
                              //       ),
                              //       child: new Text(
                              //         fundsList[key].toString(),
                              //         style: new TextStyle(
                              //           color: Colors.white,
                              //           fontSize: 12,
                              //         ),
                              //         textAlign: TextAlign.center,
                              //       ),
                              //     ),
                              //   )
                              // ])
                              // )
                            )
                                // ]

                                //  ListView.builder(
                                //     physics: ClampingScrollPhysics(),
                                //     scrollDirection: Axis.horizontal,
                                //     shrinkWrap: true,
                                //     itemCount: fundsList.length,
                                //     itemBuilder:
                                //         (BuildContext contect, int index) {
                                //       String key = fundsList.keys
                                //           .toList()
                                //           .elementAt(index);
                                //       return Container(
                                //         child: Padding(
                                //           padding:
                                //               EdgeInsets.fromLTRB(20, 0, 20, 5),
                                //           child: Card(
                                //             shape: StadiumBorder(),
                                //             color: Colors.blueGrey.shade50,
                                //             elevation: 3,
                                //             child: Column(
                                //               children: <Widget>[
                                //                 new ListTile(
                                //                     leading: ExcludeSemantics(
                                //                         child: Stack(children: <
                                //                             Widget>[
                                //                       CircleAvatar(
                                //                         child:
                                //                             new Text('${key[0]}'),
                                //                       ),
                                //                       Positioned(
                                //                         right: 0,
                                //                         child: new Container(
                                //                           padding:
                                //                               EdgeInsets.all(2),
                                //                           decoration:
                                //                               new BoxDecoration(
                                //                             color: Colors.red,
                                //                             borderRadius:
                                //                                 BorderRadius
                                //                                     .circular(6),
                                //                           ),
                                //                           constraints:
                                //                               BoxConstraints(
                                //                             minWidth: 15,
                                //                             minHeight: 15,
                                //                           ),
                                //                           child: new Text(
                                //                             fundsList[key]
                                //                                 .toString(),
                                //                             style: new TextStyle(
                                //                               color: Colors.white,
                                //                               fontSize: 12,
                                //                             ),
                                //                             textAlign:
                                //                                 TextAlign.center,
                                //                           ),
                                //                         ),
                                //                       )
                                //                     ])),
                                //                     title: Text('$key'),
                                //                     trailing: CircleAvatar(
                                //                       child: Text(
                                //                         'hi',
                                //                         style: TextStyle(
                                //                             color: Colors.white),
                                //                       ),
                                //                       backgroundColor:
                                //                           Colors.blue,
                                //                     ))
                                //               ],
                                //             ),
                                //           ),
                                //         ),
                                //       );
                                //     })
                          }))]))])),
                         
              
      _progressController
          ? const CircularProgressIndicator()
          : new Container(
              height: (MediaQuery.of(context).size.height - 10) / 2,
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
                                  child: new Text('${key}'),
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
                                //       fundsList[key].toString(),
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
}
