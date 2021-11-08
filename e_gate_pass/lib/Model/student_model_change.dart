import 'package:e_gate_pass/Model/student_model.dart';
import 'package:flutter/cupertino.dart';

class StudentModelChange with ChangeNotifier {
  Student _s = Student(
    hosteladdress: "",
    email: '',
    name: '',
    parentphone1: '',
    parentphone2: '',
    phone1: '',
    phone2: '',
    rollno: '',
  );

  Student get student {
    return _s;
  }

  void setUser(Student student) {
    _s = student;
    print(student.name);
    notifyListeners();
  }

  Future<Student> getstudent() async {
    return _s;
  }
}
