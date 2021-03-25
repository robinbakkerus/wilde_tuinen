import 'package:flutter/material.dart';
import 'package:wilde_tuinen/event/app_events.dart';
import 'package:wilde_tuinen/data/app_data.dart';
import 'package:wilde_tuinen/model/garden.dart';
import 'package:wilde_tuinen/widget/garden_form.dart';

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
  Garden _garden = AppData.currentGarden;

  _GardenDetailPageState() {
    AppEvents.onGardenSelected(_onGardenSelected);
  }

  _onGardenSelected(GardenSelectedEvent event) {
    setState(() {
      this._garden = AppData.currentGarden;
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
      title: Text(AppData.currentGarden.name),
    );
  }

  Widget _buildAction() {
    return new IconButton(
      icon: Icon(Icons.west),
      onPressed: () {
        AppEvents.fireSwitchStack(StackType.MAIN, 0);
      },
    );
  }

  Widget _buildBody() {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: _buildTabs(),
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

  PreferredSize _buildTabs() {
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
              child: Text('Fotos'),
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
    return new ListView.builder(
        itemCount: _garden.notes.length,
        itemBuilder: (BuildContext ctxt, int index) {
          Note note = _garden.notes[index];
          return _buildCard(note);
        });
  }

  Widget _buildPhotos() {
    return Text('Todo');
  }

  Widget _buildCard(Note note) {
    String msg = 'note.note';
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const ListTile(
            leading: Icon(Icons.album, size: 50),
            title: Text(msg),
            subtitle: Text('TWICE'),
          ),
        ],
      ),
    );
  }
}
