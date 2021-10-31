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
  _GardenFormState() {
    AppEvents.onGardenSelected(_onGardenSelected);
  }

  late BuildContext _context;
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _ctrls = [];
  final List<String> _origs = [];

  Uint8List? _bytes;
  var _mode = MODUS.INIT;
  String _actionText = 'Wijzig';
  Garden _garden = new Garden();

  var _readOnly = true;
  var _actionEnabled = true;

  var _labels = ['Naam', 'Oms.', 'Soort', 'Lat', 'Lng', 'Door', 'Op'];

 _onGardenSelected(GardenSelectedEvent event) {
    setState(() {
      this._garden = AppData().currentGarden;
      initState();
    });
  }

  @override
  void initState() {
    _ctrls.clear();
    _origs.clear();

    for (int i = 0; i < 7; i++) {
      final ctrl = TextEditingController();
      _ctrls.add(ctrl);
      ctrl.addListener(_onTextChanged);
    }

    _fillCtrlWithGardenFields();

    AppEvents.onSwitchTask(_onSwitchTask);

    super.initState();
  }

  _fillCtrlWithGardenFields() {
    if (_garden.fotoBase64 != null) {
      _bytes = base64Decode(_garden.fotoBase64 as String);
      _ctrls[0].text = _garden.name;
      _ctrls[1].text = _garden.description;
      _ctrls[2].text = _garden.type.name;
      _ctrls[3].text = _garden.lat.toString();
      _ctrls[4].text = _garden.lng.toString();
      _ctrls[5].text = _garden.updatedBy;
      _ctrls[6].text = _garden.lastupdated.toLocal().toString();

      _ctrls.forEach((c) {
        _origs.add(c.text);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    final size = MediaQuery.of(context).size;

    return ListView(
      key: _formKey,
      children: _inputFields(size),
    );
  }

  List<Widget> _inputFields(Size size) {
    final  List<Widget> result = [];
    result.add(wh.verSpace(10.0));
    result.add(_photo(size));
    
    for (int i = 0; i < _ctrls.length; i++) {
      result.add(_inputField(i));
      result.add(wh.verSpace(5));
    }

    result.add(_actionButton(context));
    return result;
  }

  Widget _inputField(int idx) {
    var field = wh.buildIinputField(_ctrls[idx], _header(idx), _readOnly);
    return field;
  }

  Widget _actionButton(BuildContext context) {
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
    return _bytes == null
        ? Container()
        : Container(
            height: size.width * 0.4,
            width: size.width,
            child: Image.memory(_bytes as Uint8List),
          );
  }


  void _onActionClicked() {
    if (_mode == MODUS.READY_TO_SAVE) {
      _fillGardenFromCtrl();
      AppEvents.fireSaveGarden(_garden);
      wh.successMsg('Met succes opgeslagen', _context);
    }
    this._setModus();
  }

  void _fillGardenFromCtrl() {
    _garden.name = _ctrls[0].text;
    _garden.description = _ctrls[1].text;
    // andere velden todo
  }

  void _onTextChanged() {
    var changed = false;

    for (int i = 0; i < _origs.length; i++) {
      if (_ctrls[i].text != _origs[i]) {
        changed = true;
        break;
      }
    }

    if (changed) {
      setState(() {
        this._actionEnabled = true;
        _mode = MODUS.READY_TO_SAVE;
      });
    }
  }

  void _reset() {
    _mode = MODUS.INIT;
    setState(() {
      _setModus();
    });
  }

  void _setModus() {
    if (_mode == MODUS.INIT) {
      _mode = MODUS.READ;
    } else if (_mode == MODUS.READ) {
      _mode = MODUS.EDIT;
    } else if (_mode == MODUS.EDIT) {
      _mode = MODUS.EDIT;
    } else if (_mode == MODUS.READY_TO_SAVE) {
      _mode = MODUS.READ;
    }

    if (_mode == MODUS.INIT) {
      _readOnly = true;
      _actionEnabled = true;
      _actionText = 'Wijzig';
    } else if (_mode == MODUS.READ) {
      _readOnly = true;
      _actionEnabled = true;
      _actionText = 'Wijzig';
    } else if (_mode == MODUS.EDIT) {
      _readOnly = false;
      _actionEnabled = false;
      _actionText = 'Sla op';
    } else if (_mode == MODUS.READY_TO_SAVE) {
      _readOnly = true;
      _actionEnabled = true;
      _actionText = 'Wijzig';
    }

    setState(() {});
  }

  _onSwitchTask(SwitchStackEvent event) {
    setState(() {
      this._reset();
    });
  }

  @override
  void dispose() {
    _ctrls.forEach((c) => c.dispose());
    super.dispose();
  }

  String _header(int idx) {
    return _labels[idx];
  }
}

enum MODUS { INIT, READ, EDIT, READY_TO_SAVE }
