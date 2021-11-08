import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_gate_pass/Model/student_model.dart';
import 'package:e_gate_pass/Model/student_model_change.dart';
import 'package:e_gate_pass/type_of_pass.dart';
import 'package:e_gate_pass/typeof_pass_update.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'Widget/color_info.dart';
import 'Model/request_model.dart';
import 'dart:math';
import 'package:intl/intl.dart';

class RequestListPage extends StatefulWidget {
  Student student;
  RequestListPage(this.student);

  @override
  _RequestListPageState createState() => _RequestListPageState();
}

class _RequestListPageState extends State<RequestListPage>
    with TickerProviderStateMixin {
  DateFormat dateFormat = DateFormat("HH:mm:ss");
  DateFormat dateFormat1 = DateFormat("yyyy-MM-dd");
  DateFormat dateFormat3 = DateFormat("MMddHHmmss");

  late Student student = Student(
      email: '',
      hosteladdress: '',
      name: '',
      parentphone1: '',
      parentphone2: '',
      phone1: '',
      phone2: '',
      rollno: '');
  List<Request> reqlist = [];
  List<bool> applyforlate = [];
  List<String> id = [];
  StudentModelChange sc = StudentModelChange();

  CollectionReference firestore =
      FirebaseFirestore.instance.collection('GatePass');

  @override
  void initState() {
    super.initState();
    loadlist();

    print(reqlist);
  }

  void loadlist() async {
    await FirebaseFirestore.instance
        .collection('GatePass')
        .where("rollno", isEqualTo: widget.student.email)
        .orderBy("timeout", descending: true)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        setState(() {
          id.add(element.id);
          reqlist.add(Request.fromJson(element.data() as Map<String, dynamic>));
        });
      });
    });
    for (int i = 0; i < reqlist.length; i++) {
      print(reqlist[i].timeout.compareTo(DateTime.now()));
      if (reqlist[i].timeout.compareTo(DateTime.now()) < 0 &&
          reqlist[i].status == 3) {
        applyforlate.add(true);
      } else {
        applyforlate.add(false);
      }
    }
  }

  static const List<IconData> icons = const [
    Icons.sms,
    Icons.mail,
    Icons.phone
  ];

  @override
  Widget build(BuildContext context) {
    setState(() {
      student = Provider.of<StudentModelChange>(context, listen: false).student;
    });

    return Consumer<StudentModelChange>(builder: (context, data, child) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("E - Gatepass"),
          // title: Text("${data.student.name}"),
          leading: IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                await GoogleSignIn().signOut();
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back)),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          // isExtended: true,
          child: Icon(Icons.add),
          backgroundColor: colors.primary,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => TypeofPass(),
              ),
            );
          },
        ),
        body: ListView.builder(
            itemCount: reqlist.length,
            itemBuilder: (BuildContext context, int index) {
              print(applyforlate[index]);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "To",
                                  style: TextStyle(color: colors.primary),
                                ),
                                Text(
                                  reqlist[index].to,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Gate Pass No.",
                                  style: TextStyle(color: colors.primary),
                                ),
                                Text(
                                  dateFormat3.format(reqlist[index].id),
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Date Out",
                                  style: TextStyle(color: colors.primary),
                                ),
                                Text(
                                  dateFormat1.format(reqlist[index].dateout),
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Date in",
                                  style: TextStyle(color: colors.primary),
                                ),
                                Text(
                                  dateFormat1.format(reqlist[index].datein),
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Out Time",
                                  style: TextStyle(color: colors.primary),
                                ),
                                Text(
                                  dateFormat.format(reqlist[index].timeout),
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "In Time",
                                  style: TextStyle(color: colors.primary),
                                ),
                                Text(
                                  dateFormat.format(reqlist[index].timein),
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Purpose",
                                  style: TextStyle(color: colors.primary),
                                ),
                                Text(
                                  reqlist[index].reason,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Status",
                                  style: TextStyle(color: colors.primary),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      reqlist[index].status == 1
                                          ? "Kindly go to gate for permission"
                                          : reqlist[index].status == 3
                                              ? "You are outside the campus"
                                              : reqlist[index].status == 2
                                                  ? "Reached back"
                                                  : "Cancelled",
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        reqlist[index].livestatus != 3
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Remark",
                                        style: TextStyle(color: colors.primary),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            reqlist[index].livestatus == 1
                                                ? "You are on time"
                                                : "You are late",
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : Container(),
                        SizedBox(
                          height: 5,
                        ),
                        applyforlate[index]
                            ? TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          TypeofPassUpdate(id[index],
                                              reqlist[index].id.toString()),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 40,
                                  width: 120,
                                  child: Center(
                                    child: const Text(
                                      "Apply for Update",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  color: colors.primary,
                                ))
                            : Container(),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      );
    });
  }
}
