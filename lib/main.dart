import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/saldo_provider.dart';
import 'screens/pantalla_inicio.dart';
import 'screens/insertar_tarjeta.dart';
import 'screens/ingresar_clave.dart';
import 'screens/menu_principal.dart';
import 'screens/consultar_saldo.dart';
import 'screens/retirar_dinero.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SaldoProvider()),
      ],
      child: const SimuladorCajeroApp(),
    ),
  );
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
        '/consultar_saldo': (context) => const ConsultarSaldoScreen(), // Ya no se pasa saldo aquí
        '/retirar_dinero': (context) => const RetirarDineroScreen(),
      },
    );
  }
}
