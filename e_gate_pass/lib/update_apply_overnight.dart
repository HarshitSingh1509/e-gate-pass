import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_gate_pass/Model/student_model.dart';
import 'package:e_gate_pass/request_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';

import 'Model/request_model.dart';
import 'Model/student_model_change.dart';
import 'Widget/SizeConfig.dart';
import 'Widget/color_info.dart';
import 'package:intl/intl.dart';

class UpdateApplyOverNight extends StatefulWidget {
  String id;
  String gateid;
  UpdateApplyOverNight(this.id, this.gateid);

  @override
  _UpdateApplyOverNightState createState() => _UpdateApplyOverNightState();
}

class _UpdateApplyOverNightState extends State<UpdateApplyOverNight> {
  DateTime startdate = DateTime.now();
  DateTime enddate = DateTime.now();
  DateTime timeout = DateTime.now();
  DateTime timein = DateTime.now();
  TextEditingController place = TextEditingController();
  TextEditingController purpose = TextEditingController();
  bool isLoading = true;
  late Request req;
  @override
  void initState() {
    // TODO: implement initState
    getpass();
    super.initState();
  }

  void getpass() async {
    print("I am here");
    await FirebaseFirestore.instance
        .collection('GatePass')
        .doc(widget.id)
        .get()
        .then((value) {
      setState(() {
        req = Request.fromJson(value.data() as Map<String, dynamic>);
        print(req.id);
        isLoading = false;
        print(isLoading);
      });
    });
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference pass = firestore.collection('GatePass');
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    DateFormat dateFormat3 = DateFormat("MMddHHmmss");
    Student student =
        Provider.of<StudentModelChange>(context, listen: false).student;
    SizeConfig().init(context);
    return isLoading
        ? Center(
            child: SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(),
          ))
        : Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      "Apply for Over Night E-GatePass",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    const SizedBox(height: 80),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Name"),
                                Text(student.name,
                                    style: TextStyle(
                                        color: colors.primary, fontSize: 20))
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("  Id"),
                                Text(
                                    dateFormat3
                                        .format(DateTime.parse(widget.gateid))
                                        .toString(),
                                    style: TextStyle(
                                        color: colors.primary, fontSize: 12))
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(),
                      child: SizedBox(
                        child: TextFormField(
                            controller: place,
                            // keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Place*",
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: Color(0xFF054c88),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: Color(0xFF054c88),
                                  width: 2.0,
                                ),
                              ),
                            )),
                        width: SizeConfig.screenWidth! * 0.7,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("  Date Out*"),
                            TextButton(
                                onPressed: () {
                                  // DatePicker.showDatePicker(context,
                                  //     showTitleActions: true,
                                  //     minTime: DateTime.now(),
                                  //     maxTime: DateTime(2022, 6, 7),
                                  //     theme: DatePickerTheme(
                                  //         headerColor: Colors.orange,
                                  //         backgroundColor: Colors.blue,
                                  //         itemStyle: TextStyle(
                                  //             color: Colors.white,
                                  //             fontWeight: FontWeight.bold,
                                  //             fontSize: 18),
                                  //         doneStyle: TextStyle(
                                  //             color: Colors.white,
                                  //             fontSize: 16)), onChanged: (date) {
                                  //   print('change $date in time zone ' +
                                  //       date.timeZoneOffset.inHours.toString());
                                  // }, onConfirm: (date) {
                                  //   print('confirm $date');

                                  //   setState(() {
                                  //     startdate = date;
                                  //   });
                                  // },
                                  //     currentTime: DateTime.now(),
                                  //     locale: LocaleType.en);
                                },
                                child: Text(
                                  '${DateFormat('yyyy-MM-dd').format(req.dateout)}',
                                  style: TextStyle(
                                      color: colors.primary, fontSize: 25),
                                )),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("  Date In*"),
                            TextButton(
                                onPressed: () {
                                  DatePicker.showDatePicker(context,
                                      showTitleActions: true,
                                      minTime: req.datein,
                                      maxTime: DateTime(2022, 6, 7),
                                      theme: DatePickerTheme(
                                          headerColor: Colors.orange,
                                          backgroundColor: Colors.blue,
                                          itemStyle: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                          doneStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16)),
                                      onChanged: (date) {
                                    print('change $date in time zone ' +
                                        date.timeZoneOffset.inHours.toString());
                                  }, onConfirm: (date) {
                                    print('confirm $date');

                                    setState(() {
                                      enddate = date;
                                    });
                                  },
                                      currentTime: DateTime.now(),
                                      locale: LocaleType.en);
                                },
                                child: Text(
                                  '${DateFormat('yyyy-MM-dd').format(enddate)}',
                                  style: TextStyle(
                                      color: colors.primary, fontSize: 25),
                                )),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("  Time Out*"),
                            TextButton(
                                onPressed: () {
                                  // DatePicker.showTimePicker(context,
                                  //     showTitleActions: true, onChanged: (date) {
                                  //   print('change $date in time zone ' +
                                  //       date.timeZoneOffset.inHours.toString());
                                  // }, onConfirm: (date) {
                                  //   print('confirm $date');
                                  //   setState(() {
                                  //     timeout = date;
                                  //   });
                                  // }, currentTime: DateTime.now());
                                },
                                child: Text(
                                  '${DateFormat.jms().format(req.timeout)}',
                                  style: TextStyle(
                                      color: colors.primary, fontSize: 20),
                                )),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("  Time In*"),
                            TextButton(
                                onPressed: () {
                                  DatePicker.showTimePicker(context,
                                      showTitleActions: true,
                                      onChanged: (date) {
                                    print('change $date in time zone ' +
                                        date.timeZoneOffset.inHours.toString());
                                  }, onConfirm: (date) {
                                    print('confirm $date');
                                    setState(() {
                                      timein = date;
                                    });
                                  }, currentTime: DateTime.now());
                                },
                                child: Text(
                                  '${DateFormat.jms().format(timein)}',
                                  style: TextStyle(
                                      color: colors.primary, fontSize: 20),
                                )),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(),
                      child: SizedBox(
                        child: TextFormField(
                            controller: purpose,
                            maxLines: 3,
                            decoration: InputDecoration(
                              labelText: "Purpose",
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: Color(0xFF054c88),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: Color(0xFF054c88),
                                  width: 2.0,
                                ),
                              ),
                            )),
                        width: SizeConfig.screenWidth! * 0.7,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: <Widget>[
                        Text("Upload Supporting Documents"),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      RequestListPage(student),
                                ),
                              );
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: 150,
                              child: Text("Upload",
                                  style: TextStyle(
                                      color: colors.white, fontSize: 20)),
                              decoration: const BoxDecoration(
                                color: colors.primary,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    TextButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (req.timein.difference(timein).inHours < 0) {
                              pass.doc(widget.id).set({
                                'to': place.text,
                                'isovernight': true,
                                'document': null,
                                'status': 1,
                                'livestatus': 3,
                                'approvedby': null,
                                'permittedby': null,
                                'reason': purpose.text,
                                'updateddatein': enddate,
                                'updatedtimein': timein,
                                'isupdatedpass': true
                              }, SetOptions(merge: true)).then(
                                  (value) => Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              RequestListPage(student),
                                        ),
                                      ));
                            }
                            print(timeout.difference(timein).inHours);
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: 300,
                          child: Text("Submit",
                              style:
                                  TextStyle(color: colors.white, fontSize: 20)),
                          decoration: const BoxDecoration(
                            color: colors.primary,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ),
          );
  }
}
