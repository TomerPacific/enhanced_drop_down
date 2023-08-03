# [Enhanced Dropdown Widget](https://pub.dev/packages/enhanced_drop_down#-readme-tab-) 

A completely customizable drop down widget, which wraps a label and a dropdown widget together into one component.

## Usage

To use this package add ```enhanced_drop_down``` as a [dependency in your pubspec.yaml file](https://flutter.dev/docs/development/packages-and-plugins/using-packages)..

## API
An Enhanced Dropdown Widget (or EDW), is based on flutter's dropdown widget, but enhances it in the following manner:

- Attached to the dropdown is a label, to help point out to the user what values the dropdown might have

- You can pass in the data source from where the dropdown will get its values

- You can pass a default value to be the visible choice when the dropdown is not selected

- You want to know what choice the user made, so a callback function must be supplied to get the user's choice back

- In case you are relying on an external source to provide the data for the dropdown, you can pass in the url to fetch that data
    - This data can be one object with many fields
    - Or a list of objects

## Instantiating an EDW can be done in two ways:

1. The data source can be an endpoint (of Uri type)

```
EnhancedDropDown.withEndpoint(
            dropdownLabelTitle: "My Things",
            defaultOptionText: "Choose",
            urlToFetchData: Uri.https("run.mocky.io","/v3/babc0845-8163-4f1e-80df-9bcabd3d4c43"),
            valueReturned: (chosen) {
              print(chosen);
            })
```

2. The data source can be a list of items (of String type)

```
 EnhancedDropDown.withData(
                dropdownLabelTitle: "My Things",
                dataSource: ["A", "B"],
                defaultOptionText: "Choose",
                valueReturned: (chosen) {
                   print(chosen);
               })
```

## Working With A Custom Object As The Data Source

If you want to use a custom object as your data for the EDW, **you must**:

    - Implement the toJson and fromJson methods inside of your class (see person.dart for reference)
    
        - If not, an exception will be thrown when parsing the data for the EDW

        > E/flutter (14555): [ERROR:flutter/runtime/dart_vm_initializer.cc(41)] Unhandled Exception: Exception: EnhancedDropDownWidget did you remember to implement toJson on your custom object?

    - Pass in the desired field (in String form) to show in the dropdown using fieldToPresent

```
EnhancedDropDown.withData(
                dropdownLabelTitle: "EDW With Data Object",
                dataSource: [new Person("First", "Last", 10),
                              new Person("Last", "First", 20)],
                defaultOptionText: "Choose Person",
                valueReturned: (chosen) {
                  print(chosen);
                },
                fieldToPresent: "firstName")
```

You can see the implementation of Person inside the example project (and below):

```
class Person {
  String firstName;
  String lastName;
  int age;

  Person(String _firstName, String _lastName, int _age) {
    firstName = _firstName;
    lastName = _lastName;
    age = _age;
  }

  Person.fromJson(Map<String, dynamic> json) {
    firstName = json["firstName"];
    lastName = json["lastName"];
    age = json["age"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["firstName"] = firstName;
    data["lastName"] = lastName;
    data["age"] = age;
    return data;
  }
}

```

![Widget Screenshot 1](https://github.com/TomerPacific/enhanced_drop_down/blob/master/graphics/screenshot_1.png?raw=true)

![Widget Screenshot 2](https://github.com/TomerPacific/enhanced_drop_down/blob/master/graphics/screenshot_2.png?raw=true)

![Widget Screenshot 3](https://github.com/TomerPacific/enhanced_drop_down/blob/master/graphics/screenshot_3.png?raw=true)

![Widget Screenshot 4](https://github.com/TomerPacific/enhanced_drop_down/blob/master/graphics/screenshot_4.png?raw=true)

![Widget Screenshot 5](https://github.com/TomerPacific/enhanced_drop_down/blob/master/graphics/screenshot_5.png?raw=true)