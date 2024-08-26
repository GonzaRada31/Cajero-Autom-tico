import 'package:flutter/material.dart';
import 'package:atm_simulator/styles/styles.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:atm_simulator/providers/saldo_provider.dart';
import 'package:atm_simulator/screens/menu_principal.dart';

class ConsultarSaldoScreen extends StatefulWidget {
  const ConsultarSaldoScreen({super.key});

  @override
  ConsultarSaldoScreenState createState() => ConsultarSaldoScreenState();
}

class ConsultarSaldoScreenState extends State<ConsultarSaldoScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showProcessingDialog();
    });
  }

  void _showProcessingDialog() {
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

    _timer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pop(); // Cierra el diálogo de procesamiento
        _showSaldoDialog();
      }
    });
  }

  void _showSaldoDialog() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      title: 'Saldo Disponible',
      desc: 'Su saldo es: \$${Provider.of<SaldoProvider>(context, listen: false).saldo.toStringAsFixed(2)}',
      btnOkOnPress: () {
        _showPrintDialog();
      },
    ).show();
  }

  void _showPrintDialog() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.bottomSlide,
      title: 'Imprimir Comprobante',
      desc: '¿Desea imprimir un comprobante de su saldo?',
      btnOkOnPress: () {
        // Lógica para imprimir el comprobante
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const MenuPrincipalScreen()),
          (Route<dynamic> route) => false,
        );
      },
      btnCancelOnPress: () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const MenuPrincipalScreen()),
          (Route<dynamic> route) => false,
        );
      },
    ).show();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomHeader(title: 'Consultar Saldo'),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: AppStyles.fondoGradiente,
      ),
    );
  }
}
