import 'package:flutter/material.dart';
import 'package:flutter_app/NavigationBar/bar.dart';
import 'package:flutter_app/NavigationBar/messages.dart';
import 'package:flutter_app/NavigationBar/home.dart';
import 'package:flutter_app/NavigationBar/notifications.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.orange[300], // Cor primária primárias,
        primaryColorLight: Colors.white,
        secondaryHeaderColor: const Color.fromARGB(255, 224, 160, 235),
        scaffoldBackgroundColor: Colors.white, // Cor de fundo do scaffold
        textTheme: const TextTheme(
          bodySmall: TextStyle(
              color: Colors.black, fontSize: 10), // Cor do texto padrão
          bodyMedium: TextStyle(color: Colors.grey, fontSize: 15),
          bodyLarge: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ), // Cor do texto secundário// Cor e estilo do título
        ),
      ),
      home: const Bar(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/perfil': (context) => const Notifications(), // Página Perfil
        '/cliente': (context) => const Notifications(), // Página Cliente
        '/reclamacoes': (context) =>
            const Notifications(), // Página Reclamacoes
      },
    );
  }
}
