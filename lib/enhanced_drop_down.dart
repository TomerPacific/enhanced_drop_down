library enhanced_drop_down;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class EnhancedDropDown extends StatefulWidget {
  final ValueChanged<String> valueReturned;

  EnhancedDropDown(
      {required Key key,
      this.dropdownLabelTitle: "",
      required this.dataSource,
      this.defaultOptionText: "",
      this.urlToFetchData: "",
      required this.valueReturned})
      : super(key: key);

  /// Holds the default text to show when nothing is selected in the dropdown
  final String defaultOptionText;

  /// Holds the text in the label attached to the dropdown
  final String dropdownLabelTitle;

  /// The endpoint to fetch the data that gets used by the dropdown
  final String urlToFetchData;

  /// A list which holds the data received from the endpoint
  final List<String> dataSource;

  @override
  _EnhancedDropDownState createState() => _EnhancedDropDownState();
}

class _EnhancedDropDownState extends State<EnhancedDropDown> {
  List<DropdownMenuItem<String>> _data = [];
  String _selected = "";

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  /// Fetches the data that the dropdown uses from the endpoint
  void _loadData() async {
    _data = [];
    if (widget.urlToFetchData.isNotEmpty) {
      var url = Uri.https(widget.urlToFetchData, "");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
        List<DropdownMenuItem<String>> menuItems = [];
        jsonResponse.forEach((key, value) {
          menuItems.add(new DropdownMenuItem(
            child: new Text(value.toString()),
            value: value.toString(),
          ));
        });
        setState(() {
          _data = menuItems;
        });
      } else {
        print("Request failed with status: ${response.statusCode}.");
      }
    } else {
      for (int i = 0; i < widget.dataSource.length; i++) {
        _data.add(new DropdownMenuItem(
          child: new Text(widget.dataSource[i]),
          value: widget.dataSource[i],
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_data.length == 0) {
      return new Container();
    } else {
      return new Scaffold(
          body: new Column(
        children: <Widget>[
          new Text(widget.dropdownLabelTitle, textDirection: TextDirection.ltr),
          DropdownButton(
              value: _selected,
              items: _data,
              hint: new Text(widget.defaultOptionText),
              onChanged: (value) {
                _selected = value as String;
                widget.valueReturned(_selected);
                setState(() {});
              })
        ],
      ));
    }
  }
}
