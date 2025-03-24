import 'package:enhanced_drop_down_example/person.dart';
import 'package:flutter/material.dart';
import 'package:enhanced_drop_down/enhanced_drop_down.dart';

void main() {
  runApp(MyApp());
}

const String ENDPOINT = "raw.githubusercontent.com";

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
                    Person("First", "Last", 10),
                    Person("Last", "First", 20)
                  ],
                  defaultOptionText: "Choose Person",
                  valueReturned: (chosenValue) {
                    print("EDW the chosen value is: $chosenValue");
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
                  urlToFetchData: Uri.https(
                      ENDPOINT,
                      "/TomerPacific/enhanced_drop_down/refs/heads/feature/refactor/example/enhanced_drop_down_example/person.json"),
                  valueReturned: (chosen) {
                    print("EDW the chosen value is: $chosen");
                  },
                  fieldToPresent: "firstName"),
              EnhancedDropDown.withEndpoint(
                  dropdownLabelTitle:
                      "EDW With Endpoint Object (List of Objects)",
                  defaultOptionText: "Choose",
                  urlToFetchData: Uri.https(ENDPOINT,
                      "/TomerPacific/enhanced_drop_down/refs/heads/feature/refactor/example/enhanced_drop_down_example/personList.json"),
                  valueReturned: (chosen) {
                    print("EDW the first name of the person chosen is: $chosen");
                  },
                  fieldToPresent: "firstName")
            ],
          ),
        ));
  }
}
