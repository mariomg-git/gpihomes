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

const String googleApiKey = 'AIzaSyCxQth-MdaAZiriOmOTinAj5362UUWNN9g';

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

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
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
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _handleSearchTap() async {
    setState(() {
      _circles.clear();
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

      // Añadir círculo para resaltar el área
      _circles.add(map.Circle(
        circleId: map.CircleId(place.placeId),
        center: place.latLng,
        radius: FFAppState().radioCircle * 1000, // Radio en metros
        fillColor: Colors.blue.withOpacity(0.5),
        strokeColor: Colors.blue,
        strokeWidth: 1,
      ));
      print('july: ' + place.placeId);
    });
  }

  void _handleTap(map.LatLng tappedPoint) async {
    // Implementación de evento para manejo de taps en el mapa
  }

  void _loadMarkers() async {
    Set<map.Marker> newMarkers = {};

    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('properties').get();

      for (var doc in querySnapshot.docs) {
        try {
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
                infoWindow: map.InfoWindow(
                  title: '${doc['propertyName']}',
                  snippet: formattedPrice,
                  onTap: () {
                    _onInfoWindowTapped(propertiesRecord);
                  },
                ),
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
      geo.Position position = await geo.Geolocator.getCurrentPosition(
          desiredAccuracy: geo.LocationAccuracy.high);
      setState(() {
        _initialLocation = map.LatLng(position.latitude, position.longitude);
        final ffLatLng = ff.LatLng(position.latitude, position.longitude);
        FFAppState().ubicacionMapaPrinc = ffLatLng;

        _currentLocationMarker = map.Marker(
          markerId: map.MarkerId('current_location'),
          position: _initialLocation,
        );
        //_markers.add(_currentLocationMarker);
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
      print('Error obteniendo la ubicación: $e');
    }
  }

  Future<void> _checkLocationPermission() async {
    geo.LocationPermission permission = await geo.Geolocator.checkPermission();
    if (permission == geo.LocationPermission.denied ||
        permission == geo.LocationPermission.deniedForever) {
      permission = await geo.Geolocator.requestPermission();
      if (permission != geo.LocationPermission.whileInUse &&
          permission != geo.LocationPermission.always) {
        // Los permisos de ubicación están denegados
        return;
      }
    }
    // Permisos otorgados, obtener la ubicación inicial
    _getInitialLocation();
    _loadMarkers();
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
