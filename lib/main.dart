// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/pantalla_inicio.dart';
import 'screens/insertar_tarjeta.dart';
import 'screens/ingresar_clave.dart';
import 'screens/menu_principal.dart';

void main() {
  runApp(const SimuladorCajeroApp());
}

class SimuladorCajeroApp extends StatelessWidget {
  const SimuladorCajeroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simulador de Cajero',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const PantallaInicio(),
        '/insertar_tarjeta': (context) => const InsertarTarjetaScreen(),
        '/ingresar_clave': (context) => const IngresarClaveScreen(),
        '/menu_principal': (context) => const MenuPrincipalScreen(),
      },
    );
  }
}
