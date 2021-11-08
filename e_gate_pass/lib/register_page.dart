import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_gate_pass/Widget/SizeConfig.dart';
import 'package:e_gate_pass/Widget/color_info.dart';
import 'package:e_gate_pass/request_list_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Model/student_model.dart';
import 'Model/student_model_change.dart';

class Register extends StatefulWidget {
  UserCredential credential;
  Register({required this.credential});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  Map<String, dynamic> parsed = {};
  final _formKey = GlobalKey<FormState>();
  TextEditingController ph1 = TextEditingController();
  TextEditingController ph2 = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController pph1 = TextEditingController();
  TextEditingController pph2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('Student');
    SizeConfig().init(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              const SizedBox(
                height: 40,
              ),
              const Text(
                "Complete Your Profile",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              SizedBox(height: 80),
              Padding(
                padding: const EdgeInsets.only(),
                child: SizedBox(
                  child: TextFormField(
                      controller: ph1,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Your Phone Number 1*",
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Color(0xFF054c88),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Color(0xFF054c88),
                            width: 2.0,
                          ),
                        ),
                      )),
                  width: SizeConfig.screenWidth! * 0.7,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(),
                child: SizedBox(
                  child: TextFormField(
                      controller: ph2,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Your Phone Number 2",
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Color(0xFF054c88),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Color(0xFF054c88),
                            width: 2.0,
                          ),
                        ),
                      )),
                  width: SizeConfig.screenWidth! * 0.7,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(),
                child: SizedBox(
                  child: TextFormField(
                      controller: address,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: "Hostel Address",
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Color(0xFF054c88),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Color(0xFF054c88),
                            width: 2.0,
                          ),
                        ),
                      )),
                  width: SizeConfig.screenWidth! * 0.7,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(),
                child: SizedBox(
                  child: TextFormField(
                      controller: pph1,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Parent Number 1*",
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Color(0xFF054c88),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Color(0xFF054c88),
                            width: 2.0,
                          ),
                        ),
                      )),
                  width: SizeConfig.screenWidth! * 0.7,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(),
                child: SizedBox(
                  child: TextFormField(
                      controller: pph2,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Parent Number 2",
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Color(0xFF054c88),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Color(0xFF054c88),
                            width: 2.0,
                          ),
                        ),
                      )),
                  width: SizeConfig.screenWidth! * 0.7,
                ),
              ),
              SizedBox(
                height: 80,
              ),
              TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      users
                          .doc(widget
                              .credential.additionalUserInfo!.profile!["email"])
                          .set({
                        'name': widget
                            .credential.additionalUserInfo!.profile!["name"],
                        'email': widget
                            .credential.additionalUserInfo!.profile!["email"],
                        'rollno': widget
                            .credential.additionalUserInfo!.profile!["email"],
                        'phone1': ph1.text,
                        'phone2': ph2.text,
                        'parentphone1': pph1.text,
                        'parentphone2': pph2.text,
                        'hosteladdress': address.text
                      }).then((value) {
                        parsed = {
                          "name": widget
                              .credential.additionalUserInfo!.profile!["name"],
                          "email": widget
                              .credential.additionalUserInfo!.profile!["email"],
                          "rollno": widget
                              .credential.additionalUserInfo!.profile!["email"],
                          'phone1': ph1.text,
                          'phone2': ph2.text,
                          'parentphone1': pph1.text,
                          'parentphone2': pph2.text,
                          'hosteladdress': address.text
                        };
                        Student student = Student.fromJson(parsed);

                        Provider.of<StudentModelChange>(context, listen: false)
                            .setUser(student);

                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                RequestListPage(student),
                          ),
                        );
                      }).catchError(
                              (error) => print("Failed to add user: $error"));
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 300,
                    child: Text("Submit",
                        style: TextStyle(color: colors.white, fontSize: 20)),
                    decoration: BoxDecoration(
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
