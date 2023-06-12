
import 'package:flutter/material.dart';

class UIProvider extends ChangeNotifier {
  bool _isVisibleInputsRegister = false;

  bool get isVisibleInpustRegister => _isVisibleInputsRegister;

  set isVisibleInpustRegister(bool value) {
    _isVisibleInputsRegister = value;
    notifyListeners();
  }
}