import 'package:flutter/material.dart';

class ImaratRootHome extends StatelessWidget {
  Container getStructuredGridCell(name, grade, icon, cardColor, context) {
    return new Container(
        child: Card(
            elevation: 5,
            color: cardColor,
            child: InkWell(
                // splashColor: Colors.blue,
                onTap: () {
                  print('Card tapped:' + '$grade');
                  Navigator.of(context).pushNamed("/$grade");
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: ListTile(
                        leading: Icon(
                          icon,
                          color: Colors.white,
                        ),
                        title: Text(
                          name,
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                        trailing: Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ))));
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var screenSizeReservedForWidgets = MediaQuery.of(context).size.height / 1;
    return new Scaffold(
        // appBar: AppBar(
        //   title: Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: [
        //         Text(
        //           "Imarat Construction & Supplies",
        //           style: TextStyle(fontSize: 25),
        //         ),
        //       ]),
        //   centerTitle: true,
        //   flexibleSpace: Container(
        //     decoration: BoxDecoration(
        //       gradient: LinearGradient(
        //         begin: Alignment.centerLeft,
        //         end: Alignment.centerRight,
        //         colors: <Color>[Color(0xff2c9f50), Color(0xff3497cb)],
        //       ),
        //     ),
        //   ),
        // ),
        body: Container(
            // padding: EdgeInsets.fromLTRB(0, 50, 0, 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[Color(0xff2c1e50), Color(0xff3490db)],
              ),
            ),
            child: Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                  Container(
                    height: screenSizeReservedForWidgets * 0.20,
                    width: 260,
                    padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                    child: getStructuredGridCell(
                        "Imarat Construction Supplies",
                        'supplieshome',
                        Icons.local_convenience_store,
                        Colors.blueGrey,
                        context),
                  ),
                  new Container(
                    height: 150.0,
                    width: 400.0,
                    decoration: new BoxDecoration(
                      image: DecorationImage(
                        image:
                            new AssetImage('assets/images/onboardingLogo.png'),
                        fit: BoxFit.fill,
                      ),
                      // shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    height: screenSizeReservedForWidgets * 0.15,
                    width: 260,
                    child: getStructuredGridCell(
                        "Imarat Plumbing Solutions",
                        'supplieshome',
                        Icons.control_point_duplicate,
                        Colors.blue,
                        context),
                  ),
                  // Container(
                  //   height: screenSizeReservedForWidgets * 0.30,
                  //   // padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  //   child: getStructuredGridCell(
                  //       "Imarat Construction", 'supplieshome', Icons.home,Colors.deepPurpleAccent, context),
                  // ),
                ]))));
  }
}
