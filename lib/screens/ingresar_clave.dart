import 'package:flutter/material.dart';

class IngresarClaveScreen extends StatelessWidget {
  const IngresarClaveScreen({super.key});

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
        width: double.infinity, // Asegurar que el contenedor cubra todo el ancho
        height: double.infinity, // Asegurar que el contenedor cubra toda la altura
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlueAccent, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Logo en la parte superior
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
              // Texto de instrucción
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Ingresa tu clave en el teclado numérico',
                  style: TextStyle(fontSize: 30, color: Color.fromARGB(255, 255, 255, 255)),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 50), // Añadir espacio entre el texto y el campo de entrada
              // Campo de entrada para la clave
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.0),
                child: TextField(
                  maxLength: 4, // Limitar la entrada a 4 dígitos
                  keyboardType: TextInputType.number, // Mostrar solo el teclado numérico
                  obscureText: true, // Ocultar la entrada
                  decoration: InputDecoration(
                    counterText: '', // Ocultar el contador de caracteres
                    hintText: '****', // Texto de marcador de posición
                    hintStyle: TextStyle(fontSize: 24, color: Colors.black),
                    filled: true,
                    fillColor: Color.fromARGB(255, 200, 200, 200), // Color de fondo del campo de entrada
                    border: OutlineInputBorder(),
                  ),
                  style: TextStyle(fontSize: 24, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),
              // Botón de ingreso
              ElevatedButton.icon(
                onPressed: () {
                  // Lógica para validar el ingreso de la clave
                },
                icon: const Icon(Icons.login, color: Color.fromARGB(255, 105, 108, 241)),
                label: const Text('Ingresar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Cambiado de 'primary' a 'backgroundColor'
                  textStyle: const TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(height: 20), // Añadir un poco de espacio debajo del botón
            ],
          ),
        ),
      ),
    );
  }
}
