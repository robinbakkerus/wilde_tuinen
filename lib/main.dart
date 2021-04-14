import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:wilde_tuinen/data/app_data.dart';
import 'package:wilde_tuinen/widget/start_page.dart';
import 'package:wilde_tuinen/widget/garden_detail_page.dart';
import 'package:wilde_tuinen/event/app_events.dart';
import 'package:wilde_tuinen/controller/app_controller.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // final cameras = await availableCameras();
  // final firstCamera = cameras.first;
  // Constants.camera = firstCamera;

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Tuinen',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: _App());
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
    if (event.type == StackType.MAIN) {
      setState(() {
        this._stackIndex = event.stackIndex;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Tuinen',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IndexedStack(
        index: _stackIndex,
        children: <Widget>[StartPage(), GardenDetailPage()],
      ),
    );
  }
}
