import 'package:flutter/material.dart';
import 'dart:async';
import 'ingresar_clave.dart'; // Importa la pantalla de ingreso de clave

class InsertarTarjetaScreen extends StatefulWidget {
  const InsertarTarjetaScreen({super.key});

  @override
  _InsertarTarjetaScreenState createState() => _InsertarTarjetaScreenState();
}

class _InsertarTarjetaScreenState extends State<InsertarTarjetaScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  bool _isReading = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _animation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward().then((_) {
      setState(() {
        _isReading = true;
      });
      Timer(const Duration(seconds: 2), () {
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const IngresarClaveScreen()),
          );
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Simulador de Cajero Automático',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent, // Hacer el fondo del AppBar transparente
        elevation: 0, // Quitar la sombra del AppBar
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true, // Extender el cuerpo detrás del AppBar
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlueAccent, Colors.blue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 60), // Ajusta este valor para mover el logo hacia abajo
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CircleAvatar(
                radius: 50, // Ajusta este valor según sea necesario
                backgroundColor: Colors.white,
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 80,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50), // Añadir un poco de espacio debajo del logo
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      _isReading ? 'Leyendo los datos de la tarjeta...' : 'Ingrese su tarjeta por favor',
                      style: const TextStyle(fontSize: 30, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 0),
                    SlideTransition(
                      position: _animation,
                      child: Image.asset(
                        'assets/images/tarjeta_perfil.png', // Ruta de tu imagen de la tarjeta de perfil
                        width: 200,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
