import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wilde_tuinen/event/app_events.dart';
import 'package:wilde_tuinen/util/widget_utils.dart';

class DisplayPhotoPage extends StatefulWidget {
  DisplayPhotoPage({Key key}) : super(key: key);

  @override
  _DisplayPhotoPageState createState() => _DisplayPhotoPageState();
}

class _DisplayPhotoPageState extends State<DisplayPhotoPage> {
  String imagePath;

  @override
  void initState() {
    super.initState();
    AppEvents.onShowPicture(_onShowPicture);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          imagePath==null ? Container() : Image.file(File(imagePath)),
          WidgetUtils.verSpace(5),
          RaisedButton(
              child: Text('Akkoord, sla gegevens op'),
              onPressed: () {
                _saveData();
              }),
          WidgetUtils.verSpace(5),
          RaisedButton(
              child: Text('Nee, maak foto opnieuw'),
              onPressed: () {
                _tryAgain();
              }),
        ],
      ),
    );
  }

  void _onShowPicture(ShowPictureEvent event) {
    setState(() {
      imagePath = event.imagePath;
    });
  }

  void _saveData() => AppEvents.fireSaveGarden();
  void _tryAgain() => AppEvents.fireTakePicture();
}
