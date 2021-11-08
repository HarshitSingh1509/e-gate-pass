import 'package:e_gate_pass/Model/student_model.dart';
import 'package:e_gate_pass/Model/student_model_change.dart';
import 'package:e_gate_pass/login_page.dart';
import 'package:e_gate_pass/register_page.dart';
import 'package:e_gate_pass/request_list_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Widget/color_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var user = await FirebaseAuth.instance.currentUser;
  int a = user == null ? 0 : 1;
  runApp(MyApp(user));
}

class MyApp extends StatelessWidget {
  User? a;
  MyApp(this.a);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => StudentModelChange(),
        child: MaterialApp(
          title: 'E-GatePass',
          theme: ThemeData(
            canvasColor: colors.lightWhite,
            cardColor: colors.white,
            dialogBackgroundColor: colors.white,
            iconTheme:
                Theme.of(context).iconTheme.copyWith(color: Colors.black),
            primarySwatch: colors.primary_app,
            primaryColor: colors.lightWhite,
            fontFamily: 'Poppins',
            brightness: Brightness.light,
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => const LoginPage(),
            //      '/second': (context) =>  RequestListPage(student)
          },
        ));
  }
}
