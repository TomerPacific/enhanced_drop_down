import 'package:flutter/material.dart';
import 'package:enhanced_drop_down/enhanced_drop_down.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(key: UniqueKey(), title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({required Key key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String _selected = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Requesting Location Permission'),
        ),
        body:Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: new EnhancedDropDown(
                  key: UniqueKey(),
                  dropdownLabelTitle: "Label",
                  defaultOptionText: "Select One",
                  urlToFetchData: "https://pub.dev/",
                  dataSource: ["Option A", "Option B"],
                  valueReturned: (chosen) {
                    _selected = chosen;
                    print(_selected);
                  },
                ),
              )]
        )
    );
  }
}