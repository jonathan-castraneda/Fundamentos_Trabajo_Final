import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'BaseScreen.dart';

class Gasolineras extends StatefulWidget {
  final int idUsuario;

  Gasolineras({required this.idUsuario});

  @override
  _GasolinerasScreenState createState() => _GasolinerasScreenState();
}

class _GasolinerasScreenState extends State<Gasolineras> {
  List<dynamic> _gasolineras = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchGasolineras();
  }

  Future<void> _fetchGasolineras() async {
    final gasolinerasUrl = 'https://fundamentos-trabajo-final.fly.dev/gasolineras';
    try {
      final response = await http.get(Uri.parse(gasolinerasUrl));
      if (response.statusCode == 200) {
        setState(() {
          _gasolineras = json.decode(response.body);
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load gasolineras');
      }
    } catch (e) {
      print('Error fetching gasolineras: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _agregarGasolinera(String nombre, String direccion) async {
    final url = 'https://fundamentos-trabajo-final.fly.dev/gasolineras';
    final Map<String, dynamic> requestBody = {
      "nombre": nombre,
      "direccion": direccion,
    };
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(requestBody),
      );
      if (response.statusCode == 200) {
        await _fetchGasolineras();
      } else {
        throw Exception('Failed to add gasolinera. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error adding gasolinera: $e');
    }
  }

  Future<void> _modificarGasolinera(int id, String nombre, String direccion) async {
    final url = 'https://fundamentos-trabajo-final.fly.dev/gasolineras/$id';
    final Map<String, dynamic> requestBody = {
      "nombre": nombre,
      "direccion": direccion,
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
        await _fetchGasolineras();
      } else {
        throw Exception('Failed to update gasolinera. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating gasolinera: $e');
    }
  }

  Future<void> _eliminarGasolinera(int id) async {
    final url = 'https://fundamentos-trabajo-final.fly.dev/gasolineras/$id';
    try {
      final response = await http.delete(Uri.parse(url));
      if (response.statusCode == 200) {
        await _fetchGasolineras();
      } else {
        throw Exception('Failed to delete gasolinera. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting gasolinera: $e');
    }
  }

  void _showAddGasolineraDialog() {
    final TextEditingController nombreController = TextEditingController();
    final TextEditingController direccionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Agregar Gasolinera'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: nombreController,
                decoration: InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: direccionController,
                decoration: InputDecoration(labelText: 'Dirección'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Guardar'),
              onPressed: () {
                Navigator.of(context).pop();
                _agregarGasolinera(nombreController.text, direccionController.text);
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditGasolineraDialog(Map<String, dynamic> gasolinera) {
    final TextEditingController nombreController = TextEditingController(text: gasolinera['nombre']);
    final TextEditingController direccionController = TextEditingController(text: gasolinera['direccion']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Modificar Gasolinera'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: nombreController,
                decoration: InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: direccionController,
                decoration: InputDecoration(labelText: 'Dirección'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Guardar'),
              onPressed: () {
                Navigator.of(context).pop();
                _modificarGasolinera(
                  gasolinera['id_gasolinera'],
                  nombreController.text,
                  direccionController.text,
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Gasolineras',
      idUsuario: widget.idUsuario,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: _showAddGasolineraDialog,
              child: Text('Agregar Gasolinera'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                textStyle: TextStyle(color: Colors.white),
              ),
            ),
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : DataTable(
                      columns: [
                        DataColumn(label: Text('Nombre')),
                        DataColumn(label: Text('Dirección')),
                        DataColumn(label: Text('Modificar')),
                        DataColumn(label: Text('Eliminar')),
                      ],
                      rows: _gasolineras.map((gasolinera) {
                        return DataRow(cells: [
                          DataCell(Text(gasolinera['nombre'])),
                          DataCell(Text(gasolinera['direccion'])),
                          DataCell(
                            ElevatedButton(
                              onPressed: () {
                                _showEditGasolineraDialog(gasolinera);
                              },
                              child: Text('Modificar'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber[700],
                              ),
                            ),
                          ),
                          DataCell(
                            ElevatedButton(
                              onPressed: () {
                                _eliminarGasolinera(gasolinera['id_gasolinera']);
                              },
                              child: Text('Eliminar'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                            ),
                          ),
                        ]);
                      }).toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
