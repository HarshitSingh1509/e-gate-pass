import 'package:flutter/material.dart';

class Request with ChangeNotifier {
  String name;
  DateTime id;
  String to;
  // String from;
  DateTime dateout;
  DateTime datein;
  DateTime timein;
  DateTime timeout;
  bool isovernight;
  String document;
  int status; //1 requested 2 done 3 ongoing 4 cancelled
  int livestatus; // 1 ontime 2 late 3 no live
  String approvedby;
  String permittedby;
  String reason;
  String rollno;
  DateTime updatedtimein;
  DateTime updateddatein;
  bool isupdatedpass; // String vendor;
  // bool isFavorite;
  // String discPercentage;
// String
//   String email;
//   String number;

  Request(
      {required this.name,
      required this.id,
      required this.rollno,
      required this.to,
      required this.datein,
      required this.dateout,
      required this.isovernight,
      required this.document,
      required this.status,
      required this.livestatus,
      required this.approvedby,
      required this.permittedby,
      required this.timeout,
      required this.timein,
      required this.reason,
      required this.isupdatedpass,
      required this.updateddatein,
      required this.updatedtimein});

  factory Request.fromJson(Map<String, dynamic> parsedJson) {
    bool isFav = false;
    // for (int i = 0; i < favorite.length; i++) {

    //   if (favorite[i]["food"].toString() == parsedJson["id"].toString()) {
    //     isFav = true;
    //     break;
    //   }
    // }

    return Request(
        name: parsedJson["name"],
        rollno: parsedJson["rollno"],
        id: parsedJson["id"].toDate(),
        to: parsedJson["to"],
        datein: parsedJson["datein"].toDate(),
        dateout: parsedJson["dateout"].toDate(),
        isovernight: parsedJson["isovernight"],
        document: parsedJson["document"],
        status: parsedJson["status"],
        livestatus: parsedJson["livestatus"],
        approvedby: parsedJson["approvedby"],
        permittedby: parsedJson["permittedby"],
        timeout: parsedJson["timeout"].toDate(),
        timein: parsedJson["timein"].toDate(),
        reason: parsedJson["reason"],
        updateddatein: parsedJson["updateddatein"].toDate(),
        updatedtimein: parsedJson["updatedtimein"].toDate(),
        isupdatedpass: parsedJson["isupdatedpass"]);
  }
  // void increaseAge() {
  //   this.age++;
  //   notifyListeners();
  // }
}
