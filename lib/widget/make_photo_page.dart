import 'dart:io';

import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/material.dart';
import 'package:wilde_tuinen/event/app_events.dart';
import 'package:wilde_tuinen/data/app_data.dart';
import 'package:wilde_tuinen/util/image_utils.dart';
import 'package:wilde_tuinen/widget/widget_helper.dart' as wh;

class TakePhotoPage extends StatefulWidget {
  TakePhotoPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _TakePhotoPageState createState() => _TakePhotoPageState();
}

class _TakePhotoPageState extends State<TakePhotoPage> {
  bool _hideBtn = false;
  final _photos = <File>[];
  final _ctrl = TextEditingController();
  final _snackBar = SnackBar(content: Text('Yay! A SnackBar!'));

  void _openCamera() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => CameraCamera(
                  onFile: (file) {
                    _photos.clear();
                    _photos.add(file);
                    Navigator.pop(context);
                    setState(() {
                      this._hideBtn = true;
                    });
                  },
                )));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Container(
            height: size.width * 0.7,
            width: size.width,
            child: _photos.length == 0
                ? null
                : Image.file(
                    _photos[0],
                    fit: BoxFit.cover,
                  ),
          ),
          Container(
            height: 10,
          ),
          Container(
              width: size.width,
              color: Colors.white,
              child: wh.buildIinputField(_ctrl, 'Naam', 'errmsg', 1)),
          Container(
            width: size.width,
            color: Colors.white,
            child: ElevatedButton(
              onPressed: _onSubmit,
              child: Text('Submit'),
            ),
          ),
        ],
      ),
      floatingActionButton: _hideBtn
          ? null
          : FloatingActionButton(
              onPressed: _openCamera,
              child: Icon(Icons.camera_alt),
            ),
    );
  }

  _onSubmit() {
    final imagePath = ImageUtils.compressFile(_photos[0]);
    final obj = ImageUtils.imageAsBase64(imagePath);

    var garden = AppData().newGarden;
    garden.name = _ctrl.text;
    garden.fotoBase64 = obj;

    ScaffoldMessenger.of(context).showSnackBar(_snackBar);
    AppEvents.fireSaveGarden(garden);
  }
}
