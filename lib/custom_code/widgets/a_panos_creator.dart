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
import 'package:image_picker/image_picker.dart';

String varImageSelect = '';
String varIdVirtualTour = '';
final ImagePicker _picker = ImagePicker();

var arrayTemp = [];

class APanosCreator extends StatefulWidget {
  const APanosCreator({
    super.key,
    this.width,
    this.height,
    required this.actionParam360wdget,
    this.idVirtualTour,
  });

  final double? width;
  final double? height;
  final Future Function() actionParam360wdget;
  final String? idVirtualTour;

  @override
  State<APanosCreator> createState() => _APanosCreatorState();
}

class _APanosCreatorState extends State<APanosCreator> {
  int _currentIndex = 0;
  String idPrincipal = '';
  bool varOcultar = false;
  bool seHizoPrincipal = false;

  final _panoramaModalController = GlobalKey<ScaffoldState>();

  final controller = MultiImagePickerController(
    maxImages: 42,
    picker: (bool allowMultiple) async {
      if (kIsWeb) {
        return await pickImagesUsingFilePicker(allowMultiple);
      }
      return await pickImagesUsingImagePicker(allowMultiple);
    },
  );

  double _lon = 0;
  double _lat = 0;
  double _tilt = 0;

  var hotspotsArray = [
    Hotspot(),
  ];

  @override
  void initState() {
    super.initState();
    varIdVirtualTour = widget.idVirtualTour!;
  }

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
                icon: Icon(
                  Icons.delete_outline_rounded,
                  color: Colors.white, // Cambia el color del ícono a blanco
                ),
                iconSize: 20.0,
                onPressed: () async {
                  final shouldDelete =
                      await showDeleteConfirmationDialog(context);
                  if (shouldDelete) {
                    setState(() {
                      hotspotsArray.removeWhere((element) =>
                          element.latitude == lat && element.longitude == lon);
                    });
                    await deleteHotspotFromFirestore(lat, lon);
                  }
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
          .doc(widget.idVirtualTour)
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

  Future<bool> showDeleteConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Confirmar eliminación'),
              content:
                  Text('¿Estás seguro de que quieres eliminar este hotspot?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text('Eliminar'),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  Future<void> deleteHotspotFromFirestore(double lat, double lon) async {
    try {
      // Access Firestore instance
      final firestore = FirebaseFirestore.instance;

      // Reference to the specific document containing the data
      final docRef = firestore
          .collection('virtualTours')
          .doc(widget.idVirtualTour)
          .collection('tours')
          .doc(varImageSelect);

      // Get the document snapshot
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        // Extract the data map
        final data = docSnapshot.data() as Map<String, dynamic>;
        // Extract the 'hotspots' array
        final hotspots = data['hotspots'] as List<dynamic>;
        // Find the index of the hotspot to be deleted
        final index = hotspots.indexWhere(
            (hotspot) => hotspot['lat'] == lat && hotspot['lon'] == lon);

        if (index != -1) {
          // Remove the hotspot from the array
          hotspots.removeAt(index);

          // Update the document with the new hotspots array
          await docRef.update({'hotspots': hotspots});
        }
      } else {
        print('Document not found in Firestore');
      }
    } catch (error) {
      print('Error deleting hotspot: $error');
    }
  }

  Future<void> deleteImageFromFirestore(String imageId) async {
    try {
      // Access Firestore instance
      final firestore = FirebaseFirestore.instance;

      // Reference to the specific document
      final docRef = firestore
          .collection('virtualTours')
          .doc(widget.idVirtualTour)
          .collection('tours')
          .doc(imageId);

      // Delete the document
      await docRef.delete();
      await deleteHotspotsForImage(
          imageId); // Eliminate hotspots after deleting the image
      print('Document deleted from Firestore');
    } catch (error) {
      print('Error deleting document from Firestore: $error');
    }
  }

  Future<void> deleteHotspotsForImage(String imageId) async {
    try {
      final firestore = FirebaseFirestore.instance;

      // Get all documents in the 'tours' subcollection
      final querySnapshot = await firestore
          .collection('virtualTours')
          .doc(widget.idVirtualTour)
          .collection('tours')
          .get();

      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        if (data.containsKey('hotspots')) {
          final hotspots = List.from(data['hotspots']);
          hotspots.removeWhere((hotspot) => hotspot['idTour'] == imageId);
          await doc.reference.update({'hotspots': hotspots});
        }
      }
    } catch (e) {
      print('Error deleting hotspots: $e');
    }
  }

  Future<void> removeImageWithConfirmation(
      BuildContext context, dynamic imageFile) async {
    final shouldDelete = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Confirmar eliminación'),
              content:
                  Text('¿Estás seguro de que quieres eliminar esta imagen?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text('Eliminar'),
                ),
              ],
            );
          },
        ) ??
        false;

    if (shouldDelete) {
      //await deleteImageFromFirestore(imageFile.id);
      await deleteImageFromFirestore(imageFile);
      // if (imageFile is AssetEntity) {
      //   await deleteImageFromFirestore(imageFile.id);
      // } else if (imageFile is XFile) {
      //   await deleteImageFromFirestore(imageFile.name);
      // }
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
        title: const Text('360 Creator'),
        backgroundColor: Colors.black,
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.black, // Cambia el color de fondo a negro
                    ),
                    child: const Column(
                      children: [
                        Text('VISTA 360'),
                        Icon(Icons.preview),
                      ],
                    ),
                  ),
                ),

                //Text('Vista Previa'),
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
                final filename = imageFile.name ??
                    'Unknown'; // Extract filename and extension

                return Stack(
                  children: [
                    Positioned.fill(
                      child: InkWell(
                        onTap: () {
                          if (seHizoPrincipal) {
                            print(
                                'borrar hotspots: ' + hotspotsArray.toString());
                            setState(() {
                              hotspotsArray.clear();
                            });
                            getHotspotsFire(imageFile.extension);
                            setState(() {});
                            print('.extension usado para enviar id:' +
                                imageFile
                                    .extension); //AQUI APROBECHE EL CAMPO .extension, PARA GUARDAR EL ID
                            varImageSelect = imageFile.extension;
                            loadPanoramaImage(imageFile
                                .path!); // Imprimir el nombre de la imagen con extensión
                          } else {
                            showBasicDialog(context);
                          }
                        },

                        child: Image.network(imageFile
                            .path!), //ImageFileView(imageFile: imageFile),
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
                              color: Colors.black.withOpacity(0.8),
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
                          borderRadius: BorderRadius.circular(
                              8), // Cambia el radio para redondear más las esquinas
                          onPressed: () {
                            _setPrincipal(imageFile.extension);
                            seHizoPrincipal = true;
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(
                                  8), // Asegura que las esquinas del contenedor también sean redondeadas
                            ),
                            child: Text(
                              'Inicio',
                              style: TextStyle(
                                color: Colors
                                    .white, // Cambia el color del texto a blanco
                              ),
                            ),
                          ),
                        ),
                      ),

                    if (idPrincipal != imageFile.extension)
                      Positioned(
                        top: 4,
                        right: 4,
                        child: DraggableItemInkWell(
                          borderRadius: BorderRadius.circular(2),
                          onPressed: () {
                            removeImageWithConfirmation(
                                context, imageFile.extension);
                            controller.removeImage(imageFile);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
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
                    // Positioned(
                    //   bottom: 2,
                    //   left: 5,
                    //   child: Text(
                    //     filename,
                    //     style: const TextStyle(
                    //       fontSize: 12,
                    //       color: Colors.white,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),
                  ],
                );
              },
              initialWidget: SizedBox(
                height: 170,
                width: double.infinity,
                child: Center(
                  child: Stack(
                    children: [
                      // Position buttons at the bottom using Align
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          // Arrange buttons vertically
                          mainAxisSize:
                              MainAxisSize.min, // Minimize space occupied
                          children: [
                            const SizedBox(
                                height: 8), // Add spacing between buttons

                            const SizedBox(
                                height: 50), // Add spacing between buttons
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors
                                    .black, // Cambia el color de fondo a negro
                              ),
                              onPressed: () {
                                controller.pickImages();
                              },
                              child: const Column(
                                mainAxisSize: MainAxisSize
                                    .min, // Para ajustar el tamaño del botón al contenido
                                children: [
                                  Text('INICIA AQUI'),
                                  Text('Agregando Imagenes'),
                                  Icon(Icons.satellite_sharp),
                                ],
                              ),
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

  void showBasicDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Información'),
          content: Text(
              'Debes Seleccionar una Imagen de Inicio, dando clic en el boton de Inicio.'),
          actions: <Widget>[
            TextButton(
              child: Text('ACEPTAR'),
              onPressed: () {
                // Realiza alguna acción aquí
                Navigator.of(context).pop(); // Cierra el diálogo
              },
            ),
          ],
        );
      },
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
          .doc(widget.idVirtualTour)
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
          title: const Text('Seleccionar Imagen destino'),
          backgroundColor: Colors.black,
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
            print('pathFile: ' + imageFile.path.toString());
            final filename =
                imageFile.name ?? 'Unknown'; // Extract filename and extension
            return Stack(
              children: [
                Positioned.fill(
                  child: InkWell(
                    onTap: () async {
                      print('id-documento: ' + imageFile.extension);
                      // Mostrar diálogo de confirmación
                      bool confirm = await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Confirm Save'),
                          content: Text('Deseas guardar estos cambios?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(false); // No
                              },
                              child: Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(true); // Yes
                              },
                              child: Text('Guardar'),
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
                              .doc(widget.idVirtualTour)
                              .collection('tours')
                              .doc(varImageSelect)
                              .update(data);

                          print('Documento guardado en Firestore');
                        } catch (error) {
                          print(
                              'Error al guardar el documento en Firestore: $error');
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Valor Guardado'),
                          ),
                        );

                        bool confirm = await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Guardado Correctamente'),
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
                    child: Image.network(
                        imageFile.path!), //ImageFileView(imageFile: imageFile),
                  ),
                ),
                // Positioned(
                //   top: 4,
                //   right: 4,
                //   child: DraggableItemInkWell(
                //     borderRadius: BorderRadius.circular(2),
                //     onPressed: () => controller.removeImage(imageFile),
                //     child: Container(
                //       padding: const EdgeInsets.all(5),
                //       decoration: BoxDecoration(
                //         color: Theme.of(context)
                //             .colorScheme
                //             .secondary
                //             .withOpacity(0.4),
                //         shape: BoxShape.circle,
                //       ),
                //       child: Icon(
                //         Icons.delete_forever_rounded,
                //         size: 18,
                //         color: Theme.of(context).colorScheme.background,
                //       ),
                //     ),
                //   ),
                // ),
                // Positioned(
                //   bottom: 2,
                //   left: 5,
                //   child: Text(
                //     filename,
                //     style: const TextStyle(
                //       fontSize: 10,
                //       color: Colors.white,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),
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

  void firebasePanorama() {
    widget.actionParam360wdget!();
  }

  //end state
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
      'idVirtualTour': varIdVirtualTour,
      'imageUploaded': imageUrl,
    };
    FirebaseFirestore db = FirebaseFirestore.instance;

    // Add the imageUrl to a new document and get the reference
    DocumentReference docRef = await db
        .collection("virtualTours")
        .doc(varIdVirtualTour) // Replace with dynamic ID if needed
        .collection('tours')
        .add(toursData);

    varImageSelect = docRef.id;

    arrayTemp.add(docRef.id);

    //QUE MARQUE EL USAURIO COMO PRINCIPAL AQUI JALA EL ULTIMO SUBIDO
    print('Documents id: ${arrayTemp}');
  } catch (error) {
    print('Error saving image URL to Firestore: $error');
    // Handle error here
  }
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

      // Return updated ImageFile with download URL
      return ImageFile(
        UniqueKey().toString(),
        name: file.name,
        extension: varImageSelect!,
        // Replace with downloadUrl obtained from Firebase Storage
        bytes: null, // Remove bytes as download URL is available
        path: downloadUrl,
      );
    }));

    return uploadedImages;
  }

  return [];
}

Future<List<ImageFile>> pickImagesUsingImagePicker(bool allowMultiple) async {
  List<XFile>? pickedFiles;

  if (allowMultiple) {
    pickedFiles = await _picker.pickMultiImage();
  } else {
    final XFile? singleFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (singleFile != null) {
      pickedFiles = [singleFile];
    }
  }

  if (pickedFiles != null && pickedFiles.isNotEmpty) {
    final uploadedImages = await Future.wait(pickedFiles.map((file) async {
      UploadTask uploadTask;
      if (kIsWeb) {
        final bytes = await file.readAsBytes();
        uploadTask = FirebaseStorage.instance
            .ref('propiedades/images/${file.name}')
            .putData(bytes);
      } else {
        uploadTask = FirebaseStorage.instance
            .ref('propiedades/images/${file.name}')
            .putFile(File(file.path));
      }

      final snapshot = await uploadTask.whenComplete(() => null);
      final downloadUrl = await snapshot.ref.getDownloadURL();
      await saveImageUrlToFirestore(downloadUrl);

      return ImageFile(
        UniqueKey().toString(),
        name: file.name,
        extension: varImageSelect!,
        bytes: null,
        path: downloadUrl,
      );
    }));

    return uploadedImages;
  }

  return [];
}
