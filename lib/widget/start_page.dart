import 'package:flutter/material.dart';
import 'package:wilde_tuinen/widget/main_appbar.dart';
// import '../data/constants.dart';
import 'package:wilde_tuinen/widget/home_page.dart';
import 'package:wilde_tuinen/event/app_events.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Tuinen in Nuenen',
      theme: new ThemeData(
        primarySwatch: Colors.lightGreen,
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

//-----------------------------------------
class _StartPageState extends State<_StartPage> {
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: buildMainAppBar(context, -1),
        floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
        floatingActionButton: FloatingActionButton(
                onPressed: () {
                  _addGarden();
                },
                child: Icon(Icons.add),
                backgroundColor: Colors.lightGreen,
              ),
        body: 
            HomePage(title: 'Wilde tuinen'), // 0
        );
  }

  
  void _addGarden() {
    AppEvents.fireTakePicture();
  }
}
