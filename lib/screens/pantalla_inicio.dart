import 'package:flutter/material.dart';
import 'package:atm_simulator/styles/styles.dart';
import 'package:atm_simulator/screens/insertar_tarjeta.dart'; // Importa la pantalla de insertar tarjeta
import 'dart:async';

class PantallaInicio extends StatefulWidget {
  const PantallaInicio({super.key});

  @override
  PantallaInicioState createState() => PantallaInicioState();
}

class PantallaInicioState extends State<PantallaInicio> {
  int _currentIndex = 0;
  double saldo = 350000; // Saldo inicial
  Timer? _timer; // Almacena la referencia del Timer

  final List<String> _mensajes = [
    "Recordá que tus claves son personales, no las compartas con nadie",
    "Asegúrate de recoger tu tarjeta de débito o crédito, dinero en efectivo y comprobante de operación",
    "Nunca digite la clave en presencia de desconocidos"
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 6), (Timer timer) {
      if (mounted) { // Verifica si el widget está montado
        setState(() {
          _currentIndex = (_currentIndex + 1) % _mensajes.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancela el Timer cuando el widget se elimina
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomHeader(title: 'Simulador de Cajero Automático'),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: AppStyles.fondoGradiente,
          ),
          Column(
            children: [
              AppStyles.logoSizedBox(height: 130),
              Padding(
                padding: AppStyles.paddingLogo,
                child: CircleAvatar(
                  radius: AppStyles.logoRadius,
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: AnimatedSwitcher(
                      duration: const Duration(seconds: 1),
                      transitionBuilder: (Widget child, Animation<double> animation) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                      child: Text(
                        _mensajes[_currentIndex],
                        key: ValueKey<int>(_currentIndex),
                        style: AppStyles.textoMensaje,
                        textAlign: TextAlign.center,
                      ),
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
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => const InsertarTarjetaScreen(),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                const begin = Offset(0.0, 1.0); // Desde abajo
                                const end = Offset.zero;
                                final tween = Tween(begin: begin, end: end);
                                final offsetAnimation = animation.drive(tween);
                                return SlideTransition(position: offsetAnimation, child: child);
                              },
                            ),
                          );
                        },
                        icon: const Icon(Icons.credit_card),
                        label: const Text(
                          'Usar tarjeta',
                          style: TextStyle(fontSize: 18),
                        ),
                        style: AppStyles.primaryButton,
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
                        style: AppStyles.primaryButton,
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
                        style: AppStyles.primaryButton,
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
