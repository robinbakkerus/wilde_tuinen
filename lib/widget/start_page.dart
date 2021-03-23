import 'package:flutter/material.dart';
import 'package:wilde_tuinen/widget/main_appbar.dart';
// import '../data/constants.dart';
import 'package:wilde_tuinen/widget/home_page.dart';
import 'package:wilde_tuinen/widget/make_photo_page.dart';
import 'package:wilde_tuinen/widget/admin.dart';
import 'package:wilde_tuinen/event/app_events.dart';
import 'package:wilde_tuinen/widget/display_photo_page.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Tuinen in Nuenen',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _StartPage(title: 'Tuinen in Nuenen'),
    );
  }
}

class _StartPage extends StatefulWidget {
  _StartPage({required this.title}) : super();
  final String title;

  @override
  _StartPageState createState() => new _StartPageState();
}

class _StartPageState extends State<_StartPage> {
  int _stackIndex = 0;

  _StartPageState() {
    AppEvents.onSwitchTask(_onSwitchStack);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: buildMainAppBar(context, -1),
        body: IndexedStack(
          index: _stackIndex,
          children: <Widget>[
            HomePage(title: 'Wilde tuinen'), // 0
            TakePictureScreen(), // 2
            DisplayPhotoPage(), // 3
            AdminPage(), // 4
          ],
        ));
  }

  void _onSwitchStack(SwitchStackEvent event) {
    if (event.type == StackType.MAIN) {
      setState(() {
        this._stackIndex = event.stackIndex;
      });
    }
  }
}
