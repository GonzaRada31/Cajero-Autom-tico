import 'package:flutter/material.dart';
import 'package:atm_simulator/styles/styles.dart';

class MenuPrincipalScreen extends StatelessWidget {
  const MenuPrincipalScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                      // Lógica para consultar saldo
                    },
                    icon: const Icon(Icons.account_balance_wallet),
                    label: const Text('Consultar Saldo'),
                    style: AppStyles.menuButton, // Estilo de botón personalizado
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Lógica para retirar dinero
                    },
                    icon: const Icon(Icons.attach_money),
                    label: const Text('Retirar Dinero'),
                    style: AppStyles.menuButton,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Lógica para depositar dinero
                    },
                    icon: const Icon(Icons.money),
                    label: const Text('Depositar Dinero'),
                    style: AppStyles.menuButton,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Lógica para transferencias
                    },
                    icon: const Icon(Icons.swap_horiz),
                    label: const Text('Transferencias'),
                    style: AppStyles.menuButton,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Lógica para cambio de clave
                    },
                    icon: const Icon(Icons.lock),
                    label: const Text('Cambio de Clave'),
                    style: AppStyles.menuButton,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Lógica para salir
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
}
