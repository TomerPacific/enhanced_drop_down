


class Person {

  final String FIRST_NAME_KEY = "firstName";
  final String LAST_NAME_KEY = "lastName";
  final String AGE_KEY = "age";

  String firstName = "";
  String lastName = "";
  int age = 0;

  Person(String _firstName, String _lastName, int _age) {
    firstName = _firstName;
    lastName = _lastName;
    age = _age;
  }

  Person.fromJson(Map<String, dynamic> json) {
    firstName = json[FIRST_NAME_KEY];
    lastName = json[LAST_NAME_KEY];
    age = json[AGE_KEY];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[FIRST_NAME_KEY] = firstName;
    data[LAST_NAME_KEY] = lastName;
    data[AGE_KEY] = age;
    return data;
  }
}
