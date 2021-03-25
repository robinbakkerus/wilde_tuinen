import 'package:flutter/material.dart';
import 'package:wilde_tuinen/event/app_events.dart';
import 'package:wilde_tuinen/data/app_data.dart';

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
      var garden = AppData.currentGarden;
      _ctrl1.text = garden.name;
      _ctrl1.text = garden.description;
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
      child: TextFormField(
        controller: _ctrl1,
        decoration: InputDecoration(
            labelText: 'Naam.',
            hintText: "Enter text here",
            contentPadding: EdgeInsets.all(5.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            )),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Geef naam';
          }
          return null;
        },
      ),
    );
  }

Widget _descriptionField() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        controller: _ctrl1,
        maxLines: 10,
        decoration: InputDecoration(
            labelText: 'Omschrijving.',
            hintText: "Enter text here",
            contentPadding: EdgeInsets.all(10.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            )),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Geef omschrijving';
          }
          return null;
        },
      ),
    );
  }
}
