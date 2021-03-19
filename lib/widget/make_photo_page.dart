import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:wilde_tuinen/event/app_events.dart';

class TakePictureScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
        future: _getCamera(),
        builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text('Press button to start.');
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Text('Awaiting result...');
            case ConnectionState.done:
              if (snapshot.hasError) return Text('Error: ${snapshot.error}');
              return Text(snapshot.data.toString());
          }
        });
  }

  Future<Widget> _getCamera() async {
    var _cameras = await availableCameras();
    return _TakePictureScreen(camera: _cameras.first);
  }
}

// A screen that allows users to take a picture using a given camera.
class _TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;

  const _TakePictureScreen({required this.camera}) : super();

  @override
  _TakePictureScreenState createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<_TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  String saveResult = "";

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        // Provide an onPressed callback.
        onPressed: _onPressed,
      ),
    );
  }

  void _onPressed() async {
    try {
      await _initializeControllerFuture;

      final path = join(
        (await getTemporaryDirectory()).path,
        '${DateTime.now()}.png',
      );
      print(path);

      XFile file = await _controller.takePicture();

      // If the picture was taken, display it on a new screen.
      AppEvents.fireCompressPicture(file.path);
    } catch (e) {
      print(e);
    }
  }
}
