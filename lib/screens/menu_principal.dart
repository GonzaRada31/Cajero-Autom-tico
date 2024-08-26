import 'package:flutter/material.dart';
import 'package:atm_simulator/styles/styles.dart';
import 'package:provider/provider.dart';
import 'package:atm_simulator/providers/saldo_provider.dart';
import 'consultar_saldo.dart';
import 'retirar_dinero.dart';
import 'depositar_dinero.dart';
import 'transferencias.dart';
import 'cambio_clave.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'dart:io';
import 'package:flutter/services.dart';

class MenuPrincipalScreen extends StatelessWidget {
  const MenuPrincipalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final saldoProvider = Provider.of<SaldoProvider>(context);

    return Scaffold(
      appBar: const CustomHeader(title: 'Simulador de Cajero Automático'),
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: AppStyles.fondoGradiente,
        child: Column(
          children: [
            const SizedBox(height: 150), // Ajusta este valor para mover el texto hacia abajo
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Seleccione una opción',
                style: AppStyles.textoEncabezado,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30), // Añadir espacio antes de los botones
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // Dos botones por fila
                crossAxisSpacing: 15, // Espacio entre botones horizontal
                mainAxisSpacing: 15, // Espacio entre botones vertical
                padding: const EdgeInsets.all(30), // Espacio alrededor de los botones
                children: <Widget>[
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ConsultarSaldoScreen()),
                      );
                    },
                    icon: const Icon(Icons.account_balance_wallet),
                    label: const Text('Consultar Saldo'),
                    style: AppStyles.menuButton, // Estilo de botón personalizado
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RetirarDineroScreen()),
                      );
                    },
                    icon: const Icon(Icons.attach_money),
                    label: const Text('Retirar Dinero'),
                    style: AppStyles.menuButton,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const DepositarDineroScreen()),
                      );
                    },
                    icon: const Icon(Icons.money),
                    label: const Text('Depositar Dinero'),
                    style: AppStyles.menuButton,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const TransferenciasScreen()),
                      );
                    },
                    icon: const Icon(Icons.swap_horiz),
                    label: const Text('Transferencias'),
                    style: AppStyles.menuButton,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CambioClaveScreen()),
                      );
                    },
                    icon: const Icon(Icons.lock),
                    label: const Text('Cambio de Clave'),
                    style: AppStyles.menuButton,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      _mostrarDialogoSalida(context);
                    },
                    icon: const Icon(Icons.exit_to_app),
                    label: const Text('Salir'),
                    style: AppStyles.menuButton,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarDialogoSalida(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.bottomSlide,
      title: 'Salir',
      desc: '¿Estás seguro que deseas salir?',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        _mostrarDialogoTarjeta(context);
      },
    ).show();
  }

  void _mostrarDialogoTarjeta(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.bottomSlide,
      title: 'No olvides retirar tu tarjeta',
      btnOkOnPress: () {
        // Aquí cerrar la aplicación completamente
        if (Platform.isAndroid) {
          SystemNavigator.pop();
        } else if (Platform.isIOS) {
          exit(0);
        }
      },
    ).show();
  }
}
