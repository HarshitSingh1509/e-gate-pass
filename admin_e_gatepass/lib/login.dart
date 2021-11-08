import 'dart:convert';

import 'package:admin_e_gatepass/Model/admin_model.dart';
import 'package:admin_e_gatepass/Model/admin_model_notifier.dart';
import 'package:admin_e_gatepass/home_page.dart';
import 'package:flutter/material.dart';
import 'Widget/SizeConfig.dart';
import 'Widget/color_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  Login();

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('Admins');
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.2), BlendMode.dstATop),
            image: const AssetImage("assets/logo.png"),
            fit: BoxFit.fitWidth,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                const SizedBox(
                  height: 40,
                ),
                SizedBox(height: SizeConfig.screenHeight! * 0.30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: TextFormField(
                          controller: email,
                          textAlign: TextAlign.center,
                          // keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Email*",
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
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(),
                      child: SizedBox(
                        child: TextFormField(
                            controller: pass,
                            decoration: InputDecoration(
                              labelText: "Password*",
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
                  ],
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 250,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => Home(0),
                        ),
                      );
                    },
                    child: GestureDetector(
                      onTap: () async {
                        print("here");
                        if (_formKey.currentState!.validate()) {
                          try {
                            print(email.text);
                            UserCredential credential = await FirebaseAuth
                                .instance
                                .signInWithEmailAndPassword(
                                    email: email.text, password: pass.text);
                            var result =
                                (await users.doc(email.text).get()).data();
                            var gaurd = (result as Map<String, dynamic>);
                            print(gaurd);
                            AdminModel am = AdminModel.fromJson(gaurd);
                            Provider.of<AdminModelNotifier>(context,
                                    listen: false)
                                .setmodel(am);
                            Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) => Home(0),
                                ));
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              print('No user found for that email.');
                            } else if (e.code == 'wrong-password') {
                              print('Wrong password provided for that user.');
                            } else {
                              print(e.code);
                            }
                          }
                        } else {
                          print("ohhh");
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 300,
                        child: Text("Submit",
                            style:
                                TextStyle(color: colors.white, fontSize: 20)),
                        decoration: BoxDecoration(
                          color: colors.primary,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
