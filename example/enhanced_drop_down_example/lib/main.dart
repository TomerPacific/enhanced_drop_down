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
      home: MyHomePage(title: 'Enhanced Dropdown Widget Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

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
    Uri.https("run.mocky.io","/v3/babc0845-8163-4f1e-80df-9bcabd3d4c43");
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
        title: Text(widget.title),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // EnhancedDropDown.withData(
            //     dropdownLabelTitle: "My Things",
            //     dataSource: ["A", "B"],
            //     defaultOptionText: "A",
            //     valueReturned: (chosen) {
            //       print(chosen);
            //     })
           EnhancedDropDown.withEndpoint(
            dropdownLabelTitle: "My Things",
            defaultOptionText: "Choose",
            urlToFetchData: Uri.https("run.mocky.io","/v3/babc0845-8163-4f1e-80df-9bcabd3d4c43"),
            valueReturned: (chosen) {
              print(chosen);
            })
      ],
      ),
      )
    );
  }
}