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

//---------------------------------------------------------------------
class _TakePhotoPageState extends State<TakePhotoPage> {
  final _photos = <File>[];
  final _txtCtrlName = TextEditingController();
  final _txtCtrlDescr = TextEditingController();
  final _snackBar = SnackBar(content: Text('Yay! A SnackBar!'));
  var _state = PS.INIT;

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    _txtCtrlDescr.addListener(_onTextChanged);
    _txtCtrlDescr.addListener(_onTextChanged);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
        icon: const Icon(Icons.arrow_back_outlined),
        onPressed: () { 
          AppEvents.fireSwitchStack(STACK_HOME);
         },
      ),
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Container(
            height: size.width * 0.5,
            width: size.width,
            child: _photos.length == 0
                ? null
                : Image.file(
                    _photos[0],
                    fit: BoxFit.cover,
                  ),
          ),
          _verSpace(),
          if (_state == PS.INIT) _takePhotoButton(size),
          if (_state == PS.PHOTO_OKAY) _nameInputField(size),
          if (_state == PS.READY_TO_SAVE) _saveButton(size),
          if (_state == PS.PHOTO_READY) _askPhotoOk(size),
        ],
      ),
    );
  }

  Widget _verSpace() {
    return Container(
      height: 10,
    );
  }

  Widget _horSpace(double w) {
    return Container(
      width: w,
    );
  }

  Widget _askPhotoOk(Size size) {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          _horSpace(20.0),
          Text('Is foto okay? '),
          _horSpace(10),
          ElevatedButton(
            onPressed: _onPhotoOk,
            child: Text('Ja'),
          ),
          _horSpace(5.0),
          ElevatedButton(
            onPressed: _onPhotoNotOk,
            child: Text('Nee'),
          ),
        ],
      ),
    );
  }

  _onPhotoOk() {
    setState(() {
      this._state = PS.PHOTO_OKAY;
    });
  }

  _onPhotoNotOk() {
    setState(() {
      this._state = PS.INIT;
    });
  }

  Widget _nameInputField(Size size) {
    return Container(
      width: size.width,
      color: Colors.white,
      child: Column(
        children: [
          wh.buildIinputField(_txtCtrlName, 'Naam', 'errmsg', 1),
          wh.buildIinputField(_txtCtrlDescr, 'Omschrijving', 'errmsg', 2),
          _saveButton(size),
        ],
      ),
    );
  }

  Widget _saveButton(Size size) {
    return Container(
      width: size.width,
      color: Colors.white,
      child: ElevatedButton(
        onPressed: _isSubmitDisabled() ? null : _onSubmit,
        child: Text('Sla op'),
      ),
    );
  }

  bool _isSubmitDisabled() {
    return _txtCtrlDescr.text == "" || _txtCtrlName.text == "";
  }

  void _openCamera() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => CameraCamera(
                  cameraSide: CameraSide.front,
                  onFile: (file) {
                    _photos.clear();
                    _photos.add(file);
                    Navigator.pop(context);
                    setState(() {
                      this._state = PS.PHOTO_READY;
                    });
                  },
                )));
  }

  Container _takePhotoButton(Size size) {
    return Container(
      width: size.width,
      color: Colors.white,
      child: ElevatedButton(
        onPressed: _openCamera,
        child: Text('Maak foto'),
      ),
    );
  }

  _onSubmit() {
    final imagePath = ImageUtils.compressFile(_photos[0]);
    final obj = ImageUtils.imageAsBase64(imagePath);

    var garden = AppData().newGarden;
    garden.name = _txtCtrlName.text;
    garden.description = _txtCtrlDescr.text;
    garden.fotoBase64 = obj;

    ScaffoldMessenger.of(context).showSnackBar(_snackBar);

    AppEvents.fireSaveGarden(garden);

    setState(() {
      this._txtCtrlName.text = '';
      this._txtCtrlDescr.text = '';
      this._state = PS.INIT;
    });
  }

  _onTextChanged() {
    setState(() {});
  }
}

enum PS { INIT, PHOTO_READY, PHOTO_OKAY, READY_TO_SAVE, PHOTO_SAVED }
