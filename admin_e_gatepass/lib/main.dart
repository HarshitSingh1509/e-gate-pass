import 'package:admin_e_gatepass/Model/admin_model.dart';
import 'package:admin_e_gatepass/Model/admin_model_notifier.dart';
import 'package:admin_e_gatepass/Widget/color_info.dart';
import 'package:admin_e_gatepass/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import '';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => AdminModelNotifier(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: colors.primary_app,
      ),
      home: Login(),
    );
  }
}
