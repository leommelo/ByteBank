import 'package:bytebank_full/screens/dashboard.dart';
import 'package:flutter/material.dart';

void main() { 
  runApp(ByteBankApp());
}


class ByteBankApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green).copyWith(secondary: Colors.blueAccent[700]),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green[900],
          titleTextStyle: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
          inputDecorationTheme: InputDecorationTheme(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: const Color.fromARGB(255, 0, 27, 2)), // Linha quando não está selecionado
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green), // Linha quando está selecionado
            ),
            labelStyle: TextStyle(color: Colors.black), // Cor do rótulo (label)
            hintStyle: TextStyle(color: Colors.grey), // Cor do texto de dica (hint)
          ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Colors.blueAccent[700]),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent[700],
            foregroundColor: Colors.white,
            textStyle: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          )
        )
      ),
      home: Dashboard(),
    );
  }
}

