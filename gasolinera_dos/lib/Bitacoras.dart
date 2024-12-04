import 'package:flutter/material.dart';
import 'BaseScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Bitacoras extends StatefulWidget {
  final int idUsuario;

  Bitacoras({required this.idUsuario});

  @override
  _BitacorasState createState() => _BitacorasState();
}

class _BitacorasState extends State<Bitacoras> {
  List<dynamic> _bitacoras = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchBitacoras();
  }

  Future<void> _fetchBitacoras() async {
    final url = 'https://fundamentos-trabajo-final.fly.dev/bitacoras';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        setState(() {
          _bitacoras = json.decode(response.body);
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load bitacoras');
      }
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _deleteBitacora(int idBitacora) async {
    final url = 'https://fundamentos-trabajo-final.fly.dev/bitacoras/$idBitacora';
    try {
      final response = await http.delete(Uri.parse(url));

      if (response.statusCode == 200) {
        _fetchBitacoras(); // Actualiza la lista después de eliminar
      } else {
        throw Exception('Failed to delete bitacora. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during DELETE request: $e');
    }
  }

  Future<void> _modifyBitacora(int idBitacora, Map<String, dynamic> data) async {
    final url = 'https://fundamentos-trabajo-final.fly.dev/bitacoras/$idBitacora';
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(data),
      );
      if (response.statusCode == 200) {
        _fetchBitacoras(); // Actualiza la lista después de modificar
      } else {
        throw Exception('Failed to update bitacora. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during PUT request: $e');
    }
  }

  Future<void> _addBitacora(Map<String, dynamic> data) async {
    final url = 'https://fundamentos-trabajo-final.fly.dev/bitacoras';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(data),
      );
      if (response.statusCode == 200) {
        _fetchBitacoras(); // Actualiza la lista después de agregar
      } else {
        throw Exception('Failed to add bitacora. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during POST request: $e');
    }
  }

  void _showAddBitacoraDialog() {
    final TextEditingController comentarioController = TextEditingController();
    final TextEditingController kmInicialController = TextEditingController();
    final TextEditingController kmFinalController = TextEditingController();
    final TextEditingController numGalonesController = TextEditingController();
    final TextEditingController costoController = TextEditingController();
    final TextEditingController tipoGasolinaController = TextEditingController();
    final TextEditingController idUsrController = TextEditingController();
    final TextEditingController idVehiculoController = TextEditingController();
    final TextEditingController idGasolineraController = TextEditingController();
    final TextEditingController idProyectoController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Agregar Bitácora'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: comentarioController,
                  decoration: InputDecoration(labelText: 'Comentario'),
                ),
                TextField(
                  controller: kmInicialController,
                  decoration: InputDecoration(labelText: 'Km Inicial'),
                ),
                TextField(
                  controller: kmFinalController,
                  decoration: InputDecoration(labelText: 'Km Final'),
                ),
                TextField(
                  controller: numGalonesController,
                  decoration: InputDecoration(labelText: 'Número de Galones'),
                ),
                TextField(
                  controller: costoController,
                  decoration: InputDecoration(labelText: 'Costo'),
                ),
                TextField(
                  controller: tipoGasolinaController,
                  decoration: InputDecoration(labelText: 'Tipo de Gasolina'),
                ),
                TextField(
                  controller: idUsrController,
                  decoration: InputDecoration(labelText: 'ID Usuario'),
                ),
                TextField(
                  controller: idVehiculoController,
                  decoration: InputDecoration(labelText: 'ID Vehículo'),
                ),
                TextField(
                  controller: idGasolineraController,
                  decoration: InputDecoration(labelText: 'ID Gasolinera'),
                ),
                TextField(
                  controller: idProyectoController,
                  decoration: InputDecoration(labelText: 'ID Proyecto'),
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
                _addBitacora({
                  "comentario": comentarioController.text,
                  "km_inicial": int.parse(kmInicialController.text),
                  "km_final": int.parse(kmFinalController.text),
                  "num_galones": double.parse(numGalonesController.text),
                  "costo": double.parse(costoController.text),
                  "tipo_gasolina": tipoGasolinaController.text,
                  "id_usr": int.parse(idUsrController.text),
                  "id_vehiculo": int.parse(idVehiculoController.text),
                  "id_gasolinera": int.parse(idGasolineraController.text),
                  "id_proyecto": int.parse(idProyectoController.text),
                });
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(Map<String, dynamic> bitacora) {
    final TextEditingController comentarioController = TextEditingController(text: bitacora['comentario']);
    final TextEditingController kmInicialController = TextEditingController(text: bitacora['km_inicial'].toString());
    final TextEditingController kmFinalController = TextEditingController(text: bitacora['km_final'].toString());
    final TextEditingController numGalonesController = TextEditingController(text: bitacora['num_galones'].toString());
    final TextEditingController costoController = TextEditingController(text: bitacora['costo'].toString());
    final TextEditingController tipoGasolinaController = TextEditingController(text: bitacora['tipo_gasolina']);
    final TextEditingController idUsrController = TextEditingController(text: bitacora['id_usr'].toString());
    final TextEditingController idVehiculoController = TextEditingController(text: bitacora['id_vehiculo'].toString());
    final TextEditingController idGasolineraController = TextEditingController(text: bitacora['id_gasolinera'].toString());
    final TextEditingController idProyectoController = TextEditingController(text: bitacora['id_proyecto'].toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Modificar Bitácora'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: comentarioController,
                  decoration: InputDecoration(labelText: 'Comentario'),
                ),
                TextField(
                  controller: kmInicialController,
                  decoration: InputDecoration(labelText: 'Km I'),
                ),
                TextField(
                  controller: kmFinalController,
                  decoration: InputDecoration(labelText: 'Km F'),
                ),
                TextField(
                  controller: numGalonesController,
                  decoration: InputDecoration(labelText: 'N° Galones'),
                ),
                TextField(
                  controller: costoController,
                  decoration: InputDecoration(labelText: 'Costo'),
                ),
                TextField(
                  controller: tipoGasolinaController,
                  decoration: InputDecoration(labelText: 'Gasolina'),
                ),
                TextField(
                  controller: idUsrController,
                  decoration: InputDecoration(labelText: 'Usuario'),
                ),
                TextField(
                  controller: idVehiculoController,
                  decoration: InputDecoration(labelText: 'Vehículo'),
                ),
                TextField(
                  controller: idGasolineraController,
                  decoration: InputDecoration(labelText: 'Gasolinera'),
                ),
                TextField(
                  controller: idProyectoController,
                  decoration: InputDecoration(labelText: 'Proyecto'),
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
                _modifyBitacora(bitacora['id_bitacora'], {
                  "comentario": comentarioController.text,
                  "km_inicial": int.parse(kmInicialController.text),
                  "km_final": int.parse(kmFinalController.text),
                  "num_galones": double.parse(numGalonesController.text),
                  "costo": double.parse(costoController.text),
                  "tipo_gasolina": tipoGasolinaController.text,
                  "id_usr": int.parse(idUsrController.text),
                  "id_vehiculo": int.parse(idVehiculoController.text),
                  "id_gasolinera": int.parse(idGasolineraController.text),
                  "id_proyecto": int.parse(idProyectoController.text),
                });
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
      title: 'Bitácoras',
      idUsuario: widget.idUsuario,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: _showAddBitacoraDialog,
              child: Text('Agregar Bitácora'),
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
                            DataColumn(label: Text('Comentario', style: TextStyle(fontSize: 10))),
                            DataColumn(label: Text('Km I', style: TextStyle(fontSize: 10))),
                            DataColumn(label: Text('Km F', style: TextStyle(fontSize: 10))),
                            DataColumn(label: Text('N° Galones', style: TextStyle(fontSize: 10))),
                            DataColumn(label: Text('Costo', style: TextStyle(fontSize: 10))),
                            DataColumn(label: Text('Gasolina', style: TextStyle(fontSize: 10))),
                            DataColumn(label: Text('Usuario', style: TextStyle(fontSize: 10))),
                            DataColumn(label: Text('Vehículo', style: TextStyle(fontSize: 10))),
                            DataColumn(label: Text('Gasolinera', style: TextStyle(fontSize: 10))),
                            DataColumn(label: Text('Proyecto', style: TextStyle(fontSize: 10))),
                            DataColumn(label: Text('Modificar', style: TextStyle(fontSize: 10))),
                            DataColumn(label: Text('Eliminar', style: TextStyle(fontSize: 10))),

                          ],
                          rows: _bitacoras.map((bitacora) {
                            return DataRow(cells: [
                              DataCell(Text(bitacora['comentario'], style: TextStyle(fontSize: 10))),
                              DataCell(Text(bitacora['km_inicial'].toString(), style: TextStyle(fontSize: 10))),
                              DataCell(Text(bitacora['km_final'].toString(), style: TextStyle(fontSize: 10))),
                              DataCell(Text(bitacora['num_galones'].toString(), style: TextStyle(fontSize: 10))),
                              DataCell(Text(bitacora['costo'].toString(), style: TextStyle(fontSize: 10))),
                              DataCell(Text(bitacora['tipo_gasolina'], style: TextStyle(fontSize: 10))),
                              DataCell(Text(bitacora['id_usr'].toString(), style: TextStyle(fontSize: 10))),
                              DataCell(Text(bitacora['id_vehiculo'].toString(), style: TextStyle(fontSize: 10))),
                              DataCell(Text(bitacora['id_gasolinera'].toString(), style: TextStyle(fontSize: 10))),
                              DataCell(Text(bitacora['id_proyecto'].toString(), style: TextStyle(fontSize: 10))),

                              DataCell(
                                ElevatedButton(
                                  onPressed: () {
                                    _showEditDialog(bitacora);
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
                                    _deleteBitacora(bitacora['id_bitacora']);
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
