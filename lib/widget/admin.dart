import 'package:flutter/material.dart';
import 'package:wilde_tuinen/widget/where_input_field.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _AdminPage(),
    );
  }
}

class _AdminPage extends StatefulWidget {
  _AdminPage({Key key}) : super(key: key);

  @override
  __AdminPageState createState() => __AdminPageState();
}

class __AdminPageState extends State<_AdminPage> {
  String imagePath;
  int n = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        WhereInputField(),
      ],
    );
  }
}
