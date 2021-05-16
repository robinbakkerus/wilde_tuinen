import 'package:flutter/material.dart';

TextFormField buildIinputField(TextEditingController ctrl, String label,
    bool readOnly, {int maxLines = 1} ) {
  return TextFormField(
    readOnly: readOnly,
    controller: ctrl,
    decoration: InputDecoration(
        labelText: label,
        contentPadding: EdgeInsets.all(5.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        )),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return  label + ' is verplicht';
      }
      return null;
    },
    maxLines: maxLines,
  );
}

Widget roundButton(Widget childWidget, Function onPres) {
  return MaterialButton(
    color: Colors.blue,
    shape: CircleBorder(),
    onPressed: () => onPres(),
    child: Padding(
      padding: const EdgeInsets.all(4),
      child: childWidget,
    ),
  );
}

Widget verSpace(double h) {
  return Container(
    height: h,
  );
}

void successMsg(String msg, BuildContext context) {
  final snackBar = SnackBar(
    content: Text(msg),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
