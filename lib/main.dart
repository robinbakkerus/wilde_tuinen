import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
import 'package:wilde_tuinen/widget/start_page.dart';
// import 'package:wilde_tuinen/data/constants.dart';

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
      title: 'NGN200',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StartPage(),
    );
  }
}