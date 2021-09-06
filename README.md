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

**Please be aware that currently, the parsing of the url is in JSON and only valid for key-value pairs that are in String format and type**


### Instantiating an EDW can be done in two ways:

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

2. The data source can be a list of items

```
 EnhancedDropDown.withData(
                dropdownLabelTitle: "My Things",
                dataSource: ["A", "B"],
                defaultOptionText: "Choose",
                valueReturned: (chosen) {
                   print(chosen);
               })
```

![Widget Screenshot 1](https://github.com/TomerPacific/enhanced_drop_down/blob/master/graphics/screenshot_1.png?raw=true)

![Widget Screenshot 2](https://github.com/TomerPacific/enhanced_drop_down/blob/master/graphics/screenshot_2.png?raw=true)