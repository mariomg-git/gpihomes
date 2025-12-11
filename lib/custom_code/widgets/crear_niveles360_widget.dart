// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'index.dart'; // Imports other custom widgets

import 'index.dart'; // Imports other custom widgets

import "dart:math";
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:gpi_homes/pages/a360_pages/create_property360_panos/create_property360_panos_widget.dart';

String varidVirtualTour = ''; //PARAMETRIZAR
String varNivelSelect = '';
String varTourSelect = '';
bool isContinuarEnabled = false;

class CrearNiveles360Widget extends StatefulWidget {
  const CrearNiveles360Widget({
    super.key,
    this.width,
    this.height,
    this.idpropiedad,
  });

  final double? width;
  final double? height;
  final String? idpropiedad;

  @override
  State<CrearNiveles360Widget> createState() => _CrearNiveles360WidgetState();
}

class _CrearNiveles360WidgetState extends State<CrearNiveles360Widget> {
  final nombreProjectController = TextEditingController();
  final nombreNivelesController = TextEditingController();
  final _ModalNivelesController = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    FFAppState().continuarVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        ElevatedButton(
          child: const Text('1- Nuevo Tour'),
          onPressed: () {
            setState(() {
              // _isPickingImages = true; // Show loader
            });
            modalNiveles();
          },
        ),
      ],
    ));
  }

  void modalNiveles() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.black,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 50.0),
        child: Stack(
          children: [
            // Close button
            Positioned(
              top: 0.0,
              right: 0.0,
              child: IconButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                ),
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // Form content and Project
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('1.- Crear Versión',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.lightBlue)),
                      const SizedBox(height: 10.0),
                      // Form to add new nivel
                      TextFormField(
                        controller: nombreProjectController,
                        decoration: const InputDecoration(
                          labelText: 'Ingresa Nombre Versión',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa un nombre para la versión.';
                          }
                          return null;
                        },
                      ),
                      ElevatedButton(
                        child: const Text('Guardar Versión'),
                        onPressed: () async {
                          final nombre = nombreProjectController.text.trim();
                          if (nombre.isNotEmpty) {
                            final fechaCreacion = DateTime.now();
                            final docRef = await FirebaseFirestore.instance
                                .collection('virtualTours')
                                .add({
                              'nombre': nombre,
                              'idPropiedad':
                                  widget.idpropiedad, //FALTA PARAMETRIZAR
                              'aFechaCreacion': fechaCreacion,
                              'nivelesRef': FirebaseFirestore.instance
                                  .collection('virtualTours')
                                  .doc() // Reference to the subcollection 'niveles'
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Versión creada exitosamente'),
                              ),
                            );

                            nombreNivelesController.clear();
                          }
                        },
                      ),
                      const SizedBox(height: 20.0),
                      const Text('2.- Selecciona una Versión',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.lightBlue)),
                      const SizedBox(height: 10.0),
                      // List of proyecto from Firestore
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('virtualTours')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }
                          final niveles = snapshot.data!.docs;
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: niveles.length,
                            itemBuilder: (context, index) {
                              final nivel = niveles[index];
                              // Format the date
                              final fechaCreacion =
                                  nivel['aFechaCreacion'].toDate();
                              final formattedDate =
                                  DateFormat('dd-MM-yyyy HH:mm')
                                      .format(fechaCreacion);
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    varidVirtualTour = nivel.id;
                                    FFAppState().globalVar2 = nivel.id;
                                  });
                                  showNiveles(nivel.id,
                                      nivel.reference.collection('niveles'));
                                  // Call to showNiveles function
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white), // Borde blanco
                                    borderRadius: BorderRadius.circular(
                                        12), // Esquinas redondeadas
                                  ),
                                  child: ListTile(
                                    title: Text(nivel['nombre']),
                                    // subtitle: Text('IDR: ${nivel.id}'),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.delete),
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title:
                                                      Text('Eliminar Proyecto'),
                                                  content: Text(
                                                      '¿Estás seguro de que quieres eliminar este Proyecto?'),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child: Text('Cancelar'),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                    TextButton(
                                                      child: Text('Eliminar'),
                                                      onPressed: () async {
                                                        await deleteTours(
                                                            nivel.id);
                                                        await deleteNivels(
                                                            nivel.id);

                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'virtualTours')
                                                            .doc(nivel.id)
                                                            .delete();
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> deleteTours(String id) async {
    final collection = await FirebaseFirestore.instance
        .collection("virtualTours")
        .doc(id)
        .collection('tours')
        .get();

    final batch = FirebaseFirestore.instance.batch();

    for (final doc in collection.docs) {
      batch.delete(doc.reference);
    }

    return batch.commit();
  }

  Future<void> deleteNivels(String id) async {
    final collection = await FirebaseFirestore.instance
        .collection("virtualTours")
        .doc(id)
        .collection('niveles')
        .get();

    final batch = FirebaseFirestore.instance.batch();

    for (final doc in collection.docs) {
      batch.delete(doc.reference);
    }

    return batch.commit();
  }

  void showNiveles(String idRef, CollectionReference nivelesRef) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.95,
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 10),
                    const Text(
                      '3.- Escribe un Nivel (Planta Baja)',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlue,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    // Form to add new nivel
                    TextFormField(
                      controller: nombreNivelesController,
                      decoration: const InputDecoration(
                        labelText: 'ejemplo: Primer Piso',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingresa un nombre para el nivel.';
                        }
                        return null;
                      },
                    ),
                    ElevatedButton(
                      child: const Text('Guardar Nivel'),
                      onPressed: () async {
                        final path = 'virtualTours/' + idRef + '/niveles';
                        final nombre = nombreNivelesController.text.trim();
                        if (nombre.isNotEmpty) {
                          final fechaCreacion = DateTime.now();
                          await FirebaseFirestore.instance
                              .collection(path)
                              .add({
                            'nombre': nombre,
                            'aFechaCreacion': fechaCreacion,
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Nivel creado exitosamente'),
                            ),
                          );
                          nombreNivelesController.clear();
                        }
                      },
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      '4.- Selecciona un Nivel',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlue,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: nivelesRef.snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }
                          final niveles = snapshot.data!.docs;
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: niveles.length,
                            itemBuilder: (context, index) {
                              final nivel = niveles[index];
                              final fechaCreacion =
                                  nivel['aFechaCreacion'].toDate();
                              final formattedDate =
                                  DateFormat('dd-MM-yyyy HH:mm')
                                      .format(fechaCreacion);
                              final pathTours =
                                  'virtualTours/' + idRef + '/tours';

                              return FutureBuilder<QuerySnapshot>(
                                future: FirebaseFirestore.instance
                                    .collection(pathTours)
                                    .get(),
                                builder: (context, tourSnapshot) {
                                  if (tourSnapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  }
                                  final hasTours =
                                      tourSnapshot.data!.docs.isNotEmpty;
                                  return InkWell(
                                    onTap: () {
                                      if (hasTours) {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Error'),
                                              content: Text(
                                                  'Error debes Seleccionar una Version Vacia de Tours'),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: Text('Cancelar'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                TextButton(
                                                  child: Text('Okay'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Versión Correcto'),
                                              content: Text(
                                                  '¿Continuar con esta Versión?'),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: Text('Cancelar'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                TextButton(
                                                  child: Text('Okay'),
                                                  onPressed: () {
                                                    FFAppState().stateNivelid =
                                                        nivel.id;
                                                    setState(() {
                                                      varNivelSelect = nivel.id;
                                                    });

                                                    Navigator.of(context).pop();

                                                    isContinuarEnabled = false;
                                                    FFAppState()
                                                            .continuarVisible =
                                                        true;

                                                    // Navegar a la pantalla widget350
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            CreateProperty360PanosWidget(
                                                                idProperty: widget
                                                                    .idpropiedad,
                                                                idVirtualTour:
                                                                    FFAppState()
                                                                        .globalVar2),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: ListTile(
                                        title: Text(nivel['nombre']),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              icon: Icon(Icons.delete),
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text(
                                                          'Eliminar Nivel'),
                                                      content: Text(
                                                          '¿Estás seguro de que quieres eliminar este nivel?'),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          child:
                                                              Text('Cancelar'),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        ),
                                                        TextButton(
                                                          child:
                                                              Text('Eliminar'),
                                                          onPressed: () async {
                                                            await nivel
                                                                .reference
                                                                .delete();
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                    ElevatedButton(
                      child: const Text('Regresar'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  //end
}
