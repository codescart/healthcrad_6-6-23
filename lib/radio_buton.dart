import 'package:flutter/material.dart';

class radio_button extends StatefulWidget {
  @override
  _radio_buttonState createState() => _radio_buttonState();
}

class _radio_buttonState extends State<radio_button> {
  var _selectedRadio;

  void _handleRadioValueChange(var value) {
    setState(() {
      _selectedRadio = value;
    });
  }

  @override
  void initState() {
    _selectedRadio = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Text("Select your favorite animal:"),
              RadioListTile(
                value: 0,
                groupValue: _selectedRadio,
                title: Text("Cat"),
                onChanged: _handleRadioValueChange,
              ),
              RadioListTile(
                value: 1,
                groupValue: _selectedRadio,
                title: Text("Dog"),
                onChanged: _handleRadioValueChange,
              ),
              RadioListTile(
                value: 2,
                groupValue: _selectedRadio,
                title: Text("Fish"),
                onChanged: _handleRadioValueChange,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
