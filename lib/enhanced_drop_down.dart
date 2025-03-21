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
      required this.valueReturned,
      this.fieldToPresent})
      : urlToFetchData = null;

  ///Constructor that accepts an endpoint in URI form to fetch the data from
  EnhancedDropDown.withEndpoint(
      {required this.dropdownLabelTitle,
      required this.defaultOptionText,
      required this.urlToFetchData,
      required this.valueReturned,
      this.fieldToPresent})
      : dataSource = null;

  /// Holds the default text to show when nothing is selected in the dropdown
  final String defaultOptionText;

  /// Holds the text in the label attached to the dropdown
  final String dropdownLabelTitle;

  /// The endpoint to fetch the data that gets used by the dropdown
  final Uri? urlToFetchData;

  /// A list which holds the data if we don't want to make a network request
  final List<dynamic>? dataSource;

  /// Represents the field name where data will be read from if you choose a Custom Object as the data source
  final String? fieldToPresent;

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
    menuItems.add(DropdownMenuItem(
      child: Text(_selected),
      value: _selected,
    ));

    if (widget.urlToFetchData != null) {
      _fetchAndParseData(widget.urlToFetchData!, menuItems)
          .then((value) => setState(() {
                _data = value;
              }));
    } else if (widget.dataSource != null) {
      for (int i = 0; i < widget.dataSource!.length; i++) {
        String dropdownValue = _getDropdownValue(widget.dataSource![i], false);
        menuItems.add(
            DropdownMenuItem(child: Text(dropdownValue), value: dropdownValue));
      }
      setState(() {
        _data = menuItems;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_data.isEmpty) {
      return Container();
    } else {
      return Container(
          height: 100,
          child: Column(
            children: <Widget>[
              Text(widget.dropdownLabelTitle, textDirection: TextDirection.ltr),
              DropdownButton<dynamic>(
                  value: _selected,
                  items: _data,
                  hint: Text(widget.defaultOptionText),
                  onChanged: (value) {
                    _selected = value.toString();
                    widget.valueReturned(_selected);
                    setState(() {});
                  })
            ],
          ));
    }
  }

  /// Responsible for fetching the data the dropdown uses and then parsing it
  Future<List<DropdownMenuItem<dynamic>>> _fetchAndParseData(
      Uri url, List<DropdownMenuItem<dynamic>> menuItems) async {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      dynamic jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse is List<dynamic>) {
        for (final item in jsonResponse) {
          String dropdownItemData = _getDropdownValue(item, true);
          menuItems.add(DropdownMenuItem(
            child: Text(dropdownItemData),
            value: dropdownItemData,
          ));
        }
      } else if (jsonResponse is Map<String, dynamic>) {
        jsonResponse.forEach((key, value) {
          String dropdownItemData = _getDropdownValue(value, false);
          menuItems.add(DropdownMenuItem(
            child: Text(dropdownItemData),
            value: dropdownItemData,
          ));
        });
      }
    } else {
      print(
          "EnhancedDropDownWidget Request failed with status: ${response.statusCode}.");
    }

    return menuItems;
  }

  /// Used to correctly get a value from the data associated with the dropdown
  String _getDropdownValue(dynamic itemData, bool isElementPartOfList) {
    String dropdownValue;
    if (widget.fieldToPresent != null) {
      if (isElementPartOfList) {
        dropdownValue = itemData[widget.fieldToPresent];
      } else {
        try {
          Map<String, dynamic> item = itemData.toJson();
          dropdownValue = item[widget.fieldToPresent];
        } catch (error) {
          throw Exception(
              "EnhancedDropDownWidget did you remember to implement toJson on your custom object?");
        }
      }
    } else {
      dropdownValue = itemData;
    }

    return dropdownValue;
  }
}
