import 'package:flutter/material.dart';
import 'package:wilde_tuinen/widget/start_page.dart';
import 'package:wilde_tuinen/widget/garden_detail_page.dart';
import 'package:wilde_tuinen/event/app_events.dart';
import 'package:wilde_tuinen/controller/app_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wilde_tuinen/widget/add_new_page.dart';
import 'package:wilde_tuinen/widget/admin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final fbApp = await Firebase.initializeApp();
  print('created : ' + fbApp.toString());

  runApp(new MaterialApp(
      title: 'Tuinen',
      theme: new ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      // home: _App(),
      initialRoute: '/',
      routes: {
        '/': (context) => _App(),
        '/admin': (context) => AdminPage(),
      },
    ));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Tuinen',
      theme: new ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      // home: _App(),
      initialRoute: '/',
      routes: {
        '/': (context) => _App(),
        '/admin': (context) => AdminPage(),
      },
    );
  }
}

class _App extends StatefulWidget {
  @override
  _AppState createState() => new _AppState();
}

class _AppState extends State<_App> {
  int _stackIndex = 0;

  _AppState() {
    AppController();
    AppEvents.onSwitchTask(_onSwitchTask);
  }

  _onSwitchTask(SwitchStackEvent event) {
    setState(() {
      this._stackIndex = event.stackIndex;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: _stackIndex,
      children: <Widget>[
        StartPage(), // 0 STACK_HOME
        GardenDetailPage(), // 1 STACK_DETAIL_PAGE
        AddNewGardenPage(title: 'Foto'), // 2 STACK_TAKE_PICTURE
        AdminPage(), // 3 STACK_ADMIN
      ],
    );
  }
}
