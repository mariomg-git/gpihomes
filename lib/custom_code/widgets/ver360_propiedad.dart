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

String varidVirtualTour =
    FFAppState().globalVar2; //PARAMETRIZAR pasar con FFappstate
String idTour = '';
String idTourInit =
    FFAppState().globalVar1; //PARAMETRIZAR para cargar el tour principal

String imageTour = '';
bool _isLoading = true;

class Ver360Propiedad extends StatefulWidget {
  const Ver360Propiedad({
    super.key,
    this.width,
    this.height,
    this.paramReference,
  });

  final double? width;
  final double? height;
  final String? paramReference;

  @override
  State<Ver360Propiedad> createState() => _Ver360PropiedadState();
}

class _Ver360PropiedadState extends State<Ver360Propiedad> {
  int _currentIndex = 0;

  double _lon = 0;
  double _lat = 0;
  double _tilt = 0;

  var hotspotsArray = [
    Hotspot(),
  ];

  void addHotspot(double lat, double lon, String zLink) {
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
              icon: Icons.gps_not_fixed,

              //text: "Borrar",
              onPressed: () {
                // selectPanorama(lat, lon);
                loadPanoramaImage(zLink);
                print(
                    'Info mod ${lat.toStringAsFixed(3)}, ${lon.toStringAsFixed(3)}');
              },
            ),
          ],
        ),
      ));
    });
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
    'panorama1.jpg',
  ];

  final _multiImagePickerModalController = GlobalKey<ScaffoldState>();
  final _firebasePanoController = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    print('idinit: ' + idTourInit);
    if (idTourInit == '') {
      print('malo');
      // Muestra el mensaje después de que initState haya completado
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showImageSelectionMessage(context);
      });
    } else {
      // Si idTourInit no está vacío, continúa con la inicialización normal
      getVirtualTourData(idTourInit);

      // Example: Fetch data asynchronously and update state
      Future<void>.delayed(const Duration(seconds: 2), () {
        images.clear();
        images.add(imageTour);

        setState(() {
          _currentIndex = 0; // Update state after a delay
          _isLoading = false;
        });
      });
    }
  }

  void _showImageSelectionMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Mensaje informativo'),
          content: Text('Debes seleccionar una imagen de inicio.'),
          actions: <Widget>[
            TextButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<List<Map<String, dynamic>>> getVirtualTourData(
      String idDocTour) async {
    try {
      // Access Firestore instance
      final firestore = FirebaseFirestore.instance;

      // Reference to the specific document containing the data
      final docRef = firestore
          .collection('virtualTours')
          .doc(varidVirtualTour)
          .collection('tours')
          .doc(idDocTour);

      // Get the document snapshot
      final docSnapshot = await docRef.get();

      // Check if document exists to avoid potential errors
      if (docSnapshot.exists) {
        // Extract the data map
        final data = docSnapshot.data() as Map<String, dynamic>;

        imageTour = data['imageUploaded'] as String;

        // Extract the 'hotspots' array (assuming it's an array)
        final hotspots = data['hotspots'] as List<dynamic>;

        // Convert each hotspot to a map for clarity (optional)

        final processedHotspots = hotspots.map((hotspot) {
          idTour = hotspot['idTour'] as String;
          addHotspot(hotspot['lat'], hotspot['lon'], hotspot['zLink']);
          return hotspot as Map<String, dynamic>;
        }).toList();
        return processedHotspots; // Return the processed array
      } else {
        print('Document not found in Firestore');
        return []; // Return empty array if document doesn't exist
      }
    } catch (error) {
      print('Error retrieving data from Firestore: $error');
      return []; // Return empty array on error
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget panorama;
    panorama = AnimatedOpacity(
      opacity: _isLoading ? 0.5 : 1.0, // Ocultar si no hay imagen seleccionada
      duration: Duration(milliseconds: 500), // Duración de la animación
      child: Panorama(
        animSpeed: 0.0,
        maxZoom: 1.0,
        minZoom: 1.0,

        //sensorControl: SensorControl.Orientation,
        onViewChanged: onViewChanged,
        //onTap: (longitude, latitude, tilt) => addHotspot(latitude, longitude),
        child: Image.network(images[_currentIndex]),
        hotspots: hotspotsArray,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // idTourInit = '';
            //AQUIIIIIIIIII  PARA que solo se agregen y no editen tours, solo se pueden agregar niveles y nuevos tours pero no editar, para editar, mejor eliminar nivel y volve a crear
            // images.clear();
            // imageTour = '';
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(children: [
        Column(
          children: [
            Expanded(
              // Make panorama take up 50% of the height
              flex: 1,
              child: panorama,
            ),
          ],
        ),
        // Container(height: 80, color: Colors.black),
        if (_isLoading)
          Container(
            // color: Colors.black.withOpacity(0.5), // Fondo oscuro semitransparente
            child: Center(
              child: CircularProgressIndicator(), // Indicador de progreso
            ),
          ),
      ]),
    );
  }

  Future<void> loadPanoramaImage(String? imageName) async {
    // Muestra el loader
    setState(() {
      _isLoading = true;
    });

    images.clear();
    hotspotsArray.clear();
    images.add(imageName!);
    await getVirtualTourData(idTour);

    // Encuentra el índice de la imagen seleccionada en la lista de imágenes
    int selectedIndex = images.indexOf(imageName);
    if (selectedIndex != -1) {
      setState(() {
        _currentIndex = selectedIndex;
        Future<void>.delayed(const Duration(seconds: 1), () {
          setState(() {
            _isLoading =
                false; // Oculta el loader una vez que se ha cargado la imagen
          });
        });
      });
    }
  }

  //end state
}
