import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'BaseScreen.dart';

class Usuarios extends StatefulWidget {
  final int idUsuario;

  Usuarios({required this.idUsuario});
  @override
  _TablaScreenState createState() => _TablaScreenState();
}

class _TablaScreenState extends State<Usuarios> {
  List<dynamic> _users = [];
  Map<int, String> _roles = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final usersUrl = 'https://fundamentos-trabajo-final.fly.dev/usuarios';
    final rolesUrl = 'https://fundamentos-trabajo-final.fly.dev/roles';
    try {
      final usersResponse = await http.get(Uri.parse(usersUrl));
      final rolesResponse = await http.get(Uri.parse(rolesUrl));

      if (usersResponse.statusCode == 200 && rolesResponse.statusCode == 200) {
        setState(() {
          final allUsers = json.decode(usersResponse.body) as List<dynamic>;
          _users = allUsers.where((user) => user['eliminado'] == false).toList();

          final rolesData = json.decode(rolesResponse.body);
          _roles = {
            for (var role in rolesData) role['id_rol']: role['descripcion']
          };

          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _eliminarUsuario(int id, String nombre, String apellido, String username, int idRol, int activo) async {
    final url = 'https://fundamentos-trabajo-final.fly.dev/usuarios/$id';
    final Map<String, dynamic> requestBody = {
      "nombre": nombre,
      "apellido": apellido,
      "username": username,
      "id_rol": idRol,
      "activo": activo,
      "eliminado": true
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
        await _fetchData(); // Actualiza la lista después de eliminar
      } else {
        throw Exception('Failed to mark user as deleted. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during PUT request: $e');
    }
  }

  Future<void> _modificarUsuario(int id, String nombre, String apellido, String username, int idRol, int activo) async {
    final url = 'https://fundamentos-trabajo-final.fly.dev/usuarios/$id';
    final Map<String, dynamic> requestBody = {
      "nombre": nombre,
      "apellido": apellido,
      "username": username,
      "id_rol": idRol,
      "activo": activo,
      "eliminado": false
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
        await _fetchData(); // Actualiza la lista después de modificar
      } else {
        throw Exception('Failed to update user. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during PUT request: $e');
    }
  }

  Future<void> _agregarUsuario(String nombre, String apellido, String username, int idRol, int activo, String password,bool eliminado) async {
    final url = 'https://fundamentos-trabajo-final.fly.dev/usuarios';
    final Map<String, dynamic> requestBody = {
      "nombre": nombre,
      "apellido": apellido,
      "username": username,
      "id_rol": idRol,
      "activo": activo,
      "eliminado": false,
      "password": password
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
        await _fetchData(); // Actualiza la lista después de agregar
      } else {
        throw Exception('Failed to add user. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during POST request: $e');
    }
  }

  
void _showAddUserDialog() {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidoController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  int idRol = _roles.keys.first;
  int activo = 1;
  bool eliminado = false; // Definimos el valor de 'eliminado'

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Agregar Usuario'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: nombreController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: apellidoController,
              decoration: InputDecoration(labelText: 'Apellido'),
            ),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            DropdownButtonFormField<int>(
              value: idRol,
              onChanged: (value) {
                setState(() {
                  idRol = value!;
                });
              },
              items: _roles.entries.map<DropdownMenuItem<int>>((entry) {
                return DropdownMenuItem<int>(
                  value: entry.key,
                  child: Text(entry.value),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Rol'),
            ),
            DropdownButtonFormField<int>(
              value: activo,
              onChanged: (value) {
                setState(() {
                  activo = value!;
                });
              },
              items: [
                DropdownMenuItem<int>(
                  value: 1,
                  child: Text('Sí'),
                ),
                DropdownMenuItem<int>(
                  value: 0,
                  child: Text('No'),
                ),
              ],
              decoration: InputDecoration(labelText: 'Activo'),
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
              _agregarUsuario(
                nombreController.text,
                apellidoController.text,
                usernameController.text,
                idRol,
                activo,
                passwordController.text,
                eliminado
              );
            },
          ),
        ],
      );
    },
  );
}


  void _showEditDialog(Map<String, dynamic> user) {
  final TextEditingController nombreController = TextEditingController(text: user['nombre']);
  final TextEditingController apellidoController = TextEditingController(text: user['apellido']);
  final TextEditingController usernameController = TextEditingController(text: user['username']);
  int idRol = user['id_rol'];
  int activo = user['activo'];

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Modificar Usuario'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: nombreController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: apellidoController,
              decoration: InputDecoration(labelText: 'Apellido'),
            ),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            DropdownButtonFormField<int>(
              value: idRol,
              onChanged: (value) {
                setState(() {
                  idRol = value!;
                });
              },
              items: _roles.entries.map<DropdownMenuItem<int>>((entry) {
                return DropdownMenuItem<int>(
                  value: entry.key,
                  child: Text(entry.value),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Rol'),
            ),
            DropdownButtonFormField<int>(
              value: activo,
              onChanged: (value) {
                setState(() {
                  activo = value!;
                });
              },
              items: [
                DropdownMenuItem<int>(
                  value: 1,
                  child: Text('Sí'),
                ),
                DropdownMenuItem<int>(
                  value: 0,
                  child: Text('No'),
                ),
              ],
              decoration: InputDecoration(labelText: 'Activo'),
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
              _modificarUsuario(
                user['id_usr'],
                nombreController.text,
                apellidoController.text,
                usernameController.text,
                idRol,
                activo,
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
      title: 'Usuarios',
      idUsuario: widget.idUsuario,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: _showAddUserDialog,
              child: Text('Agregar Usuario'),
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
                            DataColumn(label: Text('Nombre')),
                            DataColumn(label: Text('Apellido')),
                            DataColumn(label: Text('Username')),
                            DataColumn(label: Text('Rol')),
                            DataColumn(label: Text('Activo')),
                            DataColumn(label: Text('Modificar')),
                            DataColumn(label: Text('Eliminar')),
                          ],
                          rows: _users.map((user) {
                            return DataRow(cells: [
                              DataCell(Text(user['nombre'])),
                              DataCell(Text(user['apellido'])),
                              DataCell(Text(user['username'])),
                              DataCell(Text(_roles[user['id_rol']] ?? 'Desconocido')),
                              DataCell(Text(user['activo'] == 1 ? 'Sí' : 'No')),
                              DataCell(
                                ElevatedButton(
                                  onPressed: () {
                                    _showEditDialog(user);
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
                                    _eliminarUsuario(
                                      user['id_usr'],
                                      user['nombre'],
                                      user['apellido'],
                                      user['username'],
                                      user['id_rol'],
                                      user['activo'],
                                    );
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
