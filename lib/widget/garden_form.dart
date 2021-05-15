import 'dart:typed_data';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wilde_tuinen/data/app_data.dart';
import 'package:wilde_tuinen/model/garden.dart';
import 'package:wilde_tuinen/widget/widget_helper.dart' as wh;
import 'package:wilde_tuinen/event/app_events.dart';

class GardenForm extends StatefulWidget {
  GardenForm();

  @override
  _GardenFormState createState() {
    return _GardenFormState();
  }
}

class _GardenFormState extends State<GardenForm> {
  _GardenFormState();

  final _formKey = GlobalKey<FormState>();
  final _ctrl1 = TextEditingController();
  final _ctrl2 = TextEditingController();
  late BuildContext _context;

  Uint8List? _bytes;
  var _mode = MODUS.READ;
  String _actionText = 'Wijzig';
  Garden _garden = new Garden();

  var _readOnly = true;
  var _actionEnabled = true;

  @override
  void initState() {
    _setGarden();

    _ctrl1.addListener(_onTextChanged);
    _ctrl2.addListener(_onTextChanged);

    super.initState();
  }

  _setGarden() {
    _garden = AppData().currentGarden;
    _bytes = base64Decode(_garden.fotoBase64 as String);
    _ctrl1.text = _garden.name;
    _ctrl2.text = _garden.description;
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    final size = MediaQuery.of(context).size;

    return ListView(
      key: _formKey,
      children: [
        wh.verSpace(10.0),
        _photo(size),
        _nameField(),
        _descriptionField(),
        _actionButton(context),
      ],
    );
  }

  Padding _actionButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: !_actionEnabled
            ? null
            : () {
                this._onActionClicked();
              },
        child: Text(_actionText),
      ),
    );
  }

  Widget _photo(Size size) {
    return Container(
      height: size.width * 0.4,
      width: size.width,
      child: Image.memory(_bytes as Uint8List),
    );
  }

  Widget _nameField() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: _readOnly
          ? _readOnlyField('Naam', _ctrl1.text)
          : _inputField(_ctrl1, 'Naam', 'Geef naam', 1),
    );
  }

  Widget _descriptionField() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: _readOnly
          ? _readOnlyField('Omschrijving', _ctrl2.text)
          : _inputField(_ctrl2, 'Omschrijving', 'Geef Omschrijving', 3),
    );
  }

  Widget _inputField(
      TextEditingController ctrl, String label, String errmsg, int maxLines) {
    var field = wh.buildIinputField(ctrl, label, errmsg, maxLines, _readOnly);
    return field;
  }

  void _onActionClicked() {
    if (this._mode == MODUS.READY_TO_SAVE) {
      _garden.name = _ctrl1.text;
      _garden.description = _ctrl2.text;
      AppEvents.fireSaveGarden(_garden);
      wh.successMsg('Met succes opgeslagen', _context);
    }
    this._setModus();
  }

  void _onTextChanged() {
    if (_ctrl1.text != _garden.name || _ctrl2.text != _garden.description) {
      setState(() {
        this._actionEnabled = true;
        this._mode = MODUS.READY_TO_SAVE;
      });
    }
  }

  @override
  void dispose() {
    _ctrl1.dispose();
    _ctrl2.dispose();
    super.dispose();
  }

  void _setModus() {
    if (this._mode == MODUS.READ) {
      this._mode = MODUS.EDIT;
    } else if (this._mode == MODUS.EDIT) {
      this._mode = MODUS.EDIT;
    } else if (this._mode == MODUS.READY_TO_SAVE) {
      this._mode = MODUS.READ;
    }

    if (this._mode == MODUS.READ) {
      _readOnly = true;
      _actionEnabled = true;
      _actionText = 'Wijzig';
    } else if (this._mode == MODUS.EDIT) {
      _readOnly = false;
      _actionEnabled = false;
      _actionText = 'Sla op';
    } else if (this._mode == MODUS.READY_TO_SAVE) {
      _readOnly = true;
      _actionEnabled = true;
      _actionText = 'Wijzig';
    }

    setState(() {});
  }

  Widget _readOnlyField(String header, String text) {
    return Column(
      children: [
        Text(header),
        Text(text),
      ],
    );
  }
}


enum MODUS { READ, EDIT, READY_TO_SAVE }
