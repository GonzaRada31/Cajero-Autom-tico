import 'package:flutter/material.dart';
import 'package:atm_simulator/styles/styles.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:atm_simulator/providers/saldo_provider.dart';
//import 'package:atm_simulator/screens/menu_principal.dart';

class DepositarDineroScreen extends StatefulWidget {
  const DepositarDineroScreen({super.key});

  @override
  DepositarDineroScreenState createState() => DepositarDineroScreenState();
}

class DepositarDineroScreenState extends State<DepositarDineroScreen> {
  final TextEditingController _importeController = TextEditingController();

  void _procesarDeposito() {
    final saldoProvider = Provider.of<SaldoProvider>(context, listen: false);
    final importe = double.tryParse(_importeController.text);

    if (importe != null && importe > 0) {
      _mostrarDialogoProcesando();

      Timer(const Duration(seconds: 3), () {
        if (mounted) {
          Navigator.of(context).pop(); // Cierra el diálogo de procesamiento
          saldoProvider.depositar(importe);
          _mostrarDialogoExito(saldoProvider.saldo);
        }
      });
    } else {
      _mostrarDialogoError();
    }
  }

  void _mostrarDialogoProcesando() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      animType: AnimType.scale,
      body: const Center(
        child: CircularProgressIndicator(),
      ),
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
    ).show();
  }

  void _mostrarDialogoExito(double nuevoSaldo) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      title: 'Depósito Exitoso',
      desc: 'Has depositado \$${_importeController.text}. Tu saldo actual es \$${nuevoSaldo.toStringAsFixed(2)}.',
      btnOkOnPress: () {
        Navigator.pop(context);
      },
    ).show();
  }

  void _mostrarDialogoError() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.bottomSlide,
      title: 'Error',
      desc: 'Importe inválido.',
      btnOkOnPress: () {},
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomHeader(title: 'Depositar Dinero'),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: AppStyles.fondoGradiente,
        child: Column(
          children: [
            AppStyles.logoSizedBox(height: 130),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Ingresa el monto a depositar',
                style: AppStyles.textoEncabezado,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: TextField(
                controller: _importeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Monto',
                  hintStyle: AppStyles.inputHintStyle,
                  filled: true,
                  fillColor: Color.fromARGB(255, 255, 255, 255),
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(fontSize: 24, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _procesarDeposito,
              style: AppStyles.primaryButton,
              child: const Text('Confirmar'),
            ),
          ],
        ),
      ),
    );
  }
}
