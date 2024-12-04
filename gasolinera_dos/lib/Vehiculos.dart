import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'BaseScreen.dart';

class Vehiculos extends StatefulWidget {
  final int idUsuario;

  Vehiculos({required this.idUsuario});

  @override
  _VehiculosScreenState createState() => _VehiculosScreenState();
}

class _VehiculosScreenState extends State<Vehiculos> {
  List<dynamic> _vehiculos = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchVehiculos();
  }

  Future<void> _fetchVehiculos() async {
    final vehiculosUrl = 'https://fundamentos-trabajo-final.fly.dev/vehiculos';
    try {
      final response = await http.get(Uri.parse(vehiculosUrl));
      if (response.statusCode == 200) {
        setState(() {
          _vehiculos = json.decode(response.body);
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load vehiculos');
      }
    } catch (e) {
      print('Error fetching vehiculos: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _agregarVehiculo(String modelo, String marca, String placa, String rendimiento, double galonaje, String tipoCombustible) async {
    final url = 'https://fundamentos-trabajo-final.fly.dev/vehiculos';
    final Map<String, dynamic> requestBody = {
      "modelo": modelo,
      "marca": marca,
      "placa": placa,
      "rendimiento": rendimiento,
      "galonaje": galonaje,
      "tipo_combustible": tipoCombustible
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
        await _fetchVehiculos(); // Refrescar la lista
      } else {
        throw Exception('Failed to add vehiculo. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error adding vehiculo: $e');
    }
  }

  void _showAddVehiculoDialog() {
    final TextEditingController modeloController = TextEditingController();
    final TextEditingController marcaController = TextEditingController();
    final TextEditingController placaController = TextEditingController();
    final TextEditingController rendimientoController = TextEditingController();
    final TextEditingController galonajeController = TextEditingController();
    final TextEditingController tipoCombustibleController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Agregar Vehículo'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: modeloController,
                  decoration: InputDecoration(labelText: 'Modelo'),
                ),
                TextField(
                  controller: marcaController,
                  decoration: InputDecoration(labelText: 'Marca'),
                ),
                TextField(
                  controller: placaController,
                  decoration: InputDecoration(labelText: 'Placa'),
                ),
                TextField(
                  controller: rendimientoController,
                  decoration: InputDecoration(labelText: 'Rendimiento'),
                ),
                TextField(
                  controller: galonajeController,
                  decoration: InputDecoration(labelText: 'Galonaje'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: tipoCombustibleController,
                  decoration: InputDecoration(labelText: 'Tipo Combustible'),
                ),
              ],
            ),
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
                _agregarVehiculo(
                  modeloController.text,
                  marcaController.text,
                  placaController.text,
                  rendimientoController.text,
                  double.tryParse(galonajeController.text) ?? 0.0,
                  tipoCombustibleController.text,
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _modificarVehiculo(int id, String modelo, String marca, String placa, String rendimiento, double galonaje, String tipoCombustible) async {
    final url = 'https://fundamentos-trabajo-final.fly.dev/vehiculos/$id';
    final Map<String, dynamic> requestBody = {
      "modelo": modelo,
      "marca": marca,
      "placa": placa,
      "rendimiento": rendimiento,
      "galonaje": galonaje,
      "tipo_combustible": tipoCombustible
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
        await _fetchVehiculos(); // Refrescar la lista
      } else {
        throw Exception('Failed to update vehiculo. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating vehiculo: $e');
    }
  }

  Future<void> _eliminarVehiculo(int id) async {
    final url = 'https://fundamentos-trabajo-final.fly.dev/vehiculos/$id';
    try {
      final response = await http.delete(Uri.parse(url));
      if (response.statusCode == 200) {
        await _fetchVehiculos();
      } else {
        throw Exception('Failed to delete vehiculo. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting vehiculo: $e');
    }
  }

  void _showEditVehiculoDialog(Map<String, dynamic> vehiculo) {
    final TextEditingController modeloController = TextEditingController(text: vehiculo['modelo']);
    final TextEditingController marcaController = TextEditingController(text: vehiculo['marca']);
    final TextEditingController placaController = TextEditingController(text: vehiculo['placa']);
    final TextEditingController rendimientoController = TextEditingController(text: vehiculo['rendimiento']);
    final TextEditingController galonajeController = TextEditingController(text: vehiculo['galonaje'].toString());
    final TextEditingController tipoCombustibleController = TextEditingController(text: vehiculo['tipo_combustible']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Modificar Vehículo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: modeloController,
                decoration: InputDecoration(labelText: 'Modelo'),
              ),
              TextField(
                controller: marcaController,
                decoration: InputDecoration(labelText: 'Marca'),
              ),
              TextField(
                controller: placaController,
                decoration: InputDecoration(labelText: 'Placa'),
              ),
              TextField(
                controller: rendimientoController,
                decoration: InputDecoration(labelText: 'Rendimiento'),
              ),
              TextField(
                controller: galonajeController,
                decoration: InputDecoration(labelText: 'Galonaje'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: tipoCombustibleController,
                decoration: InputDecoration(labelText: 'Tipo Combustible'),
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
                _modificarVehiculo(
                  vehiculo['id_vehiculo'],
                  modeloController.text,
                  marcaController.text,
                  placaController.text,
                  rendimientoController.text,
                  double.tryParse(galonajeController.text) ?? 0.0,
                  tipoCombustibleController.text,
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
      title: 'Vehículos',
      idUsuario: widget.idUsuario,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                ElevatedButton(
                  onPressed: _showAddVehiculoDialog,
                  child: Text('Agregar Vehículo'),
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
                            DataColumn(label: Text('Modelo')),
                            DataColumn(label: Text('Marca')),
                            DataColumn(label: Text('Placa')),
                            DataColumn(label: Text('Rendimiento')),
                            DataColumn(label: Text('Galonaje')),
                            DataColumn(label: Text('Combustible')),
                            DataColumn(label: Text('Modificar')),
                            DataColumn(label: Text('Eliminar')),
                          ],
                          rows: _vehiculos.map((vehiculo) {
                            return DataRow(cells: [
                              DataCell(Text(vehiculo['modelo'])),
                              DataCell(Text(vehiculo['marca'])),
                              DataCell(Text(vehiculo['placa'])),
                              DataCell(Text(vehiculo['rendimiento'])),
                              DataCell(Text(vehiculo['galonaje'].toString())),
                              DataCell(Text(vehiculo['tipo_combustible'])),
                              DataCell(
                                ElevatedButton(
                                  onPressed: () {
                                    _showEditVehiculoDialog(vehiculo);
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
                                    _eliminarVehiculo(vehiculo['id_vehiculo']);
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
        ],
      ),
    );
  }
}
