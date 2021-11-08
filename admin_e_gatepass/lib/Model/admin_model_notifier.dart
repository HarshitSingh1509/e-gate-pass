import 'package:admin_e_gatepass/Model/admin_model.dart';
import 'package:flutter/material.dart';

class AdminModelNotifier with ChangeNotifier {
  // ignore: non_constant_identifier_names
  AdminModel _admininfo = AdminModel("", false, false, false, "");
  AdminModel get admininfo {
    return _admininfo;
  }

  void setmodel(AdminModel adminmodel) {
    _admininfo = adminmodel;
    notifyListeners();
  }
}
