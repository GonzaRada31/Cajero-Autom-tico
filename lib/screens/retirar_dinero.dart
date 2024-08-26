import 'package:flutter/material.dart';
import 'package:atm_simulator/styles/styles.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:atm_simulator/providers/saldo_provider.dart';

class RetirarDineroScreen extends StatefulWidget {
  const RetirarDineroScreen({super.key});

  @override
  RetirarDineroScreenState createState() => RetirarDineroScreenState();
}

class RetirarDineroScreenState extends State<RetirarDineroScreen> {
  final List<double> _montos = [1000, 5000, 10000];
  double? _montoSeleccionado;
  bool _otroImporteSeleccionado = false;
  final TextEditingController _otroImporteController = TextEditingController();

  void _seleccionarMonto(double monto) {
    setState(() {
      _montoSeleccionado = monto;
      _otroImporteSeleccionado = false;
      _otroImporteController.clear(); // Limpiar el campo de texto si se selecciona un monto predefinido
    });
  }

  void _seleccionarOtroImporte() {
    setState(() {
      _montoSeleccionado = null;
      _otroImporteSeleccionado = true;
    });
  }

  void _procesarRetiro() {
    final saldoProvider = Provider.of<SaldoProvider>(context, listen: false);

    final montoARetirar = _montoSeleccionado ?? double.tryParse(_otroImporteController.text);

    if (montoARetirar != null && montoARetirar <= saldoProvider.saldo) {
      _mostrarDialogoProcesando();

      Timer(const Duration(seconds: 3), () {
        if (mounted) {
          Navigator.of(context).pop(); // Cierra el diálogo de procesamiento
          saldoProvider.retirar(montoARetirar);
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
      title: 'Retiro Exitoso',
      desc: 'Has retirado \$${_montoSeleccionado?.toStringAsFixed(2) ?? _otroImporteController.text}. Tu saldo restante es \$${nuevoSaldo.toStringAsFixed(2)}.',
      btnOkOnPress: () {
        _mostrarDialogoImpresion();
      },
    ).show();
  }

  void _mostrarDialogoImpresion() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.scale,
      title: 'Impresión de Comprobante',
      desc: '¿Desea imprimir un comprobante de la operación?',
      btnOkText: 'Imprimir',
      btnOkOnPress: () {
        // Lógica para la impresión del comprobante
      },
      btnCancelText: 'Cancelar',
      btnCancelOnPress: () {
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
      desc: 'Saldo insuficiente o monto inválido.',
      btnOkOnPress: () {},
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomHeader(title: 'Retirar Dinero'),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: AppStyles.fondoGradiente,
        child: Column(
          children: [
            AppStyles.logoSizedBox(height: 130),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Selecciona el monto a retirar',
                style: AppStyles.textoEncabezado,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),
            ..._montos.map((monto) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        _montoSeleccionado == monto
                            ? const Color.fromARGB(255, 247, 171, 101)
                            : Colors.white,
                      ),
                      foregroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                    onPressed: () => _seleccionarMonto(monto),
                    child: Text('\$${monto.toStringAsFixed(2)}'),
                  ),
                )),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _seleccionarOtroImporte,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  _otroImporteSeleccionado
                      ? const Color.fromARGB(255, 247, 171, 101)
                      : Colors.white,
                ),
                foregroundColor: MaterialStateProperty.all(Colors.black),
              ),
              child: const Text('Otro Importe'),
            ),
            if (_otroImporteSeleccionado)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
                child: TextField(
                  controller: _otroImporteController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Ingrese el monto',
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
              onPressed: _procesarRetiro,
              style: AppStyles.primaryButton,
              child: const Text('Confirmar'),
            ),
          ],
        ),
      ),
    );
  }
}
