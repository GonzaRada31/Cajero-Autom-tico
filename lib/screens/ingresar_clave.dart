import 'package:flutter/material.dart';
import 'package:atm_simulator/styles/styles.dart';
import 'menu_principal.dart';

class IngresarClaveScreen extends StatelessWidget {
  const IngresarClaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomHeader(title: 'Simulador de Cajero Automático'),
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: AppStyles.fondoGradiente,
        child: SingleChildScrollView(
          child: Column(
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

              const SizedBox(height: 150), // Espacio entre el logo y el texto
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Ingresa tu clave en el teclado numérico',
                  style: AppStyles.textoEncabezado,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 50),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.0),
                child: TextField(
                  maxLength: 4,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  decoration: InputDecoration(
                    counterText: '',
                    hintText: '****',
                    hintStyle: AppStyles.inputHintStyle,
                    filled: true,
                    fillColor: Color.fromARGB(255, 255, 255, 255),
                    border: OutlineInputBorder(),
                  ),
                  style: TextStyle(fontSize: 24, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MenuPrincipalScreen(), // Ya no necesitas pasar el saldo aquí
                    ),
                  );
                },
                icon: const Icon(Icons.login, color: Color.fromARGB(255, 109, 69, 211)),
                label: const Text('Ingresar'),
                style: AppStyles.primaryButton,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
