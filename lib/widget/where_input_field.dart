import 'package:flutter/material.dart';
import 'package:wilde_tuinen/data/suggestions.dart';
import 'package:wilde_tuinen/util/flutter_typeahead.dart';

class WhereInputField extends StatelessWidget {
  const WhereInputField({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _WhereInputField(),
    );
  }
}

class _WhereInputField extends StatefulWidget {
  _WhereInputField({Key key}) : super(key: key);

  @override
  __WhereInputFieldState createState() => __WhereInputFieldState();
}

//-----------------------------------------------------------------------------
class __WhereInputFieldState extends State<_WhereInputField> {
// final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _typeAheadController = TextEditingController();

  String selectedText;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: this._onTapped,
        child: new Container(
            width: 500.0,
            padding: new EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 40.0),
            color: Colors.yellowAccent,
            child: Container(
              child: Text("$selectedText"),
              height: 50,
            )));
  }

  void _onTapped() {
    print('Tap ...');
    this._typeAheadController.text = "";
    showDialog(
        context: context,
        builder: (context) {
          return Scaffold(
            body: Column(
              children: <Widget>[
                _typeAhead(),
                Container(
                  child: FlatButton(
                      onPressed: () {
                        this._save();
                        _dismissDialog(context);
                      },
                      child: Text('Selecteer')),
                ),
              ],
            ),
          );
        });
  }

  void _save() {
    setState(() {
      this.selectedText = _typeAheadController.text;
    });
  }
  Widget _typeAhead() {
    return TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
          controller: this._typeAheadController,
          decoration: InputDecoration(labelText: 'City')),
      suggestionsCallback: (pattern) {
        return CitiesService.getSuggestions(pattern);
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          title: Text(suggestion),
        );
      },
      transitionBuilder: (context, suggestionsBox, controller) {
        return suggestionsBox;
      },
      onSuggestionSelected: (suggestion) {
        this._typeAheadController.text = suggestion;
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'Please select a city';
        } else {
          return "";
        }
      },
      onSaved: (value) => print(value),
    );
  }

  _dismissDialog(context) {
    Navigator.of(context).pop();
  }
}
