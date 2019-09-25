


import 'package:flutter/material.dart';
import 'package:flutter_2/auth.dart';
import 'package:flutter_2/view.dart';
//import 'login_page.dart';
import 'root_page.dart';

void main(){
  runApp(new MyApp());
} 


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new RootPage(auth: new Auth(),),
     //home: MyApp12(),
    );
  }
}