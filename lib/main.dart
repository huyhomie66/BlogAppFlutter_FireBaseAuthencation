// This sample shows adding an action to an [AppBar] that opens a shopping cart.

import 'package:flutter/material.dart';
import 'LoginRegisterPage.dart';
import 'HomePage.dart';
import 'Mapping.dart';
import 'Authencation.dart';
void main() => runApp(BlogApp());

class BlogApp extends StatelessWidget{
  @override 
  Widget build(BuildContext context){
    return new MaterialApp(
      title: 'blog app',
      theme: new ThemeData(
        primarySwatch: Colors.blue
      ),
      home: MappingPage(auth: Auth(),),

    );
  }
} 