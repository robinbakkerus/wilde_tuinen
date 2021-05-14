import 'package:flutter/material.dart';
import 'package:wilde_tuinen/event/app_events.dart';
import 'package:wilde_tuinen/data/app_data.dart';
import 'package:wilde_tuinen/model/garden.dart';
import 'package:wilde_tuinen/widget/garden_form.dart';
import 'package:wilde_tuinen/widget/widget_helper.dart' as wh;

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
  Garden _garden = AppData().currentGarden;
  bool _showAddNote = true;

  final _ctrl1 = TextEditingController();
  var _readOnly = true;

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        Container(
          height: 10,
        ),
        Container(
          color: Colors.amberAccent,
          height: 100,
          width: 400,
          child: Row(
            children: [
              _notesChilds(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _notesChilds() {
    if (this._showAddNote) {
      return wh.roundButton(
          Text(
            '+',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          _addNote);
    } else {
      return Row(
        children: [
          Container(
            height: 100,
            width: 250,
            child: _noteInputField(),
          ),
          wh.roundButton(Icon(Icons.save, size: 24.0), _dummy)
        ],
      );
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

  _addNote() {
    setState(() {
      this._showAddNote = !this._showAddNote;
      print('TODO nu ' + this._showAddNote.toString());
    });
  }

  _dummy() {
    setState(() {
      this._showAddNote = !this._showAddNote;
      print('TODO nu ' + this._showAddNote.toString());
    });
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
}
