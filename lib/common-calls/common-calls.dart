import 'package:flutter/material.dart';

class CommonCalls {
  getChildGoToCard(context, routeName, cardColor, cardIcon, cardText) {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 40, right: 40),
      child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(routeName);
            print('Tapped on $routeName');
          },
          child: Card(
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              child: new Center(
                  child: ListTile(
                      dense: true,
                      leading: ExcludeSemantics(
                        child: Padding(
                          padding: EdgeInsets.only(left: 0),
                          child: CircleAvatar(
                            child: Icon(cardIcon),
                            backgroundColor: cardColor,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                      title: Padding(
                          padding: EdgeInsets.only(top: 0),
                          child: getGoToCardText(cardText)),
                      trailing: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 25),
                        child: Icon(Icons.keyboard_arrow_right),
                      ))))),
    );
  }

  AppBar getAppBarForConstruction(String titleText) {
    return AppBar(
      title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left:25),
              child: ListTile(
                leading:Image.asset(
                    'assets/images/elogo.png',
                    width: 40,
                    height: 40,
                    fit: BoxFit.fitWidth,
                  ),
                  title: Text(
                    '/ '+titleText,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                      color: Colors.white
                    ),
                  ),
                
              ),
            )
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
    );
  }

  Widget getGoToCardText(cardText) {
    return Align(
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
            // style: TextStyle(
            //     fontWeight: FontWeight.w600, color: Colors.white, fontSize: 15),
            children: <TextSpan>[
              TextSpan(
                  text: cardText,
                  style: TextStyle(fontSize: 22, color: Colors.white))
            ]),
      ),
    );
  }


String getPageNameAsPerRoute(var routeName){
  switch (routeName) {
    case '/collectionshome':
      return 'Collections';
      break;
          case '/fundshome':
      return 'Funds';
      break;
    case '/stockhome':
      return 'Stock';
      break;
    case '/collectionshome':
      return 'Collections';
      break;
    case '/exhome':
      return 'Expenses Entry';
      break;
    case '/shome':
      return 'Sales Entry';
      break;
    default:
    return 'e-Imarat';
  }
}
}