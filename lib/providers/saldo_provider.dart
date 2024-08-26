import 'package:flutter/material.dart';

class SaldoProvider with ChangeNotifier {
  double _saldo = 350000; // Saldo inicial

  double get saldo => _saldo;

  void depositar(double monto) {
    _saldo += monto;
    notifyListeners();
  }

  void retirar(double monto) {
    if (monto <= _saldo) {
      _saldo -= monto;
      notifyListeners();
    } else {
      // Aquí podrías mostrar un mensaje de error indicando saldo insuficiente
    }
  }

  void transferir(double monto) {
    if (monto <= _saldo) {
      _saldo -= monto;
      notifyListeners();
    } else {
      // Aquí podrías mostrar un mensaje de error indicando saldo insuficiente
    }
  }

  void reiniciarSaldo() {
    _saldo = 350000; // Reinicia el saldo al monto inicial cuando se cierra la aplicación
    notifyListeners();
  }
}
