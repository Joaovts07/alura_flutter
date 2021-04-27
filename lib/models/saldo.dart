import 'package:flutter/cupertino.dart';

class Saldo extends ChangeNotifier {
  double value;

  Saldo(this.value);

  void add(double value) {
    this.value += value;
    notifyListeners();
  }
  void subtract(double value){
    this.value -= value;
    notifyListeners();
  }

  @override
  String toString() {
    return 'R\$ $value';
  }
}
