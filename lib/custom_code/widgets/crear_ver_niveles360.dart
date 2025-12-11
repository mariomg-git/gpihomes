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

import 'index.dart'; // Imports other custom widgets

import 'index.dart'; // Imports other custom widgets

import 'index.dart'; // Imports other custom widgets

import "dart:math";
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:gpi_homes/components/modal_ver_propiedad360_widget.dart';

String varidVirtualTour = ''; //PARAMETRIZAR
String varNivelSelect = '';
String varTourSelect = '';
bool isContinuarEnabled = false;

class CrearVerNiveles360 extends StatefulWidget {
  const CrearVerNiveles360({
    super.key,
    this.width,
    this.height,
    this.idpropiedad,
  });

  final double? width;
  final double? height;
  final String? idpropiedad;

  @override
  State<CrearVerNiveles360> createState() => _CrearVerNiveles360State();
}

class _CrearVerNiveles360State extends State<CrearVerNiveles360> {
  final nombreProjectController = TextEditingController();
  final nombreNivelesController = TextEditingController();
  final _ModalNivelesController = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    FFAppState().continuarVisible = false;
    _delayedFunction();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        // ElevatedButton(
        //   child: const Text('Seleccionar Tour'),
        //   onPressed: () {
        //     setState(() {
        //       // _isPickingImages = true; // Show loader
        //     });
        //     modalNiveles();
        //   },
        // ),
      ],
    ));
  }

  void _delayedFunction() async {
    await Future.delayed(Duration(seconds: 0));
    modalNiveles();
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
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
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
                      const SizedBox(height: 20.0),
                      const Text('Selecciona un Tour',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.lightBlue)),
                      const SizedBox(height: 10.0),
                      // List of proyecto from Firestore
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('virtualTours')
                            .where('idPropiedad', isEqualTo: widget.idpropiedad)
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
                                        // IconButton(
                                        //   icon: Icon(Icons.delete),
                                        //   onPressed: () {
                                        //     showDialog(
                                        //       context: context,
                                        //       builder: (BuildContext context) {
                                        //         return AlertDialog(
                                        //           title:
                                        //               Text('Eliminar Proyecto'),
                                        //           content: Text(
                                        //               '¿Estás seguro de que quieres eliminar este Proyecto?'),
                                        //           actions: <Widget>[
                                        //             TextButton(
                                        //               child: Text('Cancelar'),
                                        //               onPressed: () {
                                        //                 Navigator.of(context)
                                        //                     .pop();
                                        //               },
                                        //             ),
                                        //             TextButton(
                                        //               child: Text('Eliminar'),
                                        //               onPressed: () async {
                                        //                 await deleteTours(
                                        //                     nivel.id);
                                        //                 await deleteNivels(
                                        //                     nivel.id);

                                        //                 await FirebaseFirestore
                                        //                     .instance
                                        //                     .collection(
                                        //                         'virtualTours')
                                        //                     .doc(nivel.id)
                                        //                     .delete();
                                        //                 Navigator.of(context)
                                        //                     .pop();
                                        //               },
                                        //             ),
                                        //           ],
                                        //         );
                                        //       },
                                        //     );
                                        //   },
                                        // ),
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

  Future<String?> getPrincipalDocumentId(String idProp, String nivelId) async {
    print('jun10-nivelid:' + nivelId);
    // Obtener la instancia de Firestore
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Obtener la colección 'virtualTours' filtrando por 'idPropiedad'
      CollectionReference virtualTours = firestore.collection('virtualTours');

      // Consultar documentos en 'virtualTours' donde 'idPropiedad' sea igual a 'idProp'
      QuerySnapshot querySnapshot =
          await virtualTours.where('idPropiedad', isEqualTo: idProp).get();

      if (querySnapshot.docs.isNotEmpty) {
        // Iterar sobre los documentos filtrados por 'idPropiedad'
        for (var doc in querySnapshot.docs) {
          // Obtener la subcolección 'tours' del documento actual
          CollectionReference tours = doc.reference.collection('tours');

          // Consultar documentos en 'tours' donde 'isPrincipal' sea true y 'idNivel' sea igual a 'nivelx'
          QuerySnapshot toursSnapshot = await tours
              .where('isPrincipal', isEqualTo: true)
              .where('idNivel', isEqualTo: nivelId)
              .get();

          // Verificar si hay algún documento que cumpla con la condición
          if (toursSnapshot.docs.isNotEmpty) {
            // Retornar el ID del primer documento encontrado
            setState(() {
              FFAppState().globalVar1 = toursSnapshot.docs.first.id;
              print('jun12-app:' + FFAppState().globalVar1);
              print('jun10-globalvar1:' + nivelId);
            });
            return toursSnapshot.docs.first.id;
          }
        }
      }

      // No se encontró ningún documento con 'isPrincipal' igual a true
      return null;
    } catch (e) {
      // Manejar cualquier error que ocurra durante la consulta
      print('Error obteniendo el documento principal: $e');
      return null;
    }
  }

  Future<void> _readPrincipal(String setPrincipal) async {
    try {
      // Instancia de Firestore
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      final now = Timestamp.fromDate(DateTime.now());

      // Documento a ser guardado
      Map<String, dynamic> data = {
        'isPrincipal': true,
        'aFechaActualizacion': now,
      };

      // Guardar el documento en Firestore
      await firestore
          .collection('virtualTours')
          .doc(varidVirtualTour)
          .collection('tours')
          .doc(setPrincipal)
          .update(data);

      setState(() {
        // idPrincipal = setPrincipal;
        // varOcultar = true;
      });

      FFAppState().globalVar1 = setPrincipal;

      print('Documento guardado en Firestore');
    } catch (error) {
      print('Error al guardar el documento en Firestore: $error');
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Guardado Correctamente'),
      ),
    );

    bool confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Se marco imagen de Inicio Correctamente'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true); // Yes
            },
            child: Text('Ok'),
          ),
        ],
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
                    // SizedBox(height: 10),
                    // const Text(
                    //   '3.- Escribe un Nivel (Planta Baja)',
                    //   style: TextStyle(
                    //     fontSize: 18.0,
                    //     fontWeight: FontWeight.bold,
                    //     color: Colors.lightBlue,
                    //   ),
                    // ),
                    // const SizedBox(height: 10.0),
                    // // Form to add new nivel
                    // TextFormField(
                    //   controller: nombreNivelesController,
                    //   decoration: const InputDecoration(
                    //     labelText: 'ejemplo: Primer Piso',
                    //   ),
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Por favor, ingresa un nombre para el nivel.';
                    //     }
                    //     return null;
                    //   },
                    // ),
                    // ElevatedButton(
                    //   child: const Text('Guardar Nivel'),
                    //   onPressed: () async {
                    //     final path = 'virtualTours/' + idRef + '/niveles';
                    //     final nombre = nombreNivelesController.text.trim();
                    //     if (nombre.isNotEmpty) {
                    //       final fechaCreacion = DateTime.now();
                    //       await FirebaseFirestore.instance
                    //           .collection(path)
                    //           .add({
                    //         'nombre': nombre,
                    //         'aFechaCreacion': fechaCreacion,
                    //       });
                    //       ScaffoldMessenger.of(context).showSnackBar(
                    //         SnackBar(
                    //           content: Text('Nivel creado exitosamente'),
                    //         ),
                    //       );
                    //       nombreNivelesController.clear();
                    //     }
                    //   },
                    // ),
                    const SizedBox(height: 20.0),
                    const Text(
                      'Selecciona un Nivel',
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
                                      print('jun12:' + nivel.id);
                                      getPrincipalDocumentId(
                                          widget.idpropiedad!, nivel.id);
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Continuar'),
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
                                                      .continuarVisible = true;

                                                  // Navegar a la pantalla widget350
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ModalVerPropiedad360Widget(
                                                              idProp: widget
                                                                  .idpropiedad),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
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
