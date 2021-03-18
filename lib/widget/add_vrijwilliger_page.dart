import 'package:flutter/material.dart';
import 'package:wilde_tuinen/data/app_data.dart';
import 'package:wilde_tuinen/event/app_events.dart';
import 'package:wilde_tuinen/util/widget_utils.dart';

class AddVrijwilligerPage extends StatelessWidget {
  AddVrijwilligerPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Ngn200',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _AddVrijwilligerPage(),
    );
  }
}

// A screen that allows users to take a picture using a given camera.
class _AddVrijwilligerPage extends StatefulWidget {
  const _AddVrijwilligerPage({Key key}) : super(key: key);

  @override
  _AddVrijwilligerPageState createState() => _AddVrijwilligerPageState();
}

class _AddVrijwilligerPageState extends State<_AddVrijwilligerPage> {
  @override
  void initState() {
    super.initState();
    AppData.prepareGarden();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          WidgetUtils.verSpace(5),
          _inputField("Wie ", this._saveWie),
          WidgetUtils.verSpace(5),
          _inputField("Waar ", this._saveWaar),
          WidgetUtils.verSpace(5),
          _inputField("Wat ", this._saveWat),
          WidgetUtils.verSpace(5),
          _inputField("Postcode ", this._savePostcode),
          WidgetUtils.verSpace(5),
          _inputField("Geboorte jaar ", this._saveDob, numField:true),
          WidgetUtils.verSpace(5),
          _submitButton(),
          // _snackbar(context),
        ],
      ),
    );
  }

  
  Widget _inputField(String msg, Function func, {bool numField=false}) {
    return TextFormField(
      keyboardType: numField ? TextInputType.number : TextInputType.text,
      decoration: new InputDecoration(
        labelText: msg,
        fillColor: Colors.white,
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(5.0),
          borderSide: new BorderSide(),
        ),
        //fillColor: Colors.green
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Geef de (voor)naam';
        }
        return null;
      },
      onSaved: (val) => setState(() => func(val)),
    );
  }



  void _saveWie(val) => AppData.currentGarden.name = val; 
  void _saveWat(val) => AppData.currentGarden.description = val; 
  void _saveWaar(val) => AppData.currentGarden.waar = val; 
  void _savePostcode(val) => AppData.currentGarden.postCode = val; 
  void _saveDob(val) {
    if (val != null && val != "") {
      AppData.currentGarden.dob = int.parse(val);
    }
  }  

  Widget _submitButton() {
    return RaisedButton(
      onPressed: _onSubmit,
      child: Text(
        "Maak foto",
      ),
    );
  }

  void _onSubmit () {
    final form = _formKey.currentState;
    form.save();
    if (_formKey.currentState.validate()) {
      // Scaffold
      //     .of(context)
      //     .showSnackBar(SnackBar(content: Text('Processing Data')));

      AppEvents.fireTakePicture();
    }
  }
  // Padding _snackbar(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 16.0),
  //     child: RaisedButton(
  //       onPressed: () {
  //         if (_formKey.currentState.validate()) {
  //           Scaffold.of(context)
  //               .showSnackBar(SnackBar(content: Text('Processing Data')));
  //         }
  //       },
  //       child: Text('Submit'),
  //     ),
  //   );
  // }

}
