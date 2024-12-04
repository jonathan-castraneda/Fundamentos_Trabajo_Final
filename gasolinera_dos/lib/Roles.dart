import 'package:flutter/material.dart';
import 'BaseScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Roles extends StatefulWidget {
  final int idUsuario;

  Roles({required this.idUsuario});

  @override
  _RolesState createState() => _RolesState();
}

class _RolesState extends State<Roles> {
  List<dynamic> _roles = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchRoles();
  }

  Future<void> _fetchRoles() async {
    final url = 'https://fundamentos-trabajo-final.fly.dev/roles';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        setState(() {
          _roles = json.decode(response.body);
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load roles');
      }
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _deleteRole(int idRol) async {
    final url = 'https://fundamentos-trabajo-final.fly.dev/roles/$idRol';
    try {
      final response = await http.delete(Uri.parse(url));

      if (response.statusCode == 200) {
        _fetchRoles(); // Actualiza la lista después de eliminar
      } else {
        throw Exception('Failed to delete role. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during DELETE request: $e');
    }
  }

  Future<void> _modifyRole(int idRol, String descripcion) async {
    final url = 'https://fundamentos-trabajo-final.fly.dev/roles/$idRol';
    final Map<String, dynamic> requestBody = {
      "descripcion": descripcion,
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
        _fetchRoles(); // Actualiza la lista después de modificar
      } else {
        throw Exception('Failed to update role. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during PUT request: $e');
    }
  }

  void _showEditDialog(Map<String, dynamic> role) {
    final TextEditingController descripcionController = TextEditingController(text: role['descripcion']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Modificar Rol'),
          content: TextField(
            controller: descripcionController,
            decoration: InputDecoration(labelText: 'Descripción'),
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
                _modifyRole(role['id_rol'], descripcionController.text);
              },
            ),
          ],
        );
      },
    );
  }

  void _showAddRoleDialog() {
    final TextEditingController descripcionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Agregar Rol'),
          content: TextField(
            controller: descripcionController,
            decoration: InputDecoration(labelText: 'Descripción'),
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
                _addRole(descripcionController.text);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _addRole(String descripcion) async {
    final url = 'http://127.0.0.1:8000/roles';
    final Map<String, dynamic> requestBody = {
      "descripcion": descripcion,
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
        _fetchRoles(); // Actualiza la lista después de agregar
      } else {
        throw Exception('Failed to add role. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during POST request: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Roles',
      idUsuario: widget.idUsuario,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: _showAddRoleDialog,
              child: Text('Agregar Rol'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                textStyle: TextStyle(color: Colors.white),
              ),
            ),
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: [
                            DataColumn(label: Text('Descripción')),
                            DataColumn(label: Text('Modificar')),
                            DataColumn(label: Text('Eliminar')),
                          ],
                          rows: _roles.map((role) {
                            return DataRow(cells: [
                              DataCell(Text(role['descripcion'])),
                              DataCell(
                                ElevatedButton(
                                  onPressed: () {
                                    _showEditDialog(role);
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
                                    _deleteRole(role['id_rol']);
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
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
