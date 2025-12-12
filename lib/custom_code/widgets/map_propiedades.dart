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

import '/flutter_flow/custom_functions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as map;
import 'dart:async';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/services.dart' as services;
import 'package:flutter/rendering.dart';
import 'dart:typed_data';
import 'package:gpi_homes/pages/a_home_pages/property_details/property_details_widget.dart';
import 'package:gpi_homes/flutter_flow/lat_lng.dart' as ff;
import 'package:flutter/foundation.dart';

const String googleApiKey = 'AIzaSyDIxSvBsrUfqBKuIKvvG9_Fl0GE6lEJvrQ';

class MapPropiedades extends StatefulWidget {
  const MapPropiedades({
    Key? key,
    this.width,
    this.height,
    required this.actionPaarama,
  }) : super(key: key);

  final double? width;
  final double? height;
  final Future<dynamic> Function() actionPaarama;

  @override
  _MapPropiedadesState createState() => _MapPropiedadesState();
}

class _MapPropiedadesState extends State<MapPropiedades> {
  // Declarar las listas de marcadores y círculos en tu clase
  Set<map.Marker> _markers = {};
  Set<map.Circle> _circles = {};
  //late map.LatLng _initialLocation;
  late map.LatLng _initialLocation =
      map.LatLng(19.4, -99.4); // Valor predeterminado
  late map.Marker _currentLocationMarker;

  final Completer<map.GoogleMapController> _controller =
      Completer<map.GoogleMapController>();
  final TextEditingController _searchController = TextEditingController();
  
  // Variable para almacenar la propiedad seleccionada
  PropertiesRecord? _selectedProperty;
  map.LatLng? _selectedPosition;
  
  // Índice de la foto actual en el slider
  int _currentPhotoIndex = 0;

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }
  
  @override
  void didUpdateWidget(MapPropiedades oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Actualizar círculo cuando cambia el radio
    updateCircle();
  }
  
  void updateCircle() {
    if (FFAppState().ubicacionMapaPrinc != null) {
      setState(() {
        _circles.clear();
        _circles.add(map.Circle(
          circleId: map.CircleId('search_area'),
          center: map.LatLng(
            FFAppState().ubicacionMapaPrinc!.latitude,
            FFAppState().ubicacionMapaPrinc!.longitude,
          ),
          radius: FFAppState().radioCircle * 1000, // Radio en metros
          fillColor: Colors.blue.withOpacity(0.2),
          strokeColor: Colors.blue,
          strokeWidth: 2,
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white
                  .withOpacity(0.1), // Fondo negro con 60% de opacidad
              borderRadius: BorderRadius.circular(
                  12), // Asegura que el fondo tenga bordes redondeados como el TextField
            ),
            child: TextField(
              controller: _searchController,
              readOnly: true,
              onTap: _handleSearchTap,
              decoration: InputDecoration(
                hintText: 'Buscar lugar',
                hintStyle: const TextStyle(
                  color: Colors.white, // Texto blanco
                  //fontWeight: FontWeight.bold, // Texto en negrita
                ),
                suffixIcon: const Icon(
                  Icons.search,
                  color: Colors.white, // Ícono blanco
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(color: Colors.transparent), // Sin borde
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(color: Colors.transparent), // Sin borde
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                map.GoogleMap(
                  mapType: map.MapType.normal,
                  initialCameraPosition: map.CameraPosition(
                    target: _initialLocation,
                    zoom: 4.0,
                  ),
                  onMapCreated: (map.GoogleMapController controller) {
                    _controller.complete(controller);
                    controller.setMapStyle(_darkMapStyle);
                  },
                  onTap: _handleTap,
                  markers: _markers,
                  circles: _circles,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                ),
                // Card flotante personalizado con imagen
                if (_selectedProperty != null)
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: IgnorePointer(
                      ignoring: false,
                      child: _buildPropertyCard(_selectedProperty!),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _handleSearchTap() async {
    setState(() {
      // No limpiar círculos aquí, se actualizarán en _goToPlace
      print('july');
    });
    final place = await showSearch<Place?>(
      context: context,
      delegate: PlaceSearchDelegate(),
    );

    if (place != null) {
      _goToPlace(place);
    }
  }

  Future<void> _goToPlace(Place place) async {
    final map.GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      map.CameraUpdate.newCameraPosition(
        map.CameraPosition(
          target: place.latLng,
          zoom: 14.0,
        ),
      ),
    );

    // Convierte el objeto LatLng al tipo esperado por FFAppState
    final ffLatLng = ff.LatLng(place.latLng.latitude, place.latLng.longitude);
    setState(() {
      FFAppState().ubicacionMapaPrinc = ffLatLng;
      widget.actionPaarama();

      // Limpiar círculos anteriores y añadir nuevo círculo
      _circles.clear();
      _circles.add(map.Circle(
        circleId: map.CircleId('search_area'),
        center: place.latLng,
        radius: FFAppState().radioCircle * 1000, // Radio en metros
        fillColor: Colors.blue.withOpacity(0.2),
        strokeColor: Colors.blue,
        strokeWidth: 2,
      ));
      print('july: ' + place.placeId);
    });
  }

  void _handleTap(map.LatLng tappedPoint) async {
    // Cerrar el card cuando se hace clic fuera de un marker
    setState(() {
      _selectedProperty = null;
      _selectedPosition = null;
      _currentPhotoIndex = 0;
    });
  }

  void _loadMarkers() async {
    Set<map.Marker> newMarkers = {};

    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('properties').get();

      for (var doc in querySnapshot.docs) {
        try {
          // Skip documents without required fields
          final data = doc.data() as Map<String, dynamic>?;
          if (data == null || !data.containsKey('price') || !data.containsKey('coordenadas')) {
            continue;
          }
          
          var propertiesRecord = PropertiesRecord.fromSnapshot(doc);
          var coordenadas = doc['coordenadas'] as List<dynamic>;
          var priceK = doc['price'] / 1000;
          var priceKM = priceK.toString() + 'k';
          var formattedPrice = '   ' +
              NumberFormat.currency(locale: 'en_US', symbol: '\$')
                  .format(doc['price']) +
              '    |    Detalles -->';

          for (var coord in coordenadas) {
            try {
              final markerIcon = await _createCustomMarkerBitmap(priceKM);
              final marker = map.Marker(
                markerId:
                    map.MarkerId('${coord['latitud']}_${coord['longitud']}'),
                position: map.LatLng(coord['latitud'], coord['longitud']),
                onTap: () {
                  setState(() {
                    _selectedProperty = propertiesRecord;
                    _selectedPosition = map.LatLng(coord['latitud'], coord['longitud']);
                    _currentPhotoIndex = 0;
                  });
                },
                icon: markerIcon,
              );
              newMarkers.add(marker);
            } catch (e) {
              print(
                  'Error creating marker for coordinates: ${coord['latitud']}, ${coord['longitud']} - $e');
            }
          }
        } catch (e) {
          print('Error processing document: ${doc.id} - $e');
        }
      }
    } catch (e) {
      print('Error loading markers: $e');
    }

    setState(() {
      _markers = newMarkers;
      print('Markers: ${_markers.length}'); // Debug print
    });
  }

  void _onInfoWindowTapped(PropertiesRecord propertiesRecord) {
    // Navegar a la página detailsProperties con la referencia del documento
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            PropertyDetailsWidget(propertyRef: propertiesRecord),
      ),
    );
  }

  Future<void> _getInitialLocation() async {
    try {
      print('📍 Solicitando ubicación actual...');
      
      // Configurar timeout más largo para web
      final timeoutDuration = kIsWeb ? Duration(seconds: 10) : Duration(seconds: 5);
      
      geo.Position position = await geo.Geolocator.getCurrentPosition(
        desiredAccuracy: geo.LocationAccuracy.high,
        timeLimit: timeoutDuration,
      ).timeout(
        timeoutDuration,
        onTimeout: () {
          print('⏱️ Timeout obteniendo ubicación');
          throw TimeoutException('No se pudo obtener la ubicación en el tiempo esperado');
        },
      );
      
      print('✅ Ubicación obtenida: ${position.latitude}, ${position.longitude}');
      
      setState(() {
        _initialLocation = map.LatLng(position.latitude, position.longitude);
        final ffLatLng = ff.LatLng(position.latitude, position.longitude);
        FFAppState().ubicacionMapaPrinc = ffLatLng;

        _currentLocationMarker = map.Marker(
          markerId: map.MarkerId('current_location'),
          position: _initialLocation,
        );
        
        // Añadir círculo inicial con radio por defecto
        _circles.clear();
        _circles.add(map.Circle(
          circleId: map.CircleId('search_area'),
          center: _initialLocation,
          radius: FFAppState().radioCircle * 1000,
          fillColor: Colors.blue.withOpacity(0.2),
          strokeColor: Colors.blue,
          strokeWidth: 2,
        ));
      });
      
      final map.GoogleMapController controller = await _controller.future;
      controller.animateCamera(
        map.CameraUpdate.newCameraPosition(
          map.CameraPosition(
            target: _initialLocation,
            zoom: 12.0,
          ),
        ),
      );
    } catch (e) {
      print('❌ Error obteniendo la ubicación: $e');
      print('💡 Usando ubicación por defecto (Tijuana)');
      
      // Establecer ubicación por defecto (Tijuana)
      setState(() {
        _initialLocation = map.LatLng(32.5149, -117.0382);
        final ffLatLng = ff.LatLng(32.5149, -117.0382);
        FFAppState().ubicacionMapaPrinc = ffLatLng;
        
        _circles.clear();
        _circles.add(map.Circle(
          circleId: map.CircleId('search_area'),
          center: _initialLocation,
          radius: FFAppState().radioCircle * 1000,
          fillColor: Colors.blue.withOpacity(0.2),
          strokeColor: Colors.blue,
          strokeWidth: 2,
        ));
      });
    }
  }

  Future<void> _checkLocationPermission() async {
    try {
      print('🔍 Verificando permisos de ubicación...');
      
      // Verificar si el servicio de ubicación está habilitado
      bool serviceEnabled = await geo.Geolocator.isLocationServiceEnabled();
      print('📍 Servicio de ubicación habilitado: $serviceEnabled');
      
      if (!serviceEnabled) {
        print('⚠️ Servicio de ubicación deshabilitado');
        // En web, si el servicio está deshabilitado, intentar de todas formas
        if (kIsWeb) {
          print('🌐 Intentando obtener ubicación en web de todas formas...');
        } else {
          print('❌ Por favor habilita el servicio de ubicación');
          return;
        }
      }
      
      geo.LocationPermission permission = await geo.Geolocator.checkPermission();
      print('🔐 Permiso actual: $permission');
      
      if (permission == geo.LocationPermission.denied) {
        print('⚠️ Permiso denegado, solicitando permiso...');
        permission = await geo.Geolocator.requestPermission();
        print('🔐 Nuevo permiso: $permission');
        
        if (permission == geo.LocationPermission.denied) {
          print('❌ Permiso de ubicación denegado por el usuario');
          // Mostrar ubicación por defecto
          _loadMarkers();
          return;
        }
      }
      
      if (permission == geo.LocationPermission.deniedForever) {
        print('❌ Permiso de ubicación denegado permanentemente');
        print('💡 El usuario debe habilitar manualmente en configuración del navegador');
        // Mostrar ubicación por defecto
        _loadMarkers();
        return;
      }
      
      // Permisos otorgados
      print('✅ Permisos otorgados, obteniendo ubicación...');
      _getInitialLocation();
      _loadMarkers();
    } catch (e) {
      print('❌ Error al verificar permisos: $e');
      // En caso de error, cargar markers con ubicación por defecto
      _loadMarkers();
    }
  }

  Future<map.BitmapDescriptor> _createCustomMarkerBitmap(String text) async {
    final double originalWidth = 22;
    final double originalHeight = 20;
    final double scaleFactor = 4.0;

    // Detectar la plataforma

    bool isWeb = kIsWeb;

    final double width = isWeb ? originalWidth : originalWidth * scaleFactor;
    final double height = isWeb ? originalHeight : originalHeight * scaleFactor;

    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder, Rect.fromLTWH(0, 0, width, height));

    // Cambiar el color a #4B39EF
    final Paint paint = Paint()..color = Color(0xFF4B39EF);

    final Path path = Path()
      ..moveTo(width / 2, 0)
      ..lineTo(width, height / 3)
      ..lineTo(width, height)
      ..lineTo(0, height)
      ..lineTo(0, height / 3)
      ..close();
    canvas.drawPath(path, paint);

    // Ajustar el tamaño del círculo
    canvas.drawCircle(
        Offset(width / 2, height / 3.5),
        isWeb ? 3 : 12,
        Paint()
          ..color = Colors.white); // Duplicar el radio del círculo para iOS

    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
            color: Colors.white,
            fontSize: isWeb ? 8 : 28,
            fontWeight:
                FontWeight.bold), // Duplicar el tamaño de la fuente para iOS
      ),
      textDirection: ui.TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: width,
    );
    final double textHeight = textPainter.height;
    textPainter.paint(
        canvas,
        Offset(
            (width - textPainter.width) / 2, (height / 3.5 + textHeight / 4)));

    final ui.Picture picture = recorder.endRecording();
    final ui.Image image = await picture.toImage(width.toInt(), height.toInt());
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List bytes = byteData!.buffer.asUint8List();

    return map.BitmapDescriptor.fromBytes(bytes);
  }

  // Widget para mostrar el card flotante con la imagen de la propiedad
  Widget _buildPropertyCard(PropertiesRecord property) {
    final priceFormatted = NumberFormat.currency(locale: 'en_US', symbol: '\$')
        .format(property.price);
    
    // Obtener lista de imágenes
    List<String> images = [];
    if (property.mainImage != null && property.mainImage!.isNotEmpty) {
      images.add(property.mainImage!);
    }
    if (property.hasImages() && property.images.isNotEmpty) {
      for (var imageStruct in property.images) {
        if (imageStruct.imageUrl.isNotEmpty) {
          images.add(imageStruct.imageUrl);
        }
      }
    }
    
    // Si no hay imágenes, usar placeholder
    if (images.isEmpty) {
      images.add('');
    }
    
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () {}, // Absorber taps para no pasar al mapa
        child: Container(
          constraints: BoxConstraints(maxWidth: 420),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 16,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Slider de imágenes con controles
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _onInfoWindowTapped(property),
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  child: Stack(
                  children: [
                    // Imagen actual del slider
                    Container(
                      height: 180,
                      width: double.infinity,
                      child: images[_currentPhotoIndex].isNotEmpty
                          ? Image.network(
                              images[_currentPhotoIndex],
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Color(0xFFE0E0E0),
                                  child: Center(
                                    child: Icon(
                                      Icons.home_work_rounded,
                                      size: 48,
                                      color: Color(0xFF9E9E9E),
                                    ),
                                  ),
                                );
                              },
                            )
                          : Container(
                              color: Color(0xFFE0E0E0),
                              child: Center(
                                child: Icon(
                                  Icons.home_work_rounded,
                                  size: 48,
                                  color: Color(0xFF9E9E9E),
                                ),
                              ),
                            ),
                    ),
                    // Gradient overlay
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.5),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Precio badge
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Color(0xFF1E3A8A),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          priceFormatted,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ),
                    // Botón cerrar
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          setState(() {
                            _selectedProperty = null;
                            _selectedPosition = null;
                            _currentPhotoIndex = 0;
                          });
                        },
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.close,
                            size: 18,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                      ),
                    ),
                    // Controles del slider (solo si hay más de una imagen)
                    if (images.length > 1) ...[
                      // Botón anterior
                      if (_currentPhotoIndex > 0)
                        Positioned(
                          left: 0,
                          top: 0,
                          bottom: 0,
                          width: 60,
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                setState(() {
                                  _currentPhotoIndex--;
                                });
                              },
                              child: Center(
                                child: Container(
                                  width: 38,
                                  height: 38,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.95),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.25),
                                        blurRadius: 6,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.chevron_left,
                                    size: 26,
                                    color: Color(0xFF1F2937),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      // Botón siguiente
                      if (_currentPhotoIndex < images.length - 1)
                        Positioned(
                          right: 0,
                          top: 0,
                          bottom: 0,
                          width: 60,
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                setState(() {
                                  _currentPhotoIndex++;
                                });
                              },
                              child: Center(
                                child: Container(
                                  width: 38,
                                  height: 38,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.95),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.25),
                                        blurRadius: 6,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.chevron_right,
                                    size: 26,
                                    color: Color(0xFF1F2937),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      // Indicador de página
                      Positioned(
                        bottom: 10,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            images.length,
                            (index) => Container(
                              width: 7,
                              height: 7,
                              margin: EdgeInsets.symmetric(horizontal: 3),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentPhotoIndex == index
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.4),
                                    blurRadius: 3,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            // Información de la propiedad
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nombre de la propiedad
                  Text(
                    property.propertyName ?? 'Propiedad',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1F2937),
                      fontFamily: 'Inter',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 6),
                  // Ubicación
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 14,
                        color: Color(0xFF6B7280),
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          property.propertyNeighborhood ?? 'Ubicación',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF6B7280),
                            fontFamily: 'Inter',
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  // Detalles y botón
                  Row(
                    children: [
                      if (property.hasRoomsPropiedad()) ...[
                        Icon(Icons.bed, size: 16, color: Color(0xFF1E3A8A)),
                        SizedBox(width: 3),
                        Text(
                          '${property.roomsPropiedad}',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF1F2937),
                            fontFamily: 'Inter',
                          ),
                        ),
                        SizedBox(width: 12),
                      ],
                      if (property.hasBathsPropiedad()) ...[
                        Icon(Icons.bathtub, size: 16, color: Color(0xFF1E3A8A)),
                        SizedBox(width: 3),
                        Text(
                          '${property.bathsPropiedad}',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF1F2937),
                            fontFamily: 'Inter',
                          ),
                        ),
                      ],
                      Spacer(),
                      // Botón ver detalles compacto
                      InkWell(
                        onTap: () => _onInfoWindowTapped(property),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: Color(0xFF1E3A8A),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Ver',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontFamily: 'Inter',
                                ),
                              ),
                              SizedBox(width: 4),
                              Icon(
                                Icons.arrow_forward,
                                size: 14,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }

  static const String _darkMapStyle = '''
  [
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#ffffff"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dadada"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#c9c9c9"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  }
]
  ''';
  //end
}

class Place {
  final String placeId;
  final String name;
  final String address;
  final map.LatLng latLng;

  Place({
    required this.placeId,
    required this.name,
    required this.address,
    required this.latLng,
  });
}

class PlaceSearchDelegate extends SearchDelegate<Place?> {
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: () => query = '')];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<Place>>(
      future: _searchPlaces(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final place = snapshot.data![index];
                return ListTile(
                  title: Text(place.name),
                  subtitle: Text(place.address),
                  onTap: () => close(context, place),
                );
              },
            );
          } else {
            return Center(child: Text('No se encontraron resultados.'));
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onSearchChanged(query, context);
    return Container();
  }

  void _onSearchChanged(String query, BuildContext context) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(seconds: 4), () {
      //SEGUNDOS INACTIVOS DE ESCRIBIR QUE ESPERA PARA BUSCAR
      if (query.isNotEmpty) {
        showResults(context);
      }
    });
  }

  Future<List<Place>> _searchPlaces(String input) async {
    final String baseUrl =
        'https://us-central1-gpi-homes-6j0y9b.cloudfunctions.net/api/google-maps-autocomplete';
    final String request = '$baseUrl?input=$input';
    final response = await http.get(Uri.parse(request));
    final json = jsonDecode(response.body);
    print(json.toString());

    if (json['status'] == 'OK') {
      final predictions = json['predictions'] as List;
      return Future.wait(predictions.map((p) async {
        final details = await _getPlaceDetails(p['place_id']);
        return Place(
          placeId: p['place_id'],
          name: p['description'],
          address: details['formatted_address'],
          latLng: map.LatLng(
            details['geometry']['location']['lat'],
            details['geometry']['location']['lng'],
          ),
        );
      }).toList());
    } else {
      throw Exception('Error fetching place predictions: ${json['status']}');
    }
  }

  Future<Map<String, dynamic>> _getPlaceDetails(String placeId) async {
    final String baseUrl =
        'https://us-central1-gpi-homes-6j0y9b.cloudfunctions.net/api/google-maps-place-details';
    final String request = '$baseUrl?placeid=$placeId';
    final response = await http.get(Uri.parse(request));
    final json = jsonDecode(response.body);
    print(json.toString());

    if (json['status'] == 'OK') {
      return json['result'];
    } else {
      throw Exception('Error fetching place details: ${json['status']}');
    }
  }
}

// THE JAVASCRIPT FIREBASE FUNCTION :

// const functions = require('firebase-functions');

// const admin = require('firebase-admin');
// const express = require('express');
// const cors = require('cors');
// const axios = require('axios');

// admin.initializeApp();

// const app = express();

// // Habilitar CORS para todas las solicitudes
// app.use(cors({ origin: true }));

// // Crear una ruta para hacer proxy a la API de Google Maps
// app.get('/google-maps-autocomplete', async (req, res) => {
//   try {
//     const response = await axios.get('https://maps.googleapis.com/maps/api/place/autocomplete/json', {
//       params: {
//         input: req.query.input,  // el término de búsqueda
//         key: 'AIzaSyCxQth-MdaAZiriOmOTinAj5362UUWNN9g',  // tu clave de API de Google Maps
//         language: 'es',
//       },
//     });
//     res.json(response.data);  // enviar los datos de la respuesta al cliente
//   } catch (error) {
//     res.status(500).json({ error: 'Error fetching data from Google Maps' });
//   }
// });

// // Ruta para obtener los detalles de un lugar usando placeid
// app.get('/google-maps-place-details', async (req, res) => {
//     const placeId = req.query.placeid;
//     if (!placeId) {
//       return res.status(400).send({ error: 'placeid es requerido' });
//     }

//     try {
//       const response = await axios.get('https://maps.googleapis.com/maps/api/place/details/json', {
//         params: {
//           placeid: placeId,  // el ID del lugar
//           key: 'AIzaSyCxQth-MdaAZiriOmOTinAj5362UUWNN9g',  // tu clave de API de Google Maps
//         },
//       });
//       res.json(response.data);  // enviar los datos de la respuesta al cliente
//     } catch (error) {
//       res.status(500).json({ error: 'Error fetching place details from Google Maps' });
//     }
//   });

// // Exportar la función
// exports.api = functions.https.onRequest(app);
