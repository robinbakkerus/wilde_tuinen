import 'package:flutter/material.dart';

Widget buildIinputField(
    TextEditingController ctrl, String label, String errmsg, int maxLines) {
  return TextFormField(
      controller: ctrl,
      decoration: InputDecoration(
          labelText: label,
          contentPadding: EdgeInsets.all(5.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          )),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errmsg;
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
