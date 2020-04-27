import 'package:flutter/material.dart';

class CommonCalls{
AppBar getAppBarForConstruction (String titleText){
  return AppBar(
            title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(children: <Widget>[
                  Image.asset('assets/images/logo1.png',
                  fit: BoxFit.fitWidth,),
Padding(padding: EdgeInsets.only(top: 10)),
                  Text(
                    titleText,
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  ],),
                  
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
}