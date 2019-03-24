import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final Widget child;

  Home({Key key, this.child}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}