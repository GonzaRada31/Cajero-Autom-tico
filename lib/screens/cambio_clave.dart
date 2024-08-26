import 'package:flutter/material.dart';
import 'package:atm_simulator/styles/styles.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
//import 'package:provider/provider.dart';
//import 'package:atm_simulator/screens/menu_principal.dart';

class CambioClaveScreen extends StatefulWidget {
  const CambioClaveScreen({super.key});

  @override
  CambioClaveScreenState createState() => CambioClaveScreenState();
}

class CambioClaveScreenState extends State<CambioClaveScreen> {
  final TextEditingController _claveActualController = TextEditingController();
  final TextEditingController _nuevaClaveController = TextEditingController();
  final TextEditingController _confirmarClaveController = TextEditingController();

  void _cambiarClave() {
    if (_nuevaClaveController.text == _confirmarClaveController.text && _nuevaClaveController.text.isNotEmpty) {
      _mostrarDialogoExito();
    } else {
      _mostrarDialogoError();
    }
  }

  void _mostrarDialogoExito() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      title: 'Cambio de Clave Exitoso',
      desc: 'Tu clave ha sido cambiada correctamente.',
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
      desc: 'Las claves no coinciden o están vacías.',
      btnOkOnPress: () {},
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomHeader(title: 'Cambio de Clave'),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: AppStyles.fondoGradiente,
        child: Column(
          children: [
            AppStyles.logoSizedBox(height: 130),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Ingresa tu clave actual y la nueva clave',
                style: AppStyles.textoEncabezado,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: TextField(
                controller: _claveActualController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Clave Actual',
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: TextField(
                controller: _nuevaClaveController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Nueva Clave',
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: TextField(
                controller: _confirmarClaveController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Confirmar Nueva Clave',
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
              onPressed: _cambiarClave,
              style: AppStyles.primaryButton,
              child: const Text('Confirmar'),
            ),
          ],
        ),
      ),
    );
  }
}
