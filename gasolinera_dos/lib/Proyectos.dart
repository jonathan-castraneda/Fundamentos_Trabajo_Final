import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'BaseScreen.dart';

class Proyectos extends StatefulWidget {
  final int idUsuario;

  Proyectos({required this.idUsuario});

  @override
  _ProyectosScreenState createState() => _ProyectosScreenState();
}

class _ProyectosScreenState extends State<Proyectos> {
  List<dynamic> _proyectos = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProyectos();
  }

  Future<void> _fetchProyectos() async {
    final proyectosUrl = 'https://fundamentos-trabajo-final.fly.dev/proyectos';
    try {
      final response = await http.get(Uri.parse(proyectosUrl));
      if (response.statusCode == 200) {
        setState(() {
          _proyectos = json.decode(response.body);
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load proyectos');
      }
    } catch (e) {
      print('Error fetching proyectos: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _agregarProyecto(String nombre, String direccion, bool activo) async {
    final url = 'https://fundamentos-trabajo-final.fly.dev/proyectos';
    final Map<String, dynamic> requestBody = {
      "nombre": nombre,
      "direccion": direccion,
      "activo": activo ? 1 : 0,
    };
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );
      if (response.statusCode == 200) {
        await _fetchProyectos();
      } else {
        throw Exception('Failed to add proyecto. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error adding proyecto: $e');
    }
  }

  Future<void> _modificarProyecto(int id, String nombre, String direccion, bool activo) async {
    final url = 'https://fundamentos-trabajo-final.fly.dev/proyectos/$id';
    final Map<String, dynamic> requestBody = {
      "nombre": nombre,
      "direccion": direccion,
      "activo": activo ? 1 : 0,
    };
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );
      if (response.statusCode == 200) {
        await _fetchProyectos();
      } else {
        throw Exception('Failed to update proyecto. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating proyecto: $e');
    }
  }

  Future<void> _eliminarProyecto(int id) async {
    final url = 'https://fundamentos-trabajo-final.fly.dev/proyectos/$id';
    try {
      final response = await http.delete(Uri.parse(url));
      if (response.statusCode == 200) {
        await _fetchProyectos();
      } else {
        throw Exception('Failed to delete proyecto. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting proyecto: $e');
    }
  }

  void _showAddProyectoDialog() {
    final TextEditingController nombreController = TextEditingController();
    final TextEditingController direccionController = TextEditingController();
    bool activo = true;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text('Agregar Proyecto'),
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
                  SwitchListTile(
                    title: Text('Activo'),
                    value: activo,
                    onChanged: (value) {
                      setDialogState(() {
                        activo = value;
                      });
                    },
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
                    _agregarProyecto(
                      nombreController.text,
                      direccionController.text,
                      activo,
                    );
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showEditProyectoDialog(Map<String, dynamic> proyecto) {
    final TextEditingController nombreController =
        TextEditingController(text: proyecto['nombre']);
    final TextEditingController direccionController =
        TextEditingController(text: proyecto['direccion']);
    bool activo = proyecto['activo'] == 1;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text('Modificar Proyecto'),
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
                  SwitchListTile(
                    title: Text('Activo'),
                    value: activo,
                    onChanged: (value) {
                      setDialogState(() {
                        activo = value;
                      });
                    },
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
                    _modificarProyecto(
                      proyecto['id_proyecto'],
                      nombreController.text,
                      direccionController.text,
                      activo,
                    );
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Proyectos',
      idUsuario: widget.idUsuario,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: _showAddProyectoDialog,
              child: Text('Agregar Proyecto'),
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
                        DataColumn(label: Text('Activo')),
                        DataColumn(label: Text('Modificar')),
                        DataColumn(label: Text('Eliminar')),
                      ],
                      rows: _proyectos.map((proyecto) {
                        return DataRow(cells: [
                          DataCell(Text(proyecto['nombre'])),
                          DataCell(Text(proyecto['direccion'])),
                          DataCell(Text(proyecto['activo'] == 1 ? 'Sí' : 'No')),
                          DataCell(
                            ElevatedButton(
                              onPressed: () => _showEditProyectoDialog(proyecto),
                              child: Text('Modificar'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber[700],
                              ),
                            ),
                          ),
                          DataCell(
                            ElevatedButton(
                              onPressed: () =>
                                  _eliminarProyecto(proyecto['id_proyecto']),
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
