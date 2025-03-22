import 'package:enhanced_drop_down_example/person.dart';
import 'package:flutter/material.dart';
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
                    print("EDW the first name of the person chosen is: $chosen");
                  },
                  fieldToPresent: "firstName"),
              EnhancedDropDown.withData(
                  dropdownLabelTitle: "EDW With Data (String)",
                  dataSource: ["A", "B"],
                  defaultOptionText: "A",
                  valueReturned: (chosen) {
                    print("EDW the chosen value is: $chosen");
                  }),
              EnhancedDropDown.withEndpoint(
                  dropdownLabelTitle: "EDW With Endpoint (One Object)",
                  defaultOptionText: "Choose",
                  urlToFetchData: Uri.https("run.mocky.io",
                      "/v3/aceab7f3-ca9c-42f0-b63e-07dd501bb866"),
                  valueReturned: (chosen) {
                    print("EDW the chosen value is: $chosen");
                  }),
              EnhancedDropDown.withEndpoint(
                  dropdownLabelTitle:
                      "EDW With Endpoint Object (List of Objects)",
                  defaultOptionText: "Choose",
                  urlToFetchData: Uri.https("run.mocky.io",
                      "/v3/2d23072f-123c-4852-abb5-bc5e1668a415"),
                  valueReturned: (chosen) {
                    print("EDW the first name of the person chosen is: $chosen");
                  },
                  fieldToPresent: "firstName")
            ],
          ),
        ));
  }
}
