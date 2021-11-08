import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_gate_pass/apply_local.dart';
import 'package:e_gate_pass/apply_overnight.dart';
import 'package:e_gate_pass/update_apply_overnight.dart';
import 'package:e_gate_pass/update_applylocal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Model/student_model.dart';
import 'Model/student_model_change.dart';
import 'Widget/color_info.dart';

class TypeofPassUpdate extends StatefulWidget {
  String id;
  String gateid;
  TypeofPassUpdate(this.id, this.gateid);

  @override
  _TypeofPassUpdateState createState() => _TypeofPassUpdateState();
}

class _TypeofPassUpdateState extends State<TypeofPassUpdate> {
  bool isovernight = false;
  bool islocal = false;
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference pass = firestore.collection('GatePass');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.background,
        foregroundColor: Colors.black,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text("Type of Pass"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: SizedBox(
              width: 350,
              height: 350,
              child: Center(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Overnight",
                              style: TextStyle(fontSize: 20),
                            ),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (isovernight) {
                                      islocal = true;
                                    } else {
                                      islocal = false;
                                    }
                                    isovernight = !isovernight;
                                  });
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.black,
                                  radius: 12,
                                  child: Center(
                                    child: Icon(Icons.circle_rounded,
                                        color: isovernight
                                            ? colors.primary
                                            : colors.white),
                                  ),
                                ))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Local",
                              style: TextStyle(fontSize: 20),
                            ),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (islocal == true) {
                                      isovernight = true;
                                    } else {
                                      isovernight = false;
                                    }
                                    islocal = !islocal;
                                  });
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.black,
                                  radius: 12,
                                  child: Center(
                                    child: Icon(Icons.circle_rounded,
                                        color: islocal
                                            ? colors.primary
                                            : colors.white),
                                  ),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          TextButton(
              onPressed: () {
                int typeofpass = islocal ? 1 : 2;
                if (typeofpass == 1) {
                  pass.doc(widget.id).set({
                    'isovernight': false,
                  }, SetOptions(merge: true)).then(
                      (value) => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    UpdateApplyLocal(widget.id, widget.gateid)),
                          ));
                  // var id = DateTime.now();
                  // Student student =
                  //     Provider.of<StudentModelChange>(context, listen: false)
                  //         .student;
                  // print(DateTime);
                  // pass.add({
                  //   'name': student.name,
                  //   'rollno': student.rollno,
                  //   'id': DateTime.now(),
                  //   'to': "",
                  //   'datein': DateTime.parse("2021-01-01"),
                  //   'dateout': DateTime.parse("2021-01-01"),
                  //   'isovernight': false,
                  //   'document': null,
                  //   'status': 4,
                  //   'livestatus': 3,
                  //   'approvedby': null,
                  //   'permittedby': null,
                  //   'timeout': DateTime.parse("2021-01-01"),
                  //   'timein': DateTime.parse("2021-01-01"),
                  //   'reason': "",
                  //   'updateddatein': DateTime.now(),
                  //   'updatedtimein': DateTime.now(),
                  //   'isupdatedpass': false
                  // }).then((value) => Navigator.pushReplacement(
                  //       context,
                  //       MaterialPageRoute<void>(
                  //         builder: (BuildContext context) =>
                  //             ApplyLocal(value.id, id.toString()),
                  //       ),
                  //     ));
                  // 'to': 'parsedJson["to"]',
                  // 'datein': parsedJson["datein"],
                  // 'dateout': parsedJson["dateout"],
                  // 'isovernight': parsedJson["isovernight"],
                  // 'document': parsedJson["document"],
                  // 'status': parsedJson["status"],
                  // 'livestatus': parsedJson["livestatus"],
                  // 'approvedby': parsedJson["approvedby"],
                  // 'permittedby': parsedJson["permittedby"],
                  // 'timeout': parsedJson["timeout"],
                  // 'timein': parsedJson["timein"],
                  // 'reason': parsedJson["reason"],
                  // 'updateddatein': parsedJson["updateddatein"],
                  // 'updatedtimein': parsedJson["updatedtimein"],
                  // 'isupdatedpass': parsedJson["isupdatedpass"]

                } else {
                  Student student =
                      Provider.of<StudentModelChange>(context, listen: false)
                          .student;
                  pass.doc(widget.id).set({
                    'isovernight': true,
                  }, SetOptions(merge: true)).then((value) =>
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                UpdateApplyOverNight(widget.id, widget.gateid)),
                      ));

                  // var id = DateTime.now();
                  // print(DateTime);
                  // pass.add({
                  //   'name': student.name,
                  //   'rollno': student.rollno,
                  //   'id': id,
                  //   'to': "",
                  //   'datein': DateTime.parse("2021-01-01"),
                  //   'dateout': DateTime.parse("2021-01-01"),
                  //   'isovernight': false,
                  //   'document': null,
                  //   'status': 4,
                  //   'livestatus': 3,
                  //   'approvedby': null,
                  //   'permittedby': null,
                  //   'timeout': DateTime.parse("2021-01-01"),
                  //   'timein': DateTime.parse("2021-01-01"),
                  //   'reason': "",
                  //   'updateddatein': DateTime.now(),
                  //   'updatedtimein': DateTime.now(),
                  //   'isupdatedpass': false
                  // }).then((value) => Navigator.pushReplacement(
                  //       context,
                  //       MaterialPageRoute<void>(
                  //         builder: (BuildContext context) =>
                  //             ApplyOverNight(value.id, id.toString()),
                  //       ),
                  //     ));
                }
              },
              child: Container(
                height: 50,
                width: 300,
                child: Center(
                  child: Text(
                    "Next",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                decoration: BoxDecoration(
                    color: colors.primary,
                    borderRadius: BorderRadius.circular(25)),
              ))
        ],
      ),
    );
  }
}
