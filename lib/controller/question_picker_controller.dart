import 'package:flutter/material.dart';

class QuestionPickerController extends ChangeNotifier {
  void hidePicker() {
    notifyListeners();
  }
}
