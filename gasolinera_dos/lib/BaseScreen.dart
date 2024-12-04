import 'package:flutter/material.dart';
import 'Roles.dart';
import 'Usuarios.dart';
import 'Bitacoras.dart';
import 'Gasolineras.dart';
import 'Proyectos.dart';
import 'Vehiculos.dart';
import 'HomePage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BaseScreen extends StatelessWidget {
  final Widget child;
  final String title;
  final int idUsuario;

  BaseScreen({required this.child, required this.title, required this.idUsuario});

  Future<void> modificarActivo(int idUsuario, int activo) async {
    final url = 'https://fundamentos-trabajo-final.fly.dev/usuarios/$idUsuario';
    final Map<String, dynamic> requestBody = {
      "activo": activo,
    };
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(requestBody),
      );
      if (response.statusCode == 200) {
        print('User status updated successfully!');
      } else {
        throw Exception('Failed to update user. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during PUT request: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text('Menú', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('Usuarios'),
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Usuarios(idUsuario: idUsuario)));
              },
            ),
           ListTile(
              leading: Icon(Icons.manage_accounts), // Icono que representa roles o grupos
              title: Text('Roles'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Roles(idUsuario: idUsuario)),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.book),
              title: Text('Bitacoras'),
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Bitacoras(idUsuario: idUsuario)));
              },
            ),
            ListTile(
              leading: Icon(Icons.ev_station),
              title: Text('Gasolineras'),
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Gasolineras(idUsuario: idUsuario)));
              },
            ),
            ListTile(
              leading: Icon(Icons.assignment),
              title: Text('Proyectos'),
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Proyectos(idUsuario: idUsuario)));
              },
            ),
            ListTile(
              leading: Icon(Icons.directions_car),
              title: Text('Vehículos'),
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Vehiculos(idUsuario: idUsuario)));
              },
            ),

            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Cerrar sesión'),
              onTap: () async {
                await modificarActivo(idUsuario, 0);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
          ],
        ),
      ),
      body: child,
    );
  }
}
