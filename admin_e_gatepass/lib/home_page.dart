import 'package:admin_e_gatepass/Widget/color_info.dart';
import 'package:admin_e_gatepass/active_page.dart';
import 'package:admin_e_gatepass/history_page.dart';
import 'package:admin_e_gatepass/late_page.dart';
import 'package:admin_e_gatepass/profile_page.dart';
import 'package:admin_e_gatepass/request_pass.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'over_night_page.dart';

class Home extends StatefulWidget {
  int selectedindex;
  Home(this.selectedindex);

  @override
  _HomeState createState() => _HomeState(selectedindex);
}

class _HomeState extends State<Home> {
  int selectedindex;
  _HomeState(this.selectedindex);

  bool isLoading = true;
  static const List<Widget> _widgetOptions = <Widget>[
    HistoryPage(),
    LatePage(),
    ActivePage(),
    RequestPass(),
    OvrNightPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedindex = index;
    });
  }

  @override
  void initState() {
    setlate();
    // TODO: implement initState
    super.initState();
  }

  void setlate() async {
    var response = FirebaseFirestore.instance
        .collection("GatePass")
        .where("status", whereIn: [3])
        .get()
        .then((value) {
          value.docs.forEach((element) {
            var data = element.data() as Map<String, dynamic>;
            print((DateTime.parse(data["timein"].toDate().toString()))
                .compareTo(DateTime.now()));
            if ((DateTime.parse(data["timein"].toDate().toString()))
                    .compareTo(DateTime.now()) <
                0) {
              print((DateTime.parse(data["timein"].toDate().toString())));
              FirebaseFirestore.instance
                  .collection("GatePass")
                  .doc(element.id)
                  .set({"livestatus": 2}, SetOptions(merge: true));
            }
          });
        });
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin E- Gate Pass'),
        backgroundColor: colors.primary,
        actions: <Widget>[
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => Profile(),
                  ),
                );
              },
              child: Icon(Icons.person)),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: isLoading
          ? Center(
              child: SizedBox(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(),
            ))
          : Center(
              child: _widgetOptions.elementAt(selectedindex),
            ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.history),
                title: Text('History'),
                backgroundColor: Colors.grey),
            BottomNavigationBarItem(
                icon: Icon(Icons.snooze),
                title: Text('Late'),
                backgroundColor: Colors.red),
            BottomNavigationBarItem(
              icon: Icon(Icons.timelapse),
              title: Text('Active'),
              backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.description),
                title: Text('Request'),
                backgroundColor: Colors.orange),
            BottomNavigationBarItem(
                icon: Icon(Icons.cottage),
                title: Text('Over Night'),
                backgroundColor: Colors.blue),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: selectedindex,
          selectedItemColor: Colors.black,
          iconSize: 40,
          onTap: _onItemTapped,
          elevation: 5),
    );
  }
}
