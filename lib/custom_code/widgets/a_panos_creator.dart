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

import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:panorama/panorama.dart';
import "dart:math";
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

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
  
  // Variable estática para acceder desde funciones globales
  static _APanosCreatorState? _uploadState;
  
  // Variables para tracking de uploads
  bool _isUploading = false;
  int _uploadingCount = 0;
  int _totalToUpload = 0;
  double _uploadProgress = 0.0;
  Map<String, double> _imageUploadProgress = {};
  Map<String, String> _uploadErrors = {};
  int _currentStep = 0; // 0: Agregar imágenes, 1: Marcar inicio, 2: Crear hotspots, 3: Listo
  int _totalImages = 0;
  int _totalHotspots = 0;

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
    _uploadState = this; // Asignar referencia al estado
    _updateImageCount();
    
    // Mostrar diálogo de bienvenida
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showWelcomeDialog();
    });
  }
  
  @override
  void dispose() {
    _uploadState = null; // Limpiar referencia
    super.dispose();
  }
  
  void _updateImageCount() {
    setState(() {
      _totalImages = controller.images.length;
      _totalHotspots = hotspotsArray.where((h) => h.latitude != null).length;
      
      // Actualizar paso actual según progreso
      if (_totalImages == 0) {
        _currentStep = 0;
      } else if (!seHizoPrincipal) {
        _currentStep = 1;
      } else if (_totalHotspots == 0) {
        _currentStep = 2;
      } else {
        _currentStep = 3;
      }
    });
  }
  
  void _showSnackBar(String message, {Color? backgroundColor, IconData? icon}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: Colors.white, size: 20),
              SizedBox(width: 8),
            ],
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: backgroundColor ?? Colors.blue,
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      ),
    );
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
                    _updateImageCount();
                  }
                },
              ),
            ),
          ],
        ),
      ));
      _updateImageCount();
    });
    
    _showSnackBar(
      'Hotspot agregado. Selecciona la imagen destino',
      backgroundColor: Colors.blue,
      icon: Icons.add_location_alt,
    );
  }

  Future<List<Map<String, dynamic>>> getHotspotsFire(String idTourSpots) async {
    try {
      // Limpiar hotspots actuales antes de cargar nuevos
      setState(() {
        hotspotsArray.clear();
      });
      
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
        
        // Verificar si tiene hotspots
        if (!data.containsKey('hotspots')) {
          print('Documento encontrado pero sin hotspots');
          return [];
        }
        
        // Extract the 'hotspots' array
        final hotspots = data['hotspots'] as List<dynamic>;
        
        // Convert each hotspot to a map and add to UI
        final processedHotspots = hotspots.map((hotspot) {
          addHotspot(hotspot['lat'], hotspot['lon']);
          return hotspot as Map<String, dynamic>;
        }).toList();
        
        print('${hotspots.length} hotspots cargados exitosamente');
        return processedHotspots;
      } else {
        print('Document not found in Firestore');
        return [];
      }
    } catch (error) {
      print('Error cargando hotspots: $error');
      _showSnackBar(
        'Error al cargar hotspots: ${error.toString()}',
        backgroundColor: Colors.red,
        icon: Icons.error,
      );
      return [];
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
      // Verificar si es la imagen principal antes de eliminar
      final wasMainImage = (imageId == idPrincipal);
      
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
      
      // Si era la imagen principal, resetear estado
      if (wasMainImage) {
        setState(() {
          idPrincipal = '';
          seHizoPrincipal = false;
          varOcultar = false;
        });
        _showSnackBar(
          '⚠️ Imagen de inicio eliminada. Marca otra como inicio.',
          backgroundColor: Colors.orange[700]!,
          icon: Icons.warning,
        );
      }
      
      _updateImageCount();
      print('Document deleted from Firestore: $imageId');
    } catch (error) {
      print('Error deleting document from Firestore: $error');
      _showSnackBar(
        'Error al eliminar imagen: ${error.toString()}',
        backgroundColor: Colors.red,
        icon: Icons.error,
      );
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
      await deleteImageFromFirestore(imageFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget panorama;
    panorama = Panorama(
      animSpeed: 0.0,
      //sensorControl: SensorControl.Orientation,
      onViewChanged: onViewChanged,
      onTap: (longitude, latitude, tilt) {
        if (!seHizoPrincipal) {
          _showSnackBar(
            '⚠️ Primero marca una imagen de inicio',
            backgroundColor: Colors.orange[700]!,
            icon: Icons.warning,
          );
          return;
        }
        addHotspot(latitude, longitude);
      },
      child: Image.network(images[_currentIndex]),
      hotspots: hotspotsArray,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('360 Creator'),
        backgroundColor: Colors.black,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(120),
          child: Column(
            children: [
              // Stepper visual
              _buildStepperIndicator(),
              SizedBox(height: 8),
              // Panel de estado
              _buildStatusPanel(),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          // Loader general si está subiendo
          if (_isUploading) _buildUploadProgress(),
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

                return Listener(
                  onPointerDown: (event) {
                    print('========================================');
                    print('🔥 CLIC EN IMAGEN DETECTADO (Listener)');
                    print('Nombre: ${imageFile.name}');
                    print('Extension (ID): ${imageFile.extension}');
                    print('Path: ${imageFile.path}');
                    print('seHizoPrincipal: $seHizoPrincipal');
                    print('Posición del clic: ${event.localPosition}');
                    print('========================================');
                    
                    if (seHizoPrincipal) {
                      print('✅ Ya hay imagen de inicio, cargando imagen seleccionada...');
                      print('ID de imagen: ${imageFile.extension}');
                      print('URL: ${imageFile.path}');
                      
                      print('🔄 Iniciando setState...');
                      // Actualizar todo el estado de una vez
                      setState(() {
                        print('  - Limpiando ${hotspotsArray.length} hotspots...');
                        // Limpiar hotspots actuales
                        hotspotsArray.clear();
                        
                        print('  - Actualizando varImageSelect a: ${imageFile.extension}');
                        // Actualizar la imagen seleccionada
                        varImageSelect = imageFile.extension;
                        
                        print('  - Llamando a loadPanoramaImage con: ${imageFile.path}');
                        // Cargar la nueva imagen en el visor
                        loadPanoramaImage(imageFile.path!);
                      });
                      print('✅ setState completado');
                      
                      print('🔄 Obteniendo hotspots de Firebase...');
                      // Obtener hotspots de Firebase (asíncrono)
                      getHotspotsFire(imageFile.extension);
                      print('✅ Petición de hotspots enviada');
                    } else {
                      print('⚠️ No hay imagen de inicio, mostrando diálogo...');
                      showBasicDialog(context);
                      print('✅ Diálogo mostrado');
                    }
                    
                    print('========================================');
                  },
                  child: Stack(
                    children: [
                      // Imagen de fondo
                      Positioned.fill(
                        child: Image.network(
                          imageFile.path!,
                          fit: BoxFit.cover,
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
                  ],
                ),
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

                            const SizedBox(height: 20),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 20),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue[700],
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 4,
                                ),
                                onPressed: () {
                                  controller.pickImages();
                                },
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add_photo_alternate, size: 28),
                                    SizedBox(width: 12),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'AGREGAR IMAGENES',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'Selecciona tus panoramas 360°',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
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
          icon: Icon(Icons.warning_amber, color: Colors.orange, size: 48),
          title: Text('⚠️ Imagen de Inicio Requerida'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Antes de continuar, debes seleccionar una imagen de inicio para tu recorrido virtual.',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue[200]!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info, color: Colors.blue, size: 20),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Toca el botón "Inicio" en la imagen que deseas usar como punto de partida',
                        style: TextStyle(fontSize: 12, color: Colors.blue[900]),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('ENTENDIDO'),
              onPressed: () {
                Navigator.of(context).pop();
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
        seHizoPrincipal = true;
      });
      
      _updateImageCount();

      FFAppState().globalVar1 = setPrincipal;

      _showSnackBar(
        '✓ Imagen de inicio configurada correctamente',
        backgroundColor: Colors.green[700]!,
        icon: Icons.check_circle,
      );

      print('Documento guardado en Firestore');
      
      // Diálogo de confirmación mejorado
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          icon: Icon(Icons.star, color: Colors.amber, size: 48),
          title: Text('🎯 ¡Imagen de Inicio Configurada!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Esta será la primera imagen que verán los visitantes al iniciar el recorrido virtual.',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green[200]!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.arrow_forward, color: Colors.green, size: 20),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Siguiente paso: Toca en las imágenes para crear conexiones (hotspots)',
                        style: TextStyle(fontSize: 12, color: Colors.green[900]),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('CONTINUAR'),
            ),
          ],
        ),
      );
    } catch (error) {
      print('Error al guardar el documento en Firestore: $error');
      _showSnackBar(
        '❌ Error al configurar imagen de inicio: $error',
        backgroundColor: Colors.red,
        icon: Icons.error,
      );
    }
  }

  void loadPanoramaImage(String imageName) {
    print('📸 loadPanoramaImage() INICIO');
    print('  Parámetro imageName: $imageName');
    
    setState(() {
      // Optimizado: siempre limpiar y agregar, índice siempre será 0
      if (images.isEmpty || images.first != imageName) {
        images.clear();
        images.add(imageName);
        print('  ✅ Imagen actualizada en lista');
      }
      _currentIndex = 0; // Siempre será 0
      print('  ✅ _currentIndex actualizado a: $_currentIndex');
    });
    
    print('📸 loadPanoramaImage() FIN');
  }

  void selectPanorama(double lat, double lon) async {
    // Marcar que estamos esperando selección
    bool hotspotSaved = false;
    
    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
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
            return Listener(
              onPointerDown: (event) async {
                print('🎯 CLIC EN IMAGEN DESTINO DETECTADO');
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
                            Navigator.of(context).pop(true);
                          },
                          child: Text('Ok'),
                        ),
                      ],
                    ),
                  );
                  // Cierra el modal y retorna true para indicar que se guardó
                  Navigator.of(context).pop(true);
                }
              },
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                        imageFile.path!),
                  ),
              ],
            ),
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
    
    // Si el usuario canceló (cerró el modal sin guardar), eliminar el hotspot huérfano
    if (result != true) {
      setState(() {
        hotspotsArray.removeWhere((h) => 
          h.latitude == lat && h.longitude == lon
        );
      });
      _showSnackBar(
        'Selección de destino cancelada',
        backgroundColor: Colors.grey[700]!,
        icon: Icons.info,
      );
    }
  }

  void firebasePanorama() {
    widget.actionParam360wdget!();
  }
  
  void _showWelcomeDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: Icon(Icons.panorama_photosphere, color: Colors.blue, size: 56),
          title: Text('🎬 Creador de Tours 360°'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sigue estos pasos para crear tu recorrido virtual:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                _buildStep('1', 'Sube tus imágenes panorámicas 360°', Icons.add_photo_alternate, Colors.blue),
                SizedBox(height: 12),
                _buildStep('2', 'Marca la imagen de inicio del recorrido', Icons.start, Colors.orange),
                SizedBox(height: 12),
                _buildStep('3', 'Crea hotspots tocando en la panorámica', Icons.add_location_alt, Colors.green),
                SizedBox(height: 12),
                _buildStep('4', 'Vista previa y publica tu tour', Icons.check_circle, Colors.purple),
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.amber[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.amber[200]!),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.tips_and_updates, color: Colors.amber[700], size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Tip: Las imágenes deben ser panoramas de 360° para mejor experiencia',
                          style: TextStyle(fontSize: 11, color: Colors.amber[900]),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('¡EMPECEMOS!', style: TextStyle(fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  
  Widget _buildStep(String number, String text, IconData icon, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, size: 16, color: color),
                  SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      text,
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  // Widget para el stepper visual
  Widget _buildStepperIndicator() {
    final steps = [
      {'icon': Icons.add_photo_alternate, 'label': 'Imágenes'},
      {'icon': Icons.start, 'label': 'Inicio'},
      {'icon': Icons.add_location_alt, 'label': 'Hotspots'},
      {'icon': Icons.check_circle, 'label': 'Listo'},
    ];
    
    return Container(
      color: Colors.black87,
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(steps.length, (index) {
          final isActive = index == _currentStep;
          final isCompleted = index < _currentStep;
          
          return Expanded(
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isCompleted ? Colors.green : (isActive ? Colors.blue : Colors.grey[700]),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isCompleted ? Icons.check : steps[index]['icon'] as IconData,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  steps[index]['label'] as String,
                  style: TextStyle(
                    color: isActive ? Colors.blue : (isCompleted ? Colors.green : Colors.grey),
                    fontSize: 11,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
  
  // Widget para el panel de estado
  Widget _buildStatusPanel() {
    return Container(
      color: Colors.black54,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatusItem(
            Icons.photo_library,
            '$_totalImages panoramas',
            _totalImages > 0 ? Colors.green : Colors.grey,
          ),
          _buildStatusItem(
            seHizoPrincipal ? Icons.check_circle : Icons.warning,
            seHizoPrincipal ? 'Inicio OK' : 'Sin inicio',
            seHizoPrincipal ? Colors.green : Colors.orange,
          ),
          _buildStatusItem(
            Icons.pin_drop,
            '$_totalHotspots conexiones',
            _totalHotspots > 0 ? Colors.blue : Colors.grey,
          ),
        ],
      ),
    );
  }
  
  Widget _buildStatusItem(IconData icon, String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 16),
        SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
  
  // Widget para mostrar progreso de upload
  Widget _buildUploadProgress() {
    return Container(
      color: Colors.blue[900],
      padding: EdgeInsets.all(12),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              value: _totalToUpload > 0 ? _uploadProgress / _totalToUpload : null,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Subiendo imagenes panoramicas...',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  '$_uploadingCount de $_totalToUpload completadas',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            '${(_uploadProgress / _totalToUpload * 100).toStringAsFixed(0)}%',
            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  //end state
}

Future<String> saveImageUrlToFirestore(String imageUrl) async {
  try {
    final now = Timestamp.fromDate(DateTime.now());

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
        .doc(varIdVirtualTour)
        .collection('tours')
        .add(toursData);

    final documentId = docRef.id;
    arrayTemp.add(documentId);

    print('Document created with ID: $documentId');
    return documentId;
  } catch (error) {
    print('Error saving image URL to Firestore: $error');
    throw error; // Re-throw para que el llamador pueda manejarlo
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
    
    // Inicializar tracking de uploads
    final uploadingState = _APanosCreatorState._uploadState;
    if (uploadingState != null) {
      uploadingState._isUploading = true;
      uploadingState._totalToUpload = selectedFiles.length;
      uploadingState._uploadingCount = 0;
      uploadingState._uploadProgress = 0;
      uploadingState._uploadErrors.clear();
    }

    final uploadedImages = <ImageFile>[];
    
    // Verificar autenticación antes de subir
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      print('ERROR: Usuario no autenticado para subir imágenes');
      if (uploadingState != null) {
        uploadingState._isUploading = false;
        uploadingState._showSnackBar(
          'Debes iniciar sesión para subir imágenes',
          backgroundColor: Colors.red,
          icon: Icons.error,
        );
      }
      return uploadedImages;
    }
    
    print('Usuario autenticado: ${currentUser.uid}');
    
    for (var i = 0; i < selectedFiles.length; i++) {
      final file = selectedFiles[i];
      final fileName = file.name.toString();
      
      try {
        // Validar tamaño de archivo (máximo 10MB)
        if (file.size > 10 * 1024 * 1024) {
          if (uploadingState != null) {
            uploadingState._uploadErrors[fileName] = 'Archivo muy grande (máx 10MB)';
            uploadingState._showSnackBar(
              'Archivo muy grande: $fileName (máximo 10MB)',
              backgroundColor: Colors.red,
              icon: Icons.error,
            );
          }
          continue;
        }
        
        print('Subiendo archivo: $fileName (${file.size} bytes)');
        
        // Preparar upload task
        UploadTask uploadTask;
        if (kIsWeb) {
          final bytes = file.bytes != null ? file.bytes! : Uint8List(0);
          uploadTask = FirebaseStorage.instance
              .ref('propiedades/images/$fileName')
              .putData(bytes);
        } else {
          final filePath = file.path!;
          uploadTask = FirebaseStorage.instance
              .ref('propiedades/images/$fileName')
              .putFile(File(filePath));
        }
        
        // Escuchar progreso de subida
        uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
          if (uploadingState != null) {
            final progress = snapshot.bytesTransferred / snapshot.totalBytes;
            uploadingState._imageUploadProgress[fileName] = progress;
          }
        });

        // Upload the image and get download URL
        final snapshot = await uploadTask.whenComplete(() => null);
        final downloadUrl = await snapshot.ref.getDownloadURL();
        
        // Save download URL to Firestore and get the document ID
        final documentId = await saveImageUrlToFirestore(downloadUrl);
        
        // Actualizar progreso
        if (uploadingState != null) {
          uploadingState._uploadingCount++;
          uploadingState._uploadProgress++;
          uploadingState._showSnackBar(
            'Panorama ${i + 1}/${selectedFiles.length} subido correctamente',
            backgroundColor: Colors.green,
            icon: Icons.check_circle,
          );
        }

        // Return updated ImageFile with download URL and document ID
        uploadedImages.add(ImageFile(
          UniqueKey().toString(),
          name: file.name,
          extension: documentId, // ✅ Usar el ID único del documento
          bytes: null,
          path: downloadUrl,
        ));
        
      } catch (error) {
        print('Error uploading $fileName: $error');
        if (uploadingState != null) {
          String errorMsg = 'Error al subir imagen';
          if (error.toString().contains('network')) {
            errorMsg = 'Error de red: Revisa tu conexión';
          } else if (error.toString().contains('permission')) {
            errorMsg = 'Error de permisos: Verifica autenticación';
          } else if (error.toString().contains('storage')) {
            errorMsg = 'Error de almacenamiento';
          }
          
          uploadingState._uploadErrors[fileName] = errorMsg;
          uploadingState._showSnackBar(
            '$fileName: $errorMsg',
            backgroundColor: Colors.red,
            icon: Icons.error,
          );
        }
      }
    }
    
    // Finalizar upload
    if (uploadingState != null) {
      uploadingState._isUploading = false;
      uploadingState._updateImageCount();
      
      if (uploadedImages.isNotEmpty) {
        uploadingState._showSnackBar(
          '${uploadedImages.length} panoramas subidos exitosamente',
          backgroundColor: Colors.green[700]!,
          icon: Icons.celebration,
        );
      }
    }

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

  final uploadedImages = <ImageFile>[];

  if (pickedFiles != null && pickedFiles.isNotEmpty) {
    // Verificar autenticación antes de subir
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      print('ERROR: Usuario no autenticado para subir imágenes');
      final uploadingState = _APanosCreatorState._uploadState;
      if (uploadingState != null) {
        uploadingState._showSnackBar(
          'Debes iniciar sesión para subir imágenes',
          backgroundColor: Colors.red,
          icon: Icons.error,
        );
      }
      return uploadedImages;
    }
    
    print('Usuario autenticado: ${currentUser.uid}');
    
    // Inicializar tracking de uploads
    final uploadingState = _APanosCreatorState._uploadState;
    if (uploadingState != null) {
      uploadingState._isUploading = true;
      uploadingState._totalToUpload = pickedFiles.length;
      uploadingState._uploadingCount = 0;
      uploadingState._uploadProgress = 0;
      uploadingState._uploadErrors.clear();
    }
    
    for (var i = 0; i < pickedFiles.length; i++) {
      final file = pickedFiles[i];
      final fileName = file.name;
      
      try {
        print('Subiendo archivo: $fileName');
        
        UploadTask uploadTask;
        if (kIsWeb) {
          final bytes = await file.readAsBytes();
          
          // Validar tamaño (máximo 10MB)
          if (bytes.length > 10 * 1024 * 1024) {
            if (uploadingState != null) {
              uploadingState._showSnackBar(
                'Archivo muy grande: $fileName (máximo 10MB)',
                backgroundColor: Colors.red,
                icon: Icons.error,
              );
            }
            continue;
          }
          
          uploadTask = FirebaseStorage.instance
              .ref('propiedades/images/$fileName')
              .putData(bytes);
        } else {
          final fileObj = File(file.path);
          final fileSize = await fileObj.length();
          
          // Validar tamaño
          if (fileSize > 10 * 1024 * 1024) {
            if (uploadingState != null) {
              uploadingState._showSnackBar(
                '❌ $fileName: Archivo muy grande (máximo 10MB)',
                backgroundColor: Colors.red,
                icon: Icons.error,
              );
            }
            continue;
          }
          
          uploadTask = FirebaseStorage.instance
              .ref('propiedades/images/$fileName')
              .putFile(fileObj);
        }
        
        // Escuchar progreso
        uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
          if (uploadingState != null) {
            final progress = snapshot.bytesTransferred / snapshot.totalBytes;
            uploadingState._imageUploadProgress[fileName] = progress;
          }
        });

        final snapshot = await uploadTask.whenComplete(() => null);
        final downloadUrl = await snapshot.ref.getDownloadURL();
        
        // Save download URL to Firestore and get the document ID
        final documentId = await saveImageUrlToFirestore(downloadUrl);
        
        // Actualizar progreso
        if (uploadingState != null) {
          uploadingState._uploadingCount++;
          uploadingState._uploadProgress++;
          uploadingState._showSnackBar(
            '✓ Panorama ${i + 1}/${pickedFiles.length} subido correctamente',
            backgroundColor: Colors.green,
            icon: Icons.check_circle,
          );
        }

        uploadedImages.add(ImageFile(
          UniqueKey().toString(),
          name: file.name,
          extension: documentId, // ✅ Usar el ID único del documento
          bytes: null,
          path: downloadUrl,
        ));
        
      } catch (error) {
        print('Error uploading $fileName: $error');
        if (uploadingState != null) {
          String errorMsg = 'Error al subir imagen';
          if (error.toString().contains('network')) {
            errorMsg = 'Error de red: Revisa tu conexión';
          } else if (error.toString().contains('permission')) {
            errorMsg = 'Error de permisos: Verifica autenticación';
          }
          
          uploadingState._showSnackBar(
            '❌ $fileName: $errorMsg',
            backgroundColor: Colors.red,
            icon: Icons.error,
          );
        }
      }
    }
    
    // Finalizar upload
    if (uploadingState != null) {
      uploadingState._isUploading = false;
      uploadingState._updateImageCount();
      
      if (uploadedImages.isNotEmpty) {
        uploadingState._showSnackBar(
          '🎉 ${uploadedImages.length} panoramas subidos exitosamente',
          backgroundColor: Colors.green[700]!,
          icon: Icons.celebration,
        );
      }
    }

    return uploadedImages;
  }

  return [];
}
