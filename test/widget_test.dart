// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:atm_simulator/main.dart';

// void main() {
//   testWidgets('Pantalla de inicio muestra los anuncios y botones correctamente', (WidgetTester tester) async {
//     // Construye la aplicación y activa un frame.
//     await tester.pumpWidget(SimuladorCajeroApp());

//     // Verificar que el título del AppBar se muestra correctamente.
//     expect(find.text('Banco Ejemplo'), findsOneWidget);

//     // Verificar que uno de los anuncios se muestra en el contenedor.
//     expect(find.text('Recordá que tus claves con personales, no las compartas con nadie'), findsOneWidget);
//     expect(find.text('Asegúrate de recoger tu tarjeta de débito o crédito, dinero en efectivo y comprobante de operación'), findsNothing);
//     expect(find.text('Nunca digite la clave en presencia de desconocidos'), findsNothing);

//     // Verificar que los botones se muestran correctamente en el pie de la pantalla.
//     expect(find.text('Acceder con tarjeta'), findsOneWidget);
//     expect(find.text('Huella Digital'), findsOneWidget);
//     expect(find.text('Sin tarjeta'), findsOneWidget);
//   });
// }
