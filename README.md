# [Enhanced Dropdown Widget](https://pub.dev/packages/enhanced_drop_down#-readme-tab-) 

## With an overall score of 84!

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


### Instantiating an EDW is as follows:

```
new EnhancedDropDownWidget(
    dropdownLabelTitle: "Label",
    defaultOptionText: "Select One",
    urlToFetchData: "https://pub.dev/",
    dataSource: ["Option A", "Option B"],
    valueReturned: (chosen) {

      },
    )
```



