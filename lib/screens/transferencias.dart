import 'package:flutter/material.dart';
import 'package:atm_simulator/styles/styles.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:provider/provider.dart';
import 'package:atm_simulator/providers/saldo_provider.dart';
import 'dart:async';

class TransferenciasScreen extends StatefulWidget {
  const TransferenciasScreen({super.key});

  @override
  TransferenciasScreenState createState() => TransferenciasScreenState();
}

class TransferenciasScreenState extends State<TransferenciasScreen> {
  String? _opcionSeleccionada;
  final TextEditingController _datosController = TextEditingController();

  void _seleccionarOpcion(String opcion) {
    setState(() {
      _opcionSeleccionada = opcion;
      _datosController.clear(); // Limpiar el campo de texto al seleccionar una opción
    });
  }

  void _procesarTransferencia() {
    final saldoProvider = Provider.of<SaldoProvider>(context, listen: false);
    final montoATransferir = double.tryParse(_datosController.text);

    if (montoATransferir != null && montoATransferir <= saldoProvider.saldo) {
      _mostrarDialogoProcesando();

      Timer(const Duration(seconds: 3), () {
        if (mounted) {
          Navigator.of(context).pop(); // Cierra el diálogo de procesamiento
          saldoProvider.transferir(montoATransferir);
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
      title: 'Transferencia Exitosa',
      desc: 'Tu saldo restante es \$${nuevoSaldo.toStringAsFixed(2)}.',
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
      desc: 'Saldo insuficiente o monto inválido.',
      btnOkOnPress: () {},
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomHeader(title: 'Transferencias'),
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: AppStyles.fondoGradiente,
        child: Column(
          children: [
            AppStyles.logoSizedBox(height: 130),
            const SizedBox(height: 20), // Ajustar espacio antes de las opciones
            _buildOpcionButton('A un CBU/CVU', TextInputType.number),
            _buildOpcionButton('A un Alias', TextInputType.text),
            _buildOpcionButton('A un número de cuenta', TextInputType.number),
            if (_opcionSeleccionada != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: TextField(
                  controller: _datosController,
                  keyboardType: _getInputType(),
                  decoration: InputDecoration(
                    hintText: _getHintText(),
                    hintStyle: AppStyles.inputHintStyle,
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    border: const OutlineInputBorder(),
                  ),
                  style: const TextStyle(fontSize: 24, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
            const SizedBox(height: 20),
            if (_opcionSeleccionada != null)
              ElevatedButton(
                onPressed: _procesarTransferencia,
                style: AppStyles.primaryButton,
                child: const Text('Confirmar'),
              ),
            const Spacer(),
            _buildBotonCancelar(context),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildOpcionButton(String label, TextInputType inputType) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0), // Añadir padding horizontal
      child: ElevatedButton(
        onPressed: () {
          _seleccionarOpcion(label);
        },
        style: AppStyles.primaryButton.copyWith(
          backgroundColor: _opcionSeleccionada == label
              ? MaterialStateProperty.all(const Color.fromARGB(255, 247, 171, 101))
              : MaterialStateProperty.all(Colors.white),
          textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 22)),
        ),
        child: Text(label),
      ),
    );
  }

  String _getHintText() {
    switch (_opcionSeleccionada) {
      case 'A un CBU/CVU':
        return 'Número de CBU/CVU';
      case 'A un Alias':
        return 'Alias de la cuenta';
      case 'A un número de cuenta':
        return 'Número de cuenta';
      default:
        return '';
    }
  }

  TextInputType _getInputType() {
    switch (_opcionSeleccionada) {
      case 'A un Alias':
        return TextInputType.text;
      case 'A un CBU/CVU':
      case 'A un número de cuenta':
      default:
        return TextInputType.number;
    }
  }

  Widget _buildBotonCancelar(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pop(context); // Regresa al menú principal
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red, // Color de fondo del botón Cancelar
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: const Text(
        'Cancelar',
        style: TextStyle(fontSize: 20, color: Colors.white), // Texto en blanco
      ),
    );
  }
}
