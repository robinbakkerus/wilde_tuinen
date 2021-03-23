import 'package:flutter/material.dart';
import 'package:wilde_tuinen/event/app_events.dart';
import 'package:wilde_tuinen/data/app_data.dart';

class Choice {
  const Choice(
      {required this.title, required this.icon, required this.stackIndex});
  final String title;
  final IconData icon;
  final int stackIndex;
}

/// see enum in StackIndex
const List<Choice> choices = const <Choice>[
  const Choice(title: '/home', icon: Icons.home, stackIndex: STACK_HOME),
  const Choice(
      title: '/add_vrijwilliger', icon: Icons.input, stackIndex: STACK_ADD),
  const Choice(
      title: '/admin', icon: Icons.access_alarm, stackIndex: STACK_ADMIN),
];

AppBar buildMainAppBar(BuildContext context, int disableButton) {
  
  void _select(Choice choice) {
    AppEvents.fireSwitchStack(StackType.START_PAGE, choice.stackIndex);
  }

  bool _isButtonDisabled(int n) => n == disableButton;

  IconButton _buildButton(int n) {
    return new IconButton(
      icon: Icon(choices[n].icon),
      onPressed: _isButtonDisabled(n)
          ? null
          : () {
              _select(choices[n]);
            },
    );
  }

  return new AppBar(
    title: new Text('Wilde tuinen'),
    actions: <Widget>[
      _buildButton(0),
      _buildButton(1),
      _buildButton(2),
      PopupMenuButton<Choice>(
        onSelected: _select,
        itemBuilder: (BuildContext context) {
          return choices.skip(2).map((Choice choice) {
            return PopupMenuItem<Choice>(
              value: choice,
              child: Text(choice.title),
            );
          }).toList();
        },
      ),
    ],
  );
}
