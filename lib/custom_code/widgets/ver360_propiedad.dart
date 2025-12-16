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

class _Ver360PropiedadState extends State<Ver360Propiedad> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  int _totalPanoramas = 1;
  String _currentPanoramaName = '';

  double _lon = 0;
  double _lat = 0;
  double _tilt = 0;

  // Variables movidas del scope global al state
  String _varidVirtualTour = '';
  String _idTour = '';
  String _idTourInit = '';
  String _imageTour = '';
  bool _isLoading = true;
  String? _errorMessage;
  
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  var hotspotsArray = [
    Hotspot(),
  ];

  void addHotspot(double lat, double lon, String zLink, {String name = ''}) {
    setState(() {
      hotspotsArray.add(Hotspot(
        latitude: lat,
        longitude: lon,
        width: 100.0,
        height: 100.0,
        widget: Semantics(
          label: 'Ir a panorama ${name.isNotEmpty ? name : "siguiente"}',
          button: true,
          child: AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: 1.0 + (_pulseAnimation.value * 0.1),
                child: Stack(
                  children: [
                    hotspotButton(
                      icon: Icons.gps_not_fixed,
                      name: name,
                      onPressed: () {
                        loadPanoramaImage(zLink, name);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ));
      _totalPanoramas = hotspotsArray.length;
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
      {String? text, String? name, IconData? icon, VoidCallback? onPressed}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 8.0,
                spreadRadius: 2.0,
              ),
            ],
          ),
          child: TextButton(
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(Size(80.0, 80.0)),
              shape: MaterialStateProperty.all(CircleBorder()),
              backgroundColor: MaterialStateProperty.all(Colors.blue.withOpacity(0.7)),
              foregroundColor: MaterialStateProperty.all(Colors.white),
            ),
            child: Icon(
              icon,
              size: 40.0,
            ),
            onPressed: onPressed,
          ),
        ),
        if (name != null && name.isNotEmpty)
          Container(
            margin: EdgeInsets.only(top: 8.0),
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.all(Radius.circular(16)),
              border: Border.all(color: Colors.white, width: 1.5),
            ),
            child: Text(
              name,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
              ),
            ),
          ),
        if (text != null && text.isNotEmpty)
          Container(
            padding: EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            child: Center(child: Text(text)),
          ),
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
    
    // Inicializar variables de estado
    _varidVirtualTour = FFAppState().globalVar2;
    _idTourInit = FFAppState().globalVar1;
    
    // Configurar animación pulsante para hotspots
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    
    if (_idTourInit.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showImageSelectionMessage(context);
      });
    } else {
      _loadInitialTour();
    }
  }
  
  Future<void> _loadInitialTour() async {
    try {
      await getVirtualTourData(_idTourInit);
      
      if (mounted && _imageTour.isNotEmpty) {
        setState(() {
          images.clear();
          images.add(_imageTour);
          _currentIndex = 0;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Error al cargar el tour virtual';
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al cargar el tour: $e'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 4),
          ),
        );
      }
    }
  }
  
  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
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
          .doc(_varidVirtualTour)
          .collection('tours')
          .doc(idDocTour);

      // Get the document snapshot
      final docSnapshot = await docRef.get();

      // Check if document exists to avoid potential errors
      if (docSnapshot.exists) {
        // Extract the data map
        final data = docSnapshot.data() as Map<String, dynamic>;

        _imageTour = data['imageUploaded'] as String? ?? '';
        _currentPanoramaName = data['nombre'] as String? ?? 'Panorama principal';

        // Extract the 'hotspots' array (assuming it's an array)
        final hotspots = data['hotspots'] as List<dynamic>? ?? [];

        final processedHotspots = hotspots.map((hotspot) {
          _idTour = hotspot['idTour'] as String? ?? '';
          final hotspotName = hotspot['nombre'] as String? ?? '';
          addHotspot(
            hotspot['lat'] as double,
            hotspot['lon'] as double,
            hotspot['zLink'] as String,
            name: hotspotName,
          );
          return hotspot as Map<String, dynamic>;
        }).toList();
        return processedHotspots;
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Tour virtual no encontrado'),
              backgroundColor: Colors.orange,
            ),
          );
        }
        return [];
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al cargar tour: $error'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      }
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget panorama;
    panorama = AnimatedOpacity(
      opacity: _isLoading ? 0.5 : 1.0,
      duration: const Duration(milliseconds: 500),
      child: Semantics(
        label: 'Vista panorámica 360 grados. ${_currentPanoramaName}. ${_totalPanoramas > 1 ? "Toca los puntos para navegar" : ""}',
        child: Panorama(
          animSpeed: 0.5,
          maxZoom: 3.0,
          minZoom: 0.5,
          onViewChanged: onViewChanged,
          child: Image.network(
            images[_currentIndex],
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                color: Colors.grey[900],
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[900],
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, color: Colors.red, size: 48),
                      SizedBox(height: 16),
                      Text(
                        'Error al cargar imagen',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          hotspots: hotspotsArray,
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Recorrido Virtual 360°'),
            if (_currentPanoramaName.isNotEmpty)
              Text(
                _currentPanoramaName,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
              ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Volver',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          if (_totalPanoramas > 1)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    'Panorama ${_currentIndex + 1} de $_totalPanoramas',
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ),
        ],
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

  Future<void> loadPanoramaImage(String? imageName, String name) async {
    if (imageName == null || imageName.isEmpty) return;
    
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      images.clear();
      hotspotsArray.clear();
      images.add(imageName);
      
      await getVirtualTourData(_idTour);

      int selectedIndex = images.indexOf(imageName);
      if (selectedIndex != -1 && mounted) {
        setState(() {
          _currentIndex = selectedIndex;
          _currentPanoramaName = name.isNotEmpty ? name : 'Panorama';
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Error al cambiar de panorama';
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  //end state
}
