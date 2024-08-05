import 'package:flutter/material.dart';
import 'screens/pantalla_inicio.dart';
import 'screens/insertar_tarjeta.dart';
import 'screens/ingresar_clave.dart';

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
          backgroundColor: Colors.transparent, // Hacer el fondo del AppBar transparente
          elevation: 0, // Quitar la sombra del AppBar
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const PantallaInicio(),
        '/insertar_tarjeta': (context) => const InsertarTarjetaScreen(),
        '/ingresar_clave': (context) => const IngresarClaveScreen(),
      },
    );
  }
}
