import 'package:flutter/material.dart';

// Clase que define un AppBar personalizado
class CustomHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 28),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      leading: IconButton( // Botón de retroceso
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// Clase que contiene los estilos de la aplicación
class AppStyles {
  // Estilo de fondo con gradiente
  static const BoxDecoration fondoGradiente = BoxDecoration(
    gradient: LinearGradient(
      colors: [Color(0xff290979), Color(0xff00d4ff)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );

  // Estilos para el logo
  static const double logoHeight = 60;
  static const double logoRadius = 50;
  static const EdgeInsets paddingLogo = EdgeInsets.all(16.0);

  // Método para obtener el SizedBox para el logo
  static SizedBox logoSizedBox({double height = logoHeight}) {
    return SizedBox(height: height);
  }

  // Estilo para el texto del mensaje que aparece en la pantalla de inicio en la parte inferior
  static const TextStyle textoMensaje = TextStyle(
    fontSize: 30,
    color: Colors.white,
  );

  // Estilo para el texto del encabezado
  static const TextStyle textoEncabezado = TextStyle(
    fontSize: 35,
    color: Colors.white,
  );

  // Estilo para el texto de la pista en el campo de entrada de la clave
  static const TextStyle inputHintStyle = TextStyle(
    fontSize: 24,
    color: Color.fromARGB(255, 163, 159, 159),
  );

  // Estilo para los botones de la aplicación
  static final ButtonStyle primaryButton = ElevatedButton.styleFrom(
    foregroundColor: const Color.fromARGB(255, 109, 69, 211), // Texto e icono azul
    backgroundColor: Colors.white, // Fondo blanco
    textStyle: const TextStyle(fontSize: 20),
    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0), // Bordes redondeados
    ),
    minimumSize: const Size(150, 60), // Tamaño mínimo del botón
  );

  // Estilo para los botones del menú principal de la aplicación
  static final ButtonStyle menuButton = ElevatedButton.styleFrom(
    foregroundColor: const Color.fromARGB(255, 109, 69, 211), // Texto e icono azul
    backgroundColor: Colors.white, // Fondo blanco
    textStyle: const TextStyle(fontSize: 20),
    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0), // Bordes redondeados
    ),
    minimumSize: const Size(150, 60), // Tamaño mínimo del botón
  );
}
