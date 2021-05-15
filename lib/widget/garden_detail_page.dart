import 'package:flutter/material.dart';
import 'package:wilde_tuinen/event/app_events.dart';
import 'package:wilde_tuinen/data/app_data.dart';
import 'package:wilde_tuinen/model/garden.dart';
import 'package:wilde_tuinen/widget/garden_form.dart';
import 'package:wilde_tuinen/widget/widget_helper.dart' as wh;
// import 'dart:developer';

class GardenDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _GardenDetailPage(),
    );
  }
}

class _GardenDetailPage extends StatefulWidget {
  @override
  _GardenDetailPageState createState() => _GardenDetailPageState();
}

//------------------

class _GardenDetailPageState extends State<_GardenDetailPage> {
  var _mode = MODUS.READ;
  Garden _garden = AppData().currentGarden;
  // bool _showAddNote = true;
  String _actionText = '+ Nieuwe aantekening';

  final _ctrl1 = TextEditingController();
  var _readOnly = true;
  var _actionEnabled = true;
  late BuildContext _context;

  _GardenDetailPageState() {
    AppEvents.onGardenSelected(_onGardenSelected);
  }

  _onGardenSelected(GardenSelectedEvent event) {
    setState(() {
      this._garden = AppData().currentGarden;
    });
  }

  @override
  void initState() {
    _ctrl1.addListener(_onTextChanged);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    return new Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return new AppBar(
      leading: _buildAction(),
      title: Text(AppData().currentGarden.name),
    );
  }

  Widget _buildAction() {
    return new IconButton(
      icon: Icon(Icons.west),
      onPressed: () {
        AppEvents.fireSwitchStack(STACK_HOME);
      },
    );
  }

  Widget _buildBody() {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: _buildTabHeaders(),
        body: TabBarView(
          children: [
            _buildAlgemeen(),
            _buildNotes(),
            _buildPhotos(),
          ],
        ),
      ),
    );
  }

  PreferredSize _buildTabHeaders() {
    return PreferredSize(
      preferredSize: Size.fromHeight(50.0),
      child: AppBar(
        automaticallyImplyLeading: false, // hides leading widget
        bottom: TabBar(
          tabs: [
            Tab(
              child: Text('Algemeen'),
            ),
            Tab(
              child: Text('Notes'),
            ),
            Tab(
              child: Text('Extra fotos'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlgemeen() {
    return GardenForm();
  }

  Widget _buildNotes() {
    return Column(
      children: [
        ListView.builder(
            shrinkWrap: true,
            itemCount: _garden.notes.length,
            itemBuilder: (BuildContext ctxt, int index) {
              Note note = _garden.notes[index];
              return _buildCard(note);
            }),
        wh.verSpace(10.0),
        _notesChilds(),
        _actionButton(context),
      ],
    );
  }

  Widget _notesChilds() {
    if (_mode != MODUS.READ) {
      return _noteInputField();
    } else {
      return new Container(height: 0.0);
    }
  }

  Widget _buildPhotos() {
    return Text('Todo');
  }

  Widget _buildCard(Note note) {
    String title = note.note;
    String subTtite = note.updatedBy;
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(title),
            subtitle: Text(subTtite),
          ),
        ],
      ),
    );
  }

  Widget _noteInputField() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: _inputField(_ctrl1, 'Note', 'Geef Note', 5),
    );
  }

  Widget _inputField(
      TextEditingController ctrl, String label, String errmsg, int maxLines) {
    return wh.buildIinputField(ctrl, label, errmsg, maxLines, _readOnly);
  }

  void _onActionClicked() {
    if (this._mode == MODUS.READY_TO_SAVE) {
      // ScaffoldMessenger.of(context).showSnackBar(_snackBar);
      Note note = new Note();
      note.lastupdated = null; // DateTime.now();
      note.updatedBy = 'me';
      note.note = _ctrl1.text;
      _garden.notes.add(note);

      // AppEvents.fireSaveGarden(_garden);
      _successMsg('Met succes opgeslagen');
    }
    this._setModus();
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
      _actionText = '+ Nieuwe aantekening';
    } else if (this._mode == MODUS.EDIT) {
      _readOnly = false;
      _actionEnabled = false;
      _actionText = 'Sla op';
    } else if (this._mode == MODUS.READY_TO_SAVE) {
      _readOnly = true;
      _actionEnabled = true;
      _actionText = '+ Nieuwe aantekening';
    }

    setState(() {});
  }

  void _onTextChanged() {
    if (_ctrl1.text.length > 0) {
      setState(() {
        this._actionEnabled = true;
        this._mode = MODUS.READY_TO_SAVE;
      });
    }
  }

  _successMsg(String msg) {
    final snackBar = SnackBar(
      content: Text(msg),
    );

    ScaffoldMessenger.of(_context).showSnackBar(snackBar);
  }
}

enum MODUS { READ, EDIT, READY_TO_SAVE }
