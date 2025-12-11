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

//import '/custom_code/actions/index.dart'; // Imports custom actions

import 'package:google_maps_flutter/google_maps_flutter.dart' as map;
import 'dart:async';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:http/http.dart' as http;
import 'dart:convert';

class MapAddLocation extends StatefulWidget {
  const MapAddLocation({
    Key? key,
    this.width,
    this.height,
    this.dataTypeCoords,
    required this.actionPaarama,
  }) : super(key: key);

  final double? width;
  final double? height;
  final List<CoordenadasStruct>? dataTypeCoords;
  final Future<dynamic> Function() actionPaarama;

  @override
  _MapAddLocationState createState() => _MapAddLocationState();
}

class _MapAddLocationState extends State<MapAddLocation> {
  late map.LatLng _initialLocation;
  final Completer<map.GoogleMapController> _controller =
      Completer<map.GoogleMapController>();

  Set<map.Marker> _markers = {};

  String? number;
  String? street;
  String? neighborhood;
  String? city;
  String? state;
  String? postalCode;

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
    _getInitialLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20), // Adjust the radius as needed
        child: Stack(
          children: [
            map.GoogleMap(
              mapType: map.MapType.normal,
              initialCameraPosition: map.CameraPosition(
                target: _initialLocation,
                zoom: 18.0,
              ),
              onMapCreated: (map.GoogleMapController controller) {
                _controller.complete(controller);
              },
              onTap: _handleTap,
              markers: _markers,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
            ),
          ],
        ),
      ),
    );
  }

  void _handleTap(map.LatLng tappedPoint) async {
    print(tappedPoint);

    FFAppState().coordsMaps = CoordenadasStruct(
      latitud: tappedPoint.latitude,
      longitud: tappedPoint.longitude,
    );

    FFAppState().coordenadasMaps =
        LatLng(tappedPoint.latitude, tappedPoint.longitude);

    final addressComponents = await getAddressFromCoordinates(
      tappedPoint.latitude,
      tappedPoint.longitude,
    );

    final formattedAddress =
        '${addressComponents['street']} ${addressComponents['number']}, ${addressComponents['neighborhood']}, ${addressComponents['city']}, ${addressComponents['state']} ${addressComponents['postalCode']}';

    setState(() {
      _markers = Set.from([
        map.Marker(
          markerId: map.MarkerId(tappedPoint.toString()),
          position: tappedPoint,
          infoWindow: map.InfoWindow(title: formattedAddress),
        ),
      ]);
    });
  }

  Future<Map<String, String>> getAddressFromCoordinates(
      double lat, double lng) async {
    final apiKey = 'AIzaSyCxQth-MdaAZiriOmOTinAj5362UUWNN9g';
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> addressComponents =
            data['results'][0]['address_components'];

        for (final component in addressComponents) {
          final List<dynamic> types = component['types'];
          final String longName = component['long_name'];

          if (types.contains('street_number')) {
            number = longName;

            FFAppState().numeroMaps = number!;
          } else if (types.contains('route')) {
            street = longName;
            FFAppState().calleMaps = street!;
          } else if (types.contains('sublocality')) {
            neighborhood = longName;
            FFAppState().barrioMaps = neighborhood!;
          } else if (types.contains('locality')) {
            city = longName;
            FFAppState().ciudadMaps = city!;
          } else if (types.contains('administrative_area_level_1')) {
            state = longName;
            FFAppState().estadoMaps = state!;
          } else if (types.contains('postal_code')) {
            postalCode = longName;
            FFAppState().cpostalMaps = postalCode!;
          }
        }
        widget.actionPaarama();

        return {
          'number': number ?? '',
          'street': street ?? '',
          'neighborhood': neighborhood ?? '',
          'city': city ?? '',
          'state': state ?? '',
          'postalCode': postalCode ?? '',
        };
      } else {
        throw Exception('Failed to load address');
      }
    } catch (e) {
      throw Exception('Failed to load address: $e');
    }
  }

  Future<void> _getInitialLocation() async {
    // Obtener la ubicación actual del dispositivo
    try {
      geo.Position position = await geo.Geolocator.getCurrentPosition(
          desiredAccuracy: geo.LocationAccuracy.high);
      setState(() {
        _initialLocation = map.LatLng(position.latitude, position.longitude);
      });
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
  }

  //end
}
