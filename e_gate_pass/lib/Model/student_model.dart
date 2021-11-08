import 'package:flutter/material.dart';

class Student with ChangeNotifier {
  String name;
  String email;
  String rollno;
  String phone1;
  String phone2;
  String parentphone1;
  String parentphone2;
  String hosteladdress;
  Student({
    required this.name,
    required this.email,
    required this.rollno,
    required this.hosteladdress,
    required this.parentphone1,
    required this.parentphone2,
    required this.phone1,
    required this.phone2,
  });

  factory Student.fromJson(Map<String, dynamic> parsedJson) {
    bool isFav = false;

    return Student(
        name: parsedJson["name"],
        rollno: parsedJson["rollno"],
        email: parsedJson["email"],
        phone1: parsedJson["phone1"],
        phone2: parsedJson["phone2"],
        parentphone1: parsedJson["parentphone1"],
        parentphone2: parsedJson["parentphone2"],
        hosteladdress: parsedJson["hosteladdress"]);
  }
}
