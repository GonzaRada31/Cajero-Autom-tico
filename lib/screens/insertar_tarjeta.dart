import 'package:flutter/material.dart';
import 'package:atm_simulator/styles/styles.dart';
import 'dart:async';
import 'ingresar_clave.dart';

class InsertarTarjetaScreen extends StatefulWidget {
  const InsertarTarjetaScreen({super.key});

  @override
  InsertarTarjetaScreenState createState() => InsertarTarjetaScreenState();
}

class InsertarTarjetaScreenState extends State<InsertarTarjetaScreen> with SingleTickerProviderStateMixin {
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

    _controller.forward().then((_) {  // Se ejecuta cuando la animación termina
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
  // Se usa para liberar recursos cuando el widget es eliminado 
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomHeader(title: 'Simulador de Cajero Automático'),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: AppStyles.fondoGradiente,
        child: Column(
          children: [
            AppStyles.logoSizedBox(height: 130), // Regula la posición del logo
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      _isReading ? 'Estamos leyendo los datos de la tarjeta' : 'Ingrese su tarjeta por favor',
                      style: AppStyles.textoEncabezado,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 50),
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
