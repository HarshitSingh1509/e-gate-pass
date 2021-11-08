import 'package:admin_e_gatepass/Model/admin_model_notifier.dart';
import 'package:flutter/material.dart';
import 'admin_model_notifier.dart';

class AdminModel {
  String name;
  String post;
  bool canApprove;
  bool canApproveOverNight;
  bool canPermit;
  AdminModel(this.name, this.canApprove, this.canApproveOverNight,
      this.canPermit, this.post);
  factory AdminModel.fromJson(Map<String, dynamic> parsedJson) {
    return AdminModel(
      parsedJson["Name"],
      parsedJson["canApprove"],
      parsedJson["canApproveOvernight"],
      parsedJson["canPermit"],
      parsedJson["Post"],
    );
  }

  // AdminModel _admininfo = AdminModel("", false, false, false, "");
  // AdminModel get admininfo {
  //   return _admininfo;
  // }

  // void setmodel(AdminModel adminmodel) {
  //   _admininfo = adminmodel;
  //   notifyListeners();
  // }
}
