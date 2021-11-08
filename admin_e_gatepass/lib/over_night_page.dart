import 'package:admin_e_gatepass/home_page.dart';
import 'package:flutter/material.dart';
import 'Model/admin_model_notifier.dart';
import 'Model/request_model.dart';
import 'Widget/color_info.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class OvrNightPage extends StatefulWidget {
  const OvrNightPage({Key? key}) : super(key: key);

  @override
  _OvrNightPageState createState() => _OvrNightPageState();
}

class _OvrNightPageState extends State<OvrNightPage> {
  DateFormat dateFormat = DateFormat("HH:mm:ss");
  DateFormat dateFormat1 = DateFormat("yyyy-MM-dd");
  DateFormat dateFormat3 = DateFormat("MMddHHmmss");
  List<Request> reqlist = [];
//  for (var i = 0; i < 10; i++) {}
//   List<Request> reqlist =[{name: parsedJson["name"],
//         rollno: parsedJson["rollno"],
//         id: parsedJson["id"],
//         to: parsedJson["to"],
//         datein: parsedJson["datein"],
//         dateout: parsedJson["dateout"],
//         isovernight: parsedJson["isovernight"],
//         document: parsedJson["document"],
//         status: parsedJson["status"],
//         livestatus: parsedJson["livestatus"],
//         approvedby: parsedJson["approvedby"],
//         permittedby: parsedJson["permittedby"],
//         timeout: parsedJson["timeout"],
//         timein: parsedJson["timein"],
//         reason: parsedJson["reason"]}]
  @override
  void initState() {
    getdata();
    // TODO: implement initState
    // for (var i = 0; i < 5; i++) {
    //   Map<String, dynamic> parsedjson = {
    //     "name": "Harshit",
    //     "rollno": "EPE19028",
    //     "id": "12345",
    //     "to": "Jais",
    //     "datein": "5/10/2021",
    //     "dateout": "5/10/2021",
    //     "isovernight": "0",
    //     "document": "document1",
    //     "status": "1",
    //     "livestatus": "3",
    //     "approvedby": "none",
    //     "permittedby": "Gaurd 1",
    //     "timeout": "12:38:50",
    //     "timein": "5:30:50",
    //     "reason": "food"
    //   };
    //   reqlist.add(Request.fromJson(
    //     parsedjson,
    //   ));
    // }
    // for (var i = 0; i < 5; i++) {
    //   Map<String, dynamic> parsedjson = {
    //     "name": "Harshit",
    //     "rollno": "EPE19028",
    //     "id": "12345",
    //     "to": "Sultanpur",
    //     "datein": "10/10/2021",
    //     "dateout": "5/10/2021",
    //     "isovernight": "1",
    //     "document": "document1",
    //     "status": "2",
    //     "livestatus": "2",
    //     "approvedby": "KGB",
    //     "permittedby": "Gaurd 1",
    //     "timeout": "12:38:50",
    //     "timein": "5:30:50",
    //     "reason": "food"
    //   };
    //   reqlist.add(Request.fromJson(
    //     parsedjson,
    //   ));
    // }
    super.initState();
  }

  List id = [];
  void getdata() async {
    if (Provider.of<AdminModelNotifier>(context, listen: false)
            .admininfo
            .canApproveOverNight ==
        true) {
      var response = FirebaseFirestore.instance
          .collection("GatePass")
          .where("isovernight", isEqualTo: true)
          .where("status", isEqualTo: 1)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          setState(() {
            id.add(element.id);
            reqlist
                .add(Request.fromJson(element.data() as Map<String, dynamic>));
          });
        });
      });
    }
  }

  static const List<IconData> icons = const [
    Icons.sms,
    Icons.mail,
    Icons.phone
  ];

  @override
  Widget build(BuildContext context) {
    print(reqlist.length);
    return Scaffold(
      body: ListView.builder(
          itemCount: reqlist.length,
          itemBuilder: (BuildContext context, int index) {
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
                                "Name",
                                style: TextStyle(color: colors.primary),
                              ),
                              Text(
                                reqlist[index].name,
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
                                "Roll No",
                                style: TextStyle(color: colors.primary),
                              ),
                              Text(
                                reqlist[index].rollno,
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
                                        ? "Not Permitted"
                                        : reqlist[index].status == 3
                                            ? "Outside The Campus"
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                              ? "On Time Entry"
                                              : "Late Entry",
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
                      TextButton(
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute<void>(
                            //     builder: (BuildContext context) => Home(),
                            //   ),
                            // );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 40,
                            width: 200,
                            child: Text("View Documents",
                                style: TextStyle(
                                    color: colors.white, fontSize: 20)),
                            decoration: BoxDecoration(
                              color: colors.primary,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                              onPressed: () {
                                print(reqlist[index].approvedby);
                                if (reqlist[index].approvedby.toString() ==
                                    "null") {
                                  print("I am here");
                                  FirebaseFirestore.instance
                                      .collection("GatePass")
                                      .doc(id[index])
                                      .set({
                                    "approvedby":
                                        Provider.of<AdminModelNotifier>(context,
                                                listen: false)
                                            .admininfo
                                            .name
                                  }, SetOptions(merge: true));
                                }
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) => Home(4),
                                  ),
                                );
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                width: 150,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.done,
                                      color: Colors.white,
                                    ),
                                    Text("Approve",
                                        style: TextStyle(
                                            color: colors.white, fontSize: 20)),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              )),
                          TextButton(
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection("GatePass")
                                    .doc(id[index])
                                    .set(
                                        {"status": 4}, SetOptions(merge: true));

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) => Home(3),
                                  ),
                                );
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                width: 150,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.cancel_outlined,
                                      color: Colors.white,
                                    ),
                                    Text("Reject",
                                        style: TextStyle(
                                            color: colors.white, fontSize: 20)),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              )),
                        ],
                      ),
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
  }
}
