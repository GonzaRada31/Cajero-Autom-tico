import 'package:flutter/material.dart';
import 'dart:async';

class PantallaInicio extends StatefulWidget {
  const PantallaInicio({super.key});

  @override
  _PantallaInicioState createState() => _PantallaInicioState();
}

class _PantallaInicioState extends State<PantallaInicio> {
  int _currentIndex = 0;
  final List<String> _mensajes = [
    "Recordá que tus claves son personales, no las compartas con nadie",
    "Asegúrate de recoger tu tarjeta de débito o crédito, dinero en efectivo y comprobante de operación",
    "Nunca digite la clave en presencia de desconocidos"
  ];

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 6), (Timer timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % _mensajes.length;
      });
    });
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
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff290979), Color(0xff00d4ff)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Column(
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
              Expanded(
                child: Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(seconds: 1),
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    child: Text(
                      _mensajes[_currentIndex],
                      key: ValueKey<int>(_currentIndex),
                      style: const TextStyle(fontSize: 24, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, '/insertar_tarjeta');
                        },
                        icon: const Icon(Icons.credit_card),
                        label: const Text(
                          'Usar tarjeta',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Navegar a la pantalla de huella digital
                        },
                        icon: const Icon(Icons.fingerprint),
                        label: const Text(
                          'Huella Digital',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Navegar a la pantalla de acceso sin tarjeta
                        },
                        icon: const Icon(Icons.no_accounts),
                        label: const Text(
                          'Sin tarjeta',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}
