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
  final String fundsClientDetailsURL = Endpoints().getEndpoint('getClientDetails');
  
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

    void getClientDetails () async {
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
            child: new Center(
                child: _progressController
                    ? const CircularProgressIndicator()
                    : new ListView.builder(
                        shrinkWrap: true,
                        itemCount: fundsList.length,
                        itemBuilder: (BuildContext contect, int index) {
                          String key = fundsList.keys.toList().elementAt(index);
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
                                          child: new Text('${key[0]}'),
                                        ),
                                        Positioned(
                                          right: 0,
                                          child: new Container(
                                            padding: EdgeInsets.all(2),
                                            decoration: new BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            constraints: BoxConstraints(
                                              minWidth: 15,
                                              minHeight: 15,
                                            ),
                                            child: new Text(
                                              fundsList[key].toString(),
                                              style: new TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        )
                                      ])),
                                      title: Text('$key'),
                                      trailing: CircleAvatar(
                                        child: Text(
                                          clientsDetailsList[0]['balanceAmount'].toString(),
                                          style:
                                              TextStyle(color: Colors.white),
                                        ),
                                        backgroundColor: Colors.blue,
                                      )
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        //     Card(
                        //       child: Padding(
                        //           padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                        //           child: Card(
                        //             shape: RoundedRectangleBorder(
                        //               borderRadius: BorderRadius.circular(15.0),
                        //             ),
                        //             color: cashInHand,
                        //             elevation:3,
                        //             child: Column(
                        //               children: <Widget>[
                        //                 new ListTile(
                        //                   leading: Icon(Icons.offline_bolt,
                        //                       size: cardIconSize),
                        //               title: Text('Cash In Hand',
                        //                   style: TextStyle(
                        //                       color: Colors.white,
                        //                       fontSize: 22)),
                        //               trailing: Text(getCashValue(),
                        //                   style: TextStyle(
                        //                       color: Colors.white,
                        //                       fontSize: 22)),
                        //             ),
                        //           ],
                        //         ),
                        //       )),
                        // ),

                        // floatingActionButton: FloatingActionButton(
                        //   onPressed: togglePieChart,
                        //   child: Icon(Icons.insert_chart),
                        // ),
                      ))));
  }
}
