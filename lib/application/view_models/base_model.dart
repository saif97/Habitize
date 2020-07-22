// base_model.dart
import 'package:flutter/material.dart';

enum Model2State { busy, idle }

class BaseModel extends ChangeNotifier {
  Model2State _currentState = Model2State.idle;

  @protected
  void setModelState(Model2State modelState) {
    if (_currentState == modelState) return;

    _currentState = modelState;
    notifyListeners();
  }

  @protected
  void setDefualtState(Model2State modelState) => _currentState = modelState;

  void resetState() => setModelState(Model2State.idle);

  Model2State get currentState => _currentState;
}
