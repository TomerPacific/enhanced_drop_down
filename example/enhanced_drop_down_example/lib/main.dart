import 'package:enhanced_drop_down_example/person.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:enhanced_drop_down/enhanced_drop_down.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Enhanced Dropdown Widget Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  void fetchData() async {
    var url =
        Uri.https("run.mocky.io", "/v3/babc0845-8163-4f1e-80df-9bcabd3d4c43");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      var items = jsonResponse['totalItems'];
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Enhanced Dropdown Widget Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              EnhancedDropDown.withData(
                  dropdownLabelTitle: "EDW With Data Object",
                  dataSource: [
                    new Person("First", "Last", 10),
                    new Person("Last", "First", 20)
                  ],
                  defaultOptionText: "Choose Person",
                  valueReturned: (chosen) {
                    print(chosen);
                  },
                  fieldToPresent: "firstName"),
              EnhancedDropDown.withData(
                  dropdownLabelTitle: "EDW With Data (String)",
                  dataSource: ["A", "B"],
                  defaultOptionText: "A",
                  valueReturned: (chosen) {
                    print(chosen);
                  }),
              EnhancedDropDown.withEndpoint(
                  dropdownLabelTitle: "EDW With Endpoint (One Object)",
                  defaultOptionText: "Choose",
                  urlToFetchData: Uri.https("run.mocky.io",
                      "/v3/aceab7f3-ca9c-42f0-b63e-07dd501bb866"),
                  valueReturned: (chosen) {
                    print(chosen);
                  }),
              EnhancedDropDown.withEndpoint(
                  dropdownLabelTitle:
                      "EDW With Endpoint Object (List of Objects)",
                  defaultOptionText: "Choose",
                  urlToFetchData: Uri.https("run.mocky.io",
                      "/v3/2d23072f-123c-4852-abb5-bc5e1668a415"),
                  valueReturned: (chosen) {
                    print(chosen);
                  },
                  fieldToPresent: "firstName")
            ],
          ),
        ));
  }
}
