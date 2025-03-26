library enhanced_drop_down;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:io';

const CONTAINER_HEIGHT = 100.0;

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
  List<DropdownMenuItem<dynamic>> _dropDownItems = [];
  String _selectedDropDownMenuItem = "";

  @override
  void initState() {
    super.initState();
    _loadDataForDropdown();
  }

  @override
  Widget build(BuildContext context) {
    return _dropDownItems.isEmpty ?
      Container(
          height: CONTAINER_HEIGHT,
          child: Center(
            child: CircularProgressIndicator(),
          )
      )
    : Container(
        height: CONTAINER_HEIGHT,
        child: Column(
          children: <Widget>[
            Text(widget.dropdownLabelTitle, textDirection: TextDirection.ltr),
            DropdownButton<dynamic>(
                value: _selectedDropDownMenuItem.isEmpty? widget.defaultOptionText : _selectedDropDownMenuItem,
                items: _dropDownItems,
                onChanged: (value) {
                  _selectedDropDownMenuItem = value.toString();
                  widget.valueReturned(_selectedDropDownMenuItem);
                  setState(() {});
                })
          ],
        ));
  }

  /// Responsible for loading the data that the dropdown uses
  void _loadDataForDropdown() async {

    if (_isNoDataSourceSet(widget.urlToFetchData,widget.dataSource)) {
      throw Exception(
          "EnhancedDropDownWidget did you remember to pass in a datasource or an endpoint?");
    }

    _dropDownItems = const [];

    List<DropdownMenuItem<dynamic>> menuItems = [];

    //Adding default menu item
    _addMenuItem(menuItems, widget.defaultOptionText);

    if (_shouldFetchDataFromUrl(widget.urlToFetchData)) {
      _fetchAndParseData(widget.urlToFetchData!, menuItems)
          .then((parsedDropDownMenuItems) => setState(() {
                _dropDownItems = parsedDropDownMenuItems;
              }));
    } else if (_shouldGetDataFromDataSource(widget.dataSource)) {
      for (final dataSourceElement in widget.dataSource!) {
        String dropdownValue = _getDropdownValue(dataSourceElement, false);
        _addMenuItem(menuItems, dropdownValue);
      }

      setState(() {
        _dropDownItems = menuItems;
      });
    }
  }

  /// Responsible for fetching the data the dropdown uses and then parsing it
  Future<List<DropdownMenuItem<dynamic>>> _fetchAndParseData(
      Uri url, List<DropdownMenuItem<dynamic>> menuItems) async {
    try {
      var response = await http.get(url);
      if (response.statusCode == HttpStatus.ok) {
        dynamic jsonResponse = convert.jsonDecode(response.body);
        bool isListOfObjects = jsonResponse is List<dynamic>;
        if (isListOfObjects) {
          for (final item in jsonResponse) {
            String dropdownItemData = _getDropdownValue(item, isListOfObjects);
            _addMenuItem(menuItems, dropdownItemData);
          }
        } else if (jsonResponse is Map<String, dynamic>) {
            String dropdownItemData = _getDropdownValue(jsonResponse, isListOfObjects);
            _addMenuItem(menuItems, dropdownItemData);
        }
      } else {
        print(
            "EnhancedDropDownWidget Request failed with status: ${response.statusCode}.");
      }
    } catch (e) {
      print("EnhancedDropDownWidget error fetching data: $e");
    }

    return menuItems;
  }

  /// Used to correctly get a value from the data associated with the dropdown
  String _getDropdownValue(dynamic itemData, bool isElementPartOfList) {

    if (_isFieldToPresentSet(widget.fieldToPresent)) {
      return isElementPartOfList ?
      itemData[widget.fieldToPresent] :
      _getDropdownValueFromSingleElement(itemData);
    }

    try {
      return itemData as String;
    } catch (exception) {
      throw Exception(
          "EnhancedDropDownWidget did you use a data object and not supply a fieldToPresent?");
    }
  }

  void _addMenuItem(
      List<DropdownMenuItem<dynamic>> menuItems, String dropdownItemData) {
    menuItems.add(DropdownMenuItem(
      child: Text(dropdownItemData),
      value: dropdownItemData,
    ));
  }

  bool _shouldFetchDataFromUrl(Uri? url) {
    return url != null;
  }

  bool _shouldGetDataFromDataSource(List<dynamic>? dataSource) {
    return dataSource != null && dataSource.isNotEmpty;
  }

  bool _isFieldToPresentSet(String? fieldToPresent) {
    return fieldToPresent != null && fieldToPresent.isNotEmpty;
  }

  String _getDropdownValueFromSingleElement(dynamic itemData) {
    try {
      if (itemData is Map<String, dynamic>) {
        return itemData[widget.fieldToPresent];
      }

      Map<String, dynamic> item = itemData.toJson();
      return item[widget.fieldToPresent];
    } catch (exception) {
      throw Exception(
          "EnhancedDropDownWidget did you remember to implement toJson on your custom object?");
    }
  }

  bool _isNoDataSourceSet(Uri? urlToFetchData, List<dynamic>? dataSource) {
    return !_shouldFetchDataFromUrl(urlToFetchData) &&
        !_shouldGetDataFromDataSource(dataSource);
  }
}
