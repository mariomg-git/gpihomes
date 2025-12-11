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

import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:panorama/panorama.dart';
import "dart:math";
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

String varidVirtualTour = ''; //PARAMETRIZAR

bool _isPickingImages = false;
String varNivelSelect = '';
String varTourSelect = '';
var arrayTemp = [];

class View360WidgetNiveles extends StatefulWidget {
  const View360WidgetNiveles({
    super.key,
    this.width,
    this.height,
    required this.actionParam360wdget,
    this.idPropiedad,
  });

  final double? width;
  final double? height;
  final Future Function() actionParam360wdget;
  final String? idPropiedad;

  @override
  State<View360WidgetNiveles> createState() => _View360WidgetNivelesState();
}

class _View360WidgetNivelesState extends State<View360WidgetNiveles> {
  int _currentIndex = 0;
  String idPrincipal = '';
  bool varOcultar = false;

  final _panoramaModalController = GlobalKey<ScaffoldState>();

  final nombreProjectController = TextEditingController();
  final nombreNivelesController = TextEditingController();

  final controller = MultiImagePickerController(
    maxImages: 22,
    picker: (bool allowMultiple) async {
      return await pickImagesUsingFilePicker(allowMultiple);
    },
  );

  double _lon = 0;
  double _lat = 0;
  double _tilt = 0;

  var hotspotsArray = [
    Hotspot(),
  ];

  void onViewChanged(longitude, latitude, tilt) {
    setState(() {
      _lon = longitude;
      _lat = latitude;
      _tilt = tilt;
    });
  }

  Widget hotspotButton(
      {String? text, IconData? icon, VoidCallback? onPressed}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(Size(80.0, 80.0)),
            shape: MaterialStateProperty.all(CircleBorder()),
            backgroundColor: MaterialStateProperty.all(Colors.black38),
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
          child: Icon(
            icon,
            // Set the desired icon size
            size: 40.0, // Adjust this value as needed
          ),
          onPressed: onPressed,
        ),
        text != null
            ? Container(
                padding: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: Center(child: Text(text)),
              )
            : Container(),
      ],
    );
  }

  List<String> images = [
    'panorama.jpg',
    // 'panorama1.jpg',
    // 'panorama2.jpg',
    // ... Agrega más imágenes aquí
  ];

  final _multiImagePickerModalController = GlobalKey<ScaffoldState>();
  final _ModalNivelesController = GlobalKey<ScaffoldState>();
  final _firebasePanoController = GlobalKey<ScaffoldState>();

  void addHotspot(double lat, double lon) {
    setState(() {
      hotspotsArray.add(Hotspot(
        latitude: lat,
        longitude: lon,
        width: 100.0,
        height: 100.0,
        widget: Stack(
          // Use Stack for efficient button placement
          children: [
            hotspotButton(
              // Existing hotspot button
              icon: Icons.arrow_circle_up,

              //text: "Borrar",
              onPressed: () {
                selectPanorama(lat, lon);
                print(
                    'Info at ${lat.toStringAsFixed(3)}, ${lon.toStringAsFixed(3)}');
              },
            ),
            Positioned(
              // Position the new button in the corner
              right: 0.0, // Align to right edge
              bottom: 0.0, // Align to bottom edge
              child: IconButton(
                // Use IconButton for a smaller button
                icon: Icon(Icons.delete_outline_rounded),
                iconSize: 20.0,
                onPressed: () {
                  setState(() {
                    hotspotsArray.removeWhere((element) =>
                        element.latitude == lat && element.longitude == lon);
                  });
                },
              ),
            ),
          ],
        ),
      ));
    });
  }

  Future<List<Map<String, dynamic>>> getHotspotsFire(String idTourSpots) async {
    try {
      // Access Firestore instance
      final firestore = FirebaseFirestore.instance;

      // Reference to the specific document containing the data
      final docRef = firestore
          .collection('virtualTours')
          .doc(varidVirtualTour)
          .collection('tours')
          .doc(idTourSpots);

      // Get the document snapshot
      final docSnapshot = await docRef.get();

      // Check if document exists to avoid potential errors
      if (docSnapshot.exists) {
        // Extract the data map
        final data = docSnapshot.data() as Map<String, dynamic>;
        // Extract the 'hotspots' array (assuming it's an array)
        final hotspots = data['hotspots'] as List<dynamic>;
        // Convert each hotspot to a map for clarity (optional)
        final processedHotspots = hotspots.map((hotspot) {
          //idTour = hotspot['idTour'] as String;
          addHotspot(hotspot['lat'], hotspot['lon']);
          return hotspot as Map<String, dynamic>;
        }).toList();
        return processedHotspots; // Return the processed array
      } else {
        print('Document not found in Firestore');
        return []; // Return empty array if document doesn't exist
      }
    } catch (error) {
      print('Error no tiene hotspots: $error');
      return []; // Return empty array on error
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget panorama;
    panorama = Panorama(
      animSpeed: 0.0,
      //sensorControl: SensorControl.Orientation,
      onViewChanged: onViewChanged,
      onTap: (longitude, latitude, tilt) => addHotspot(latitude, longitude),
      child: Image.network(images[_currentIndex]),
      hotspots: hotspotsArray,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('360view'),
      ),
      body: Column(
        children: [
          Expanded(
            // Make panorama take up 50% of the height
            flex: 1,
            child: Stack(
              children: [
                panorama,
                Text(
                    '${_lon.toStringAsFixed(3)}, ${_lat.toStringAsFixed(3)}, ${_tilt.toStringAsFixed(3)}'),
                Positioned(
                  top: 20,
                  right: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      firebasePanorama();
                    },
                    child: const Icon(Icons.fullscreen_exit),
                  ),
                ),
                Positioned(
                  top: 60,
                  right: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      //saveNivel();
                    },
                    child: const Icon(Icons.save),
                  ),
                ),
              ],
            ),
          ),
          Container(height: 80, color: Colors.black),
          Expanded(
            // Make the remaining section (text and image picker) take up 50%
            flex: 1,
            child: MultiImagePickerView(
              controller: controller,
              draggable: true,
              longPressDelayMilliseconds: 100, //TIEMPO DE ESPERA PARA ARRASTRAR
              onDragBoxDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color:
                        Theme.of(context).colorScheme.shadow.withOpacity(0.5),
                    blurRadius: 5,
                  ),
                ],
              ),
              shrinkWrap: false,
              padding: const EdgeInsets.all(0),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 170,
                childAspectRatio: 0.8,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
              ),
              builder: (context, imageFile) {
                //images.add(imageFile.name.split('scaled_').last);
                final filename = imageFile.name?.split('scaled_')?.last ??
                    'Unknown'; // Extract filename and extension

                return Stack(
                  children: [
                    Positioned.fill(
                      child: InkWell(
                        onTap: () {
                          print('borrar hotspots: ' + hotspotsArray.toString());
                          setState(() {
                            hotspotsArray.clear();
                          });

                          getHotspotsFire(imageFile.extension);

                          setState(() {});

                          print('.extension usado para enviar id:' +
                              imageFile
                                  .extension); //AQUI APROBECHE EL CAMPO .extension, PARA GUARDAR EL ID

                          varTourSelect = imageFile.extension;

                          loadPanoramaImage(imageFile
                              .path!); // Imprimir el nombre de la imagen con extensión
                        },
                        child: ImageFileView(imageFile: imageFile),
                      ),
                    ),
                    if (idPrincipal == imageFile.extension)
                      Positioned(
                        top: 4,
                        left: 4,
                        child: DraggableItemInkWell(
                          borderRadius: BorderRadius.circular(2),
                          onPressed: () {},
                          child: Container(
                            padding: const EdgeInsets.all(0),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),
                              shape: BoxShape.rectangle,
                            ),
                            child: Icon(
                              Icons.arrow_right_outlined,
                              size: 48,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    if (varOcultar == false)
                      Positioned(
                        top: 4,
                        left: 4,
                        child: DraggableItemInkWell(
                          borderRadius: BorderRadius.circular(2),
                          onPressed: () {
                            _setPrincipal(imageFile.extension);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),
                              shape: BoxShape.rectangle,
                            ),
                            child: Text('Inicio'),
                          ),
                        ),
                      ),
                    if (idPrincipal != imageFile.extension)
                      Positioned(
                        top: 4,
                        right: 4,
                        child: DraggableItemInkWell(
                          borderRadius: BorderRadius.circular(2),
                          onPressed: () => controller.removeImage(imageFile),
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.delete_forever_rounded,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    Positioned(
                      bottom: 2,
                      left: 5,
                      child: Text(
                        filename,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                );
              },
              initialWidget: SizedBox(
                height: 170,
                width: double.infinity,
                child: Center(
                  child: Stack(
                    children: [
                      // Show loader conditionally on top of everything
                      if (_isPickingImages)
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                      // Position buttons at the bottom using Align
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          // Arrange buttons vertically
                          mainAxisSize:
                              MainAxisSize.min, // Minimize space occupied
                          children: [
                            ElevatedButton(
                              child: const Text('1- Nuevo Tour'),
                              onPressed: () {
                                setState(() {
                                  _isPickingImages = true; // Show loader
                                });
                                modalNiveles();
                              },
                            ),
                            const SizedBox(
                                height: 8), // Add spacing between buttons
                            Text('VirtualTour Seleccionado: ' +
                                varidVirtualTour),
                            Text('Nivel Seleccionado: ' + varNivelSelect),
                            const SizedBox(
                                height: 8), // Add spacing between buttons
                            ElevatedButton(
                              child: const Text('2-Agregar Imagenes'),
                              onPressed: () {
                                setState(() {
                                  _isPickingImages = true; // Show loader
                                });
                                controller.pickImages();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              addMoreButton: Stack(
                children: [
                  if (_isPickingImages) // Show loader when picking images
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  SizedBox(
                    height: 170,
                    width: double.infinity,
                    child: Center(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.green.withOpacity(0.2),
                          shape: const CircleBorder(),
                        ),
                        onPressed: () {
                          setState(() {
                            _isPickingImages = true; // Show loader
                          });
                          controller.pickImages();
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.add,
                            color: Colors.green,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _setPrincipal(String setPrincipal) async {
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
        idPrincipal = setPrincipal;
        varOcultar = true;
      });

      FFAppState().globalVar1 = setPrincipal;

      print('Documento guardado en Firestore');
    } catch (error) {
      print('Error al guardar el documento en Firestore: $error');
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Saved to Firebase'),
      ),
    );

    bool confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Saved'),
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

  void loadPanoramaImage(String imageName) {
    print('load Panorama: ' + imageName);
    images.clear();
    images.add(imageName);
    //print(images.toString());

    // Find the index of the selected image in the images list
    int selectedIndex = images.indexOf(imageName);
    if (selectedIndex != -1) {
      setState(() {
        _currentIndex = selectedIndex;

        //print(_currentIndex);
      });
    }
  }

  void selectPanorama(double lat, double lon) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Scaffold(
        key: _multiImagePickerModalController,
        appBar: AppBar(
          title: const Text('Select Images'),
        ),
        body: MultiImagePickerView(
          controller: controller,
          draggable: true,
          longPressDelayMilliseconds: 100,
          onDragBoxDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.shadow.withOpacity(0.5),
                blurRadius: 5,
              ),
            ],
          ),
          shrinkWrap: false,
          padding: const EdgeInsets.all(0),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 170,
            childAspectRatio: 0.8,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
          ),
          builder: (context, imageFile) {
            //images.add(imageFile.name.split('scaled_').last);
            final filename = imageFile.name?.split('scaled_')?.last ??
                'Unknown'; // Extract filename and extension
            return Stack(
              children: [
                Positioned.fill(
                  child: InkWell(
                    onTap: () async {
                      //print('yyy: ' + imageFile.extension);
                      // Mostrar diálogo de confirmación
                      bool confirm = await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Confirm Save'),
                          content: Text('Do you want to save to Firebase?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(false); // No
                              },
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(true); // Yes
                              },
                              child: Text('Save'),
                            ),
                          ],
                        ),
                      );

                      // Si el usuario confirma, guardar en Firebase
                      if (confirm == true) {
                        print(
                            'Coords ${lat.toStringAsFixed(5)}, ${lon.toStringAsFixed(5)}');
                        print('Nombre de la Imagen:' +
                            imageFile
                                .path!); // Imprimir el nombre de la imagen con extensión
                        try {
                          // Instancia de Firestore
                          FirebaseFirestore firestore =
                              FirebaseFirestore.instance;
                          final now = Timestamp.fromDate(DateTime.now());

                          // Documento a ser guardado
                          Map<String, dynamic> data = {
                            'aFechaActualizacion': now,
                            //'imageTour': imageFile.path!,
                            'hotspots': FieldValue.arrayUnion([
                              {
                                'lat': lat,
                                'lon': lon,
                                'idTour': imageFile.extension,
                                'zLink': imageFile.path!,
                              }
                            ])
                          };

                          // Guardar el documento en Firestore
                          await firestore
                              .collection('virtualTours')
                              .doc(varidVirtualTour)
                              .collection('tours')
                              .doc(varTourSelect)
                              .update(data);

                          print('Documento guardado en Firestore');
                        } catch (error) {
                          print(
                              'Error al guardar el documento en Firestore: $error');
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Saved to Firebase'),
                          ),
                        );

                        bool confirm = await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Saved'),
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
                        // Cierra el modal
                        Navigator.of(context).pop();
                      }
                    },
                    child: ImageFileView(imageFile: imageFile),
                  ),
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: DraggableItemInkWell(
                    borderRadius: BorderRadius.circular(2),
                    onPressed: () => controller.removeImage(imageFile),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.4),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.delete_forever_rounded,
                        size: 18,
                        color: Theme.of(context).colorScheme.background,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 2,
                  left: 5,
                  child: Text(
                    filename,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
          initialWidget: SizedBox(
            height: 170,
            width: double.infinity,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      controller.pickImages();
                    },
                    child: const Text('Add More Images'),
                  ),
                ],
              ),
            ),
          ),
          addMoreButton: SizedBox(
            height: 170,
            width: double.infinity,
            child: Center(
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue.withOpacity(0.2),
                  shape: const CircleBorder(),
                ),
                onPressed: controller.pickImages,
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.add,
                    color: Colors.blue,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
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
                      const Text('Nueva Versión Recorrido...',
                          style: TextStyle(fontSize: 18.0)),
                      const SizedBox(height: 10.0),
                      // Form to add new nivel
                      TextFormField(
                        controller: nombreProjectController,
                        decoration: const InputDecoration(
                          labelText: 'Nombre Versión',
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
                                  widget.idPropiedad, //FALTA PARAMETRIZAR
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
                                child: ListTile(
                                  title: Text(nivel['nombre']),
                                  subtitle: Text('IDR: ${nivel.id}'),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Edit ${nivel['nombre']}'),
                                            ),
                                          );
                                        },
                                      ),
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
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Niveles...', style: TextStyle(fontSize: 18.0)),
          const SizedBox(height: 10.0),
          // Form to add new nivel
          TextFormField(
            controller: nombreNivelesController,
            decoration: const InputDecoration(
              labelText: 'Nombre',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, ingresa un nombre para el nivel.';
              }
              return null;
            },
          ),
          ElevatedButton(
            child: const Text('Guardar Niveles'),
            onPressed: () async {
              final path = 'virtualTours/' + idRef + '/niveles';
              final nombre = nombreNivelesController.text.trim();
              if (nombre.isNotEmpty) {
                final fechaCreacion = DateTime.now();
                await FirebaseFirestore.instance.collection(path).add({
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
          //////////////

          Container(
            // Same UI setup as before
            child: StreamBuilder<QuerySnapshot>(
              stream: nivelesRef.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                final niveles = snapshot.data!.docs;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: niveles.length,
                  itemBuilder: (context, index) {
                    final nivel = niveles[index];
                    // Format the date
                    final fechaCreacion = nivel['aFechaCreacion'].toDate();
                    final formattedDate =
                        DateFormat('dd-MM-yyyy HH:mm').format(fechaCreacion);
                    return InkWell(
                      onTap: () {
                        print('nivel id:' + nivel.id);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(' Nivel Seleccionado'),
                              content: Text(
                                  '¿Estás seguro de que quieres seleccionar este nivel?'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Cancelar'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text('Okay'),
                                  onPressed: () async {
                                    setState(() {
                                      varNivelSelect = nivel.id;
                                    });

                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: ListTile(
                        title: Text(nivel['nombre']),
                        subtitle: Text('IDR: ${nivel.id}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Edit ${nivel['nombre']}'),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Eliminar Nivel'),
                                      content: Text(
                                          '¿Estás seguro de que quieres eliminar este nivel?'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('Cancelar'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: Text('Eliminar'),
                                          onPressed: () async {
                                            await nivel.reference.delete();
                                            Navigator.of(context).pop();
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
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void firebasePanorama() {
    widget.actionParam360wdget!();
  }

  //end state
}

Future<List<ImageFile>> pickImagesUsingFilePicker(bool allowMultiple) async {
  const allowedExtensions = ['png', 'jpeg', 'jpg'];
  final result = await FilePicker.platform.pickFiles(
    allowMultiple: allowMultiple,
    type: FileType.custom,
    withData: kIsWeb,
    allowedExtensions: allowedExtensions,
  );

  if (result != null && result.files.isNotEmpty) {
    final selectedFiles = result.files
        .where((e) =>
            e.extension != null &&
            allowedExtensions.contains(e.extension?.toLowerCase()))
        .toList();

    final uploadedImages = await Future.wait(selectedFiles.map((file) async {
      // Show loader
      showLoadingDialog(); // Replace with your loader showing function

      // Prepare upload task based on platform (web vs. mobile)
      UploadTask uploadTask;
      if (kIsWeb) {
        // Handle web upload using bytes or data URL (replace with your actual logic)
        final bytes = file.bytes != null ? file.bytes! : Uint8List(0);
        uploadTask = FirebaseStorage.instance
            .ref('propiedades/images/${file.name.toString()}')
            .putData(bytes);
      } else {
        // Handle mobile upload using file path (replace with your actual logic)
        final filePath =
            file.path!; // Assuming you have access to file path on mobile
        uploadTask = FirebaseStorage.instance
            .ref('propiedades/images/${file.name.toString()}')
            .putFile(File(filePath));
      }

      // Upload the image and get download URL
      final snapshot = await uploadTask.whenComplete(() => null);
      final downloadUrl = await snapshot.ref.getDownloadURL();
      // Save download URL to Firestore
      print('full path:' + snapshot.ref.fullPath.toString());
      await saveImageUrlToFirestore(downloadUrl);

      // Hide loader
      hideLoadingDialog(); // Replace with your loader hiding function

      // Return updated ImageFile with download URL
      return ImageFile(
        UniqueKey().toString(),
        name: file.name,
        extension: varTourSelect!,
        // Replace with downloadUrl obtained from Firebase Storage
        bytes: null, // Remove bytes as download URL is available
        path: downloadUrl,
      );
    }));

    return uploadedImages;
  }

  return [];
}

Future<void> saveImageUrlToFirestore(String imageUrl) async {
  try {
    final now = Timestamp.fromDate(DateTime.now());
    // Map<String, Object> virtualData = {
    //   'aFechaCreacion': now,
    //   'nameTour': 'Casa0001',
    //   'rutaStorage': 'ruta-carpeta-storage-paraborrarposteriormente',
    // };

    Map<String, Object> toursData = {
      'aFechaCreacion': now,
      'isPrincipal': false,
      'idNivel': varNivelSelect,
      'imageUploaded': imageUrl,
    };
    FirebaseFirestore db = FirebaseFirestore.instance;

    // Add the imageUrl to a new document and get the reference
    DocumentReference docRef = await db
        .collection("virtualTours")
        .doc(varidVirtualTour) // Replace with dynamic ID if needed
        .collection('tours')
        .add(toursData);

    varTourSelect = docRef.id;

    arrayTemp.add(docRef.id);

    //QUE MARQUE EL USAURIO COMO PRINCIPAL AQUI JALA EL ULTIMO SUBIDO
    print('Documents id: ${arrayTemp}');
  } catch (error) {
    print('Error saving image URL to Firestore: $error');
    // Handle error here
  }
}

// Replace these functions with your actual loader implementation
void showLoadingDialog() {
  print('loading...');
  _isPickingImages = true;
  // Show your loader here (e.g., using a progress bar or dialog)
}

void hideLoadingDialog() {
  print(' no loading');
  _isPickingImages = false;
  // Hide your loader here
}
