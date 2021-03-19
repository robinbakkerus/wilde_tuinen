import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _AdminPage(),
    );
  }
}

class _AdminPage extends StatefulWidget {
  @override
  __AdminPageState createState() => __AdminPageState();
}

class __AdminPageState extends State<_AdminPage> {
  String imagePath = '';
  int n = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('TODO'),
      ],
    );
  }
}
