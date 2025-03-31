import 'package:enhanced_drop_down_example/person.dart';
import 'package:flutter/material.dart';
import 'package:enhanced_drop_down/enhanced_drop_down.dart';
import 'constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_TITLE,
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
          title: Align(alignment: Alignment.center,
                    child: Text(APP_TITLE,
                    style: TextStyle(fontSize: 20))
          )
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              EnhancedDropDown.withData(
                  dropdownLabelTitle: EDW_WITH_DATA_OBJECT_LABEL,
                  dataSource: [
                    Person("First", "Last", 10),
                    Person("Last", "First", 20)
                  ],
                  defaultOptionText: "Choose Person",
                  valueReturned: (chosenValue) {
                    print("EDW the chosen value is: $chosenValue");
                  },
                  fieldToPresent: FIRST_NAME_FIELD_KEY),
              EnhancedDropDown.withData(
                  dropdownLabelTitle: EDW_WITH_DATA_STRING_LABEL,
                  dataSource: ["A", "B"],
                  defaultOptionText: "Choose a letter",
                  valueReturned: (chosenValue) {
                    print("EDW the chosen value is: $chosenValue");
                  }),
              EnhancedDropDown.withEndpoint(
                  dropdownLabelTitle: EDW_WITH_ENDPOINT_OBJECT_LABEL,
                  defaultOptionText: "Choose a first name",
                  urlToFetchData: Uri.https(ENDPOINT, PERSON_PATH),
                  valueReturned: (chosenValue) {
                    print("EDW the chosen value is: $chosenValue");
                  },
                  fieldToPresent: FIRST_NAME_FIELD_KEY),
              EnhancedDropDown.withEndpoint(
                  dropdownLabelTitle: EDW_WITH_ENDPOINT_OBJECT_LIST_LABEL,
                  defaultOptionText: "Choose a first name",
                  urlToFetchData: Uri.https(ENDPOINT, PERSON_LIST_PATH),
                  valueReturned: (chosenValue) {
                    print(
                        "EDW the first name of the person chosen is: $chosenValue");
                  },
                  fieldToPresent: FIRST_NAME_FIELD_KEY),
              EnhancedDropDown.withEndpoint(
                  dropdownLabelTitle: EDW_WTH_ENDPOINT_DATA_STRING_LABEL,
                  defaultOptionText: "Choose a letter",
                  urlToFetchData: Uri.https(ENDPOINT, DATA_LIST_PATH),
                  valueReturned: (chosenValue) {
                    print("EDW the chosen value is: $chosenValue");
                  }),
            ],
          ),
        ));
  }
}
