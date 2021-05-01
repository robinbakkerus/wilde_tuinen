import 'package:flutter/material.dart';
import 'package:wilde_tuinen/event/app_events.dart';
import 'package:wilde_tuinen/data/app_data.dart';
import 'package:wilde_tuinen/widget/widget_helper.dart' as wh;

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

  final _formKey = GlobalKey<FormState>();
  final _ctrl1 = TextEditingController();
  final _ctrl2 = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  _onGardenSelected(GardenSelectedEvent event) {
    setState(() {
      var garden = AppData().currentGarden;
      _ctrl1.text = garden.name;
      _ctrl2.text = garden.description;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _nameField(),
          _descriptionField(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _nameField() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: _inputField(_ctrl1, 'Naam', 'Geef naam', 1),
    );
  }

  Widget _descriptionField() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: _inputField(_ctrl2, 'Omschrijving', 'Geef Omschrijving', 5),
    );
  }

  Widget _inputField(TextEditingController ctrl, String label, String errmsg, int maxLines) {
    return wh.buildIinputField(ctrl, label, errmsg, maxLines);
  }
}
