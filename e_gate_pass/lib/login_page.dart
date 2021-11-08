import 'dart:convert';
import 'dart:developer';
import 'package:e_gate_pass/Model/student_model.dart';
import 'package:e_gate_pass/Model/student_model_change.dart';
import 'package:e_gate_pass/Widget/SizeConfig.dart';
import 'package:e_gate_pass/Widget/color_info.dart';
import 'package:e_gate_pass/register_page.dart';
import 'package:e_gate_pass/request_list_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Login/auth_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Map<String, dynamic> parsed = {};
  AuthMethods auth = AuthMethods();
  StudentModelChange sc = StudentModelChange();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference users;
  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    users = firestore.collection('Student');

    User? user = FirebaseAuth.instance.currentUser;
    String? email = user!.email;
    print(user);
    if (user.email.toString() != "null") {
      await users.doc(email).get().then((DocumentSnapshot documentSnapshot) {
        Student student =
            Student.fromJson((documentSnapshot.data() as Map<String, dynamic>));
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => RequestListPage(student),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: Container(
        alignment: Alignment.bottomCenter,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.2), BlendMode.dstATop),
            image: const AssetImage("assets/logo.png"),
            fit: BoxFit.fitWidth,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: SizeConfig.screenHeight! * 0.5 - 50,
            ),
            Text(
              "E - Gate Pass",
              style: TextStyle(
                  color: colors.primary,
                  fontSize: 50,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 250,
            ),
            GestureDetector(
              onTap: () async {
                UserCredential credential = await auth.signInWithGoogle();
                log(credential.toString());
                print(credential.additionalUserInfo!.profile!["hd"]);
                if (credential.additionalUserInfo!.profile!["hd"].toString() ==
                    "rgipt.ac.in") {
                  parsed = {
                    "name": credential.additionalUserInfo!.profile!["name"],
                    "email": credential.additionalUserInfo!.profile!["email"],
                    "rollno": credential.additionalUserInfo!.profile!["email"],
                  };
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setString('Person', jsonEncode(parsed));
                  Student student = Student.fromJson(parsed);
                  print(student.name);
                  users
                      .doc(credential.additionalUserInfo!.profile!["email"])
                      .set(
                    {
                      'name': credential.additionalUserInfo!.profile!["name"],
                      'email': credential.additionalUserInfo!.profile!["email"],
                      'rollno':
                          credential.additionalUserInfo!.profile!["email"],
                    },
                    SetOptions(merge: true),
                  ).then((value) {
                    Provider.of<StudentModelChange>(context, listen: false)
                        .setUser(student);
                    if (credential.additionalUserInfo!.isNewUser == true) {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => Register(
                            credential: credential,
                          ),
                        ),
                      );
                    } else {
                      users
                          .doc(credential.additionalUserInfo!.profile!["email"])
                          .get()
                          .then((DocumentSnapshot documentSnapshot) {
                        Student student = Student.fromJson(
                            (documentSnapshot.data() as Map<String, dynamic>));
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                RequestListPage(student),
                          ),
                        );
                      });
                    }
                  }).catchError((error) => print("Failed to add user: $error"));
                }
              },
              child: SizedBox(
                width: 70,
                height: 70,
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Image(image: AssetImage("assets/glogo.png")),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            )
          ],
        ) /* add child content here */,
      ),
    );
  }
}
