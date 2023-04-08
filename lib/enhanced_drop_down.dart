library enhanced_drop_down;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class EnhancedDropDown extends StatefulWidget {
  final ValueChanged<dynamic> valueReturned;

  ///Constructor that accepts a list of elements to be the data source for the dropdown
  EnhancedDropDown.withData(
      {required this.dropdownLabelTitle,
      required this.dataSource,
      required this.defaultOptionText,
      required this.valueReturned})
      : urlToFetchData = null, fieldToPresent = null;

  ///Constructor that accepts an endpoint in URI form to fetch the data from
  EnhancedDropDown.withEndpoint(
      {required this.dropdownLabelTitle,
      required this.defaultOptionText,
      required this.urlToFetchData,
      required this.valueReturned})
      : dataSource = null, fieldToPresent = null;

  EnhancedDropDown.withDataObject(
  {required this.dropdownLabelTitle,
    required this.defaultOptionText,
    required this.dataSource,
    required this.valueReturned,
    required this.fieldToPresent,
  }): urlToFetchData = null;

  /// Holds the default text to show when nothing is selected in the dropdown
  final String defaultOptionText;

  /// Holds the text in the label attached to the dropdown
  final String dropdownLabelTitle;

  /// The endpoint to fetch the data that gets used by the dropdown
  final Uri? urlToFetchData;

  /// A list which holds the data if we don't want to make a network request
  final List<dynamic>? dataSource;

  final dynamic fieldToPresent;

  @override
  _EnhancedDropDownState createState() => _EnhancedDropDownState();
}

class _EnhancedDropDownState extends State<EnhancedDropDown> {
  List<DropdownMenuItem<dynamic>> _data = [];
  String _selected = "Chosen Value";

  @override
  void initState() {
    super.initState();
    _loadDataForDropdown();
  }

  /// Responsible for loading the data that the dropdown uses
  void _loadDataForDropdown() async {
    _data = const [];

    List<DropdownMenuItem<dynamic>> menuItems = [];
    menuItems.add(new DropdownMenuItem(
      child: new Text(_selected),
      value: _selected,
    ));

    if (widget.urlToFetchData != null) {
      var response = await http.get(widget.urlToFetchData!);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
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
        print(
            "EnhancedDropDownWidget Request failed with status: ${response.statusCode}.");
      }
    } else if (widget.dataSource != null) {
      for (int i = 0; i < widget.dataSource!.length; i++) {
        String dropdownValue = _getDropdownValue(widget.dataSource![i]);
        menuItems.add(
            new DropdownMenuItem(
                child:
                  new Text(dropdownValue),
                value:  dropdownValue)
        );
      }
      setState(() {
        _data = menuItems;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_data.length == 0) {
      return new Container();
    } else {
      return new Container(
          height: 100,
          child: new Column(
            children: <Widget>[
              new Text(widget.dropdownLabelTitle,
                  textDirection: TextDirection.ltr),
              DropdownButton<dynamic>(
                  value: _selected,
                  items: _data,
                  hint: new Text(widget.defaultOptionText),
                  onChanged: (value) {
                    _selected = value.toString();
                    widget.valueReturned(_selected);
                    setState(() {});
                  })
            ],
          ));
    }
  }

  String _getDropdownValue(dynamic itemData) {
    String dropdownValue;
    if (widget.fieldToPresent != null) {
      try {
        Map<String, dynamic> item = itemData.toJson();
        dropdownValue = item[widget.fieldToPresent];
      } catch (error) {
        throw Exception("EnhancedDropDownWidget did you remember to implement toJson on your custom object?");
      }
    } else {
      dropdownValue = itemData;
    }

    return dropdownValue;
  }
}
