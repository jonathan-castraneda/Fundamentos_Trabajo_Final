import 'package:flutter/material.dart';
import 'BaseScreen.dart';

class MainScreen extends StatelessWidget {
  final int idUsuario;

  MainScreen({required this.idUsuario});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Bienvenido',
      idUsuario: idUsuario,
      child: Container(
        color: Colors.blue, // Fondo azul
        child: Center(
          child: Text(
            '¡Bienvenido al Sistema de Gestión de Transporte!',
            style: TextStyle(
              fontSize: 24, // Tamaño de fuente grande
              fontWeight: FontWeight.bold,
              color: Colors.white, // Color del texto
            ),
            textAlign: TextAlign.center, // Alineación centrada
          ),
        ),
      ),
    );
  }
}
