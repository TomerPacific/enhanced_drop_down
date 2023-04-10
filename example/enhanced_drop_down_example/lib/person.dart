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