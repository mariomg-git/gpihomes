import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/backend/backend.dart';
import '/auth/firebase_auth/auth_util.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'home_page_publicar_model.dart';
export 'home_page_publicar_model.dart';

class HomePagePublicarWidget extends StatefulWidget {
  const HomePagePublicarWidget({super.key});

  @override
  State<HomePagePublicarWidget> createState() => _HomePagePublicarWidgetState();
}

class _HomePagePublicarWidgetState extends State<HomePagePublicarWidget> {
  late HomePagePublicarModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isCreatingProperties = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePagePublicarModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Title(
        title: 'homePage_Publicar',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: double.infinity,
                  height: 250.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).dark600,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 3.0,
                        color: Color(0x39000000),
                        offset: Offset(
                          0.0,
                          2.0,
                        ),
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            24.0, 40.0, 0.0, 0.0),
                        child: Image.asset(
                          'assets/images/GPI-Homes-black.png',
                          width: 200.0,
                          height: 50.0,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            24.0, 12.0, 24.0, 8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              FFLocalizations.of(context).getText(
                                '1s2q0j7g' /* Welcome! */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .displaySmall
                                  .override(
                                    fontFamily: 'Poiret One',
                                    color:
                                        FlutterFlowTheme.of(context).tertiary,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              FFLocalizations.of(context).getText(
                                'u71lugq4' /* Find your Dream Space  */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'Poiret One',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w300,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FFButtonWidget(
                        onPressed: () async {
                          context.pushNamed(
                            'createProperty_1',
                            extra: <String, dynamic>{
                              kTransitionInfoKey: const TransitionInfo(
                                hasTransition: true,
                                transitionType: PageTransitionType.bottomToTop,
                                duration: Duration(milliseconds: 250),
                              ),
                            },
                          );
                        },
                        text: FFLocalizations.of(context).getText(
                          'odcn6twf' /* Publish Propertie */,
                        ),
                        options: FFButtonOptions(
                          width: 240.0,
                          height: 60.0,
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          iconPadding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle:
                              FlutterFlowTheme.of(context).titleLarge.override(
                                    fontFamily: 'Inter',
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                          elevation: 3.0,
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      FFButtonWidget(
                        onPressed: _isCreatingProperties ? null : () async {
                          if (!mounted || _isCreatingProperties) return;
                          
                          setState(() {
                            _isCreatingProperties = true;
                          });
                          
                          try {
                            if (!mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '🗑️ Eliminando propiedades antiguas...',
                                  style: TextStyle(
                                    color: FlutterFlowTheme.of(context).primaryText,
                                  ),
                                ),
                                duration: const Duration(milliseconds: 2000),
                                backgroundColor: FlutterFlowTheme.of(context).warning,
                              ),
                            );
                            
                            // Eliminar propiedades antiguas
                            final oldProperties = await PropertiesRecord.collection
                                .where('idUser', isEqualTo: currentUserUid)
                                .get();
                            
                            print('🗑️ Eliminando ${oldProperties.docs.length} propiedades antiguas...');
                            
                            for (var doc in oldProperties.docs) {
                              await doc.reference.delete();
                              print('  ✅ Eliminada: ${doc.id}');
                            }
                            
                            print('🧪 DEBUG: Iniciando creación de propiedades de prueba...');
                            
                            if (!mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '⏳ Creando propiedades de prueba...',
                                  style: TextStyle(
                                    color: FlutterFlowTheme.of(context).primaryText,
                                  ),
                                ),
                                duration: const Duration(milliseconds: 2000),
                                backgroundColor: FlutterFlowTheme.of(context).info,
                              ),
                            );
                            
                            await _createTestProperties();
                            
                            print('✅ DEBUG: Propiedades creadas exitosamente');
                            
                            if (!mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '✅ 10 propiedades nuevas creadas exitosamente',
                                  style: TextStyle(
                                    color: FlutterFlowTheme.of(context).primaryText,
                                  ),
                                ),
                                duration: const Duration(milliseconds: 4000),
                                backgroundColor: FlutterFlowTheme.of(context).success,
                              ),
                            );
                          } catch (e, stackTrace) {
                            print('❌ DEBUG ERROR: $e');
                            print('📋 DEBUG STACK TRACE: $stackTrace');
                            
                            if (!mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '❌ Error: ${e.toString()}',
                                  style: TextStyle(
                                    color: FlutterFlowTheme.of(context).primaryText,
                                  ),
                                ),
                                duration: const Duration(milliseconds: 6000),
                                backgroundColor: FlutterFlowTheme.of(context).error,
                              ),
                            );
                          } finally {
                            if (mounted) {
                              setState(() {
                                _isCreatingProperties = false;
                              });
                            }
                          }
                        },
                        text: _isCreatingProperties 
                            ? '⏳ Procesando...' 
                            : '🔄 Limpiar y Crear Propiedades Test',
                        options: FFButtonOptions(
                          width: 240.0,
                          height: 50.0,
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          iconPadding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).secondary,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Inter',
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                          elevation: 2.0,
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      FFButtonWidget(
                        onPressed: () async {
                          await _checkPropertiesWithoutPrice();
                        },
                        text: '🔍 Identificar Propiedades sin Price',
                        options: FFButtonOptions(
                          width: 240.0,
                          height: 50.0,
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          iconPadding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).warning,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Inter',
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                          elevation: 2.0,
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Future<void> _checkPropertiesWithoutPrice() async {
    print('🔍 DEBUG: Verificando propiedades sin campo price...');
    
    try {
      final snapshot = await firestore.FirebaseFirestore.instance
          .collection('properties')
          .get();
      
      print('📊 Total de propiedades en la base de datos: ${snapshot.docs.length}');
      
      List<Map<String, dynamic>> propertiesWithoutPrice = [];
      List<Map<String, dynamic>> propertiesWithoutCoords = [];
      List<Map<String, dynamic>> validProperties = [];
      
      for (var doc in snapshot.docs) {
        final data = doc.data();
        final id = doc.id;
        
        bool hasPrice = data.containsKey('price');
        bool hasCoords = data.containsKey('coordenadas') || data.containsKey('propertyCoords');
        
        Map<String, dynamic> propInfo = {
          'id': id,
          'propertyName': data['propertyName'] ?? 'Sin nombre',
          'tipoPropiedad': data['tipoPropiedad'] ?? 'No especificado',
          'status': data['status'] ?? 'No especificado',
        };
        
        if (!hasPrice) {
          propertiesWithoutPrice.add(propInfo);
        }
        
        if (!hasCoords) {
          propertiesWithoutCoords.add(propInfo);
        }
        
        if (hasPrice && hasCoords) {
          propInfo['price'] = data['price'];
          validProperties.add(propInfo);
        }
      }
      
      print('\n========================================');
      print('📋 REPORTE DE PROPIEDADES');
      print('========================================\n');
      
      print('✅ Propiedades VÁLIDAS (con price y coordenadas): ${validProperties.length}');
      for (var prop in validProperties) {
        print('  - ${prop['propertyName']} (${prop['tipoPropiedad']})');
        print('    ID: ${prop['id']}');
        print('    Precio: \$${prop['price']}');
        print('    Status: ${prop['status']}');
      }
      
      print('\n⚠️ Propiedades SIN PRICE: ${propertiesWithoutPrice.length}');
      for (var prop in propertiesWithoutPrice) {
        print('  - ${prop['propertyName']} (${prop['tipoPropiedad']})');
        print('    ID: ${prop['id']}');
        print('    Status: ${prop['status']}');
      }
      
      print('\n⚠️ Propiedades SIN COORDENADAS: ${propertiesWithoutCoords.length}');
      for (var prop in propertiesWithoutCoords) {
        print('  - ${prop['propertyName']} (${prop['tipoPropiedad']})');
        print('    ID: ${prop['id']}');
        print('    Status: ${prop['status']}');
      }
      
      print('\n========================================');
      print('RESUMEN:');
      print('  Total: ${snapshot.docs.length}');
      print('  Válidas: ${validProperties.length}');
      print('  Sin price: ${propertiesWithoutPrice.length}');
      print('  Sin coordenadas: ${propertiesWithoutCoords.length}');
      print('========================================\n');
      
      // Mostrar diálogo con resultados
      if (mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('📊 Reporte de Propiedades'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total: ${snapshot.docs.length}'),
                    const SizedBox(height: 10),
                    Text('✅ Válidas: ${validProperties.length}', 
                         style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    Text('⚠️ Sin price: ${propertiesWithoutPrice.length}', 
                         style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    Text('⚠️ Sin coordenadas: ${propertiesWithoutCoords.length}', 
                         style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 15),
                    if (propertiesWithoutPrice.isNotEmpty) ...[
                      const Text('Propiedades sin price:', 
                                 style: TextStyle(fontWeight: FontWeight.bold)),
                      ...propertiesWithoutPrice.map((prop) => 
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 5),
                          child: Text('• ${prop['propertyName']}\n  ID: ${prop['id']}',
                                    style: const TextStyle(fontSize: 12)),
                        )
                      ),
                    ],
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cerrar'),
                ),
              ],
            );
          },
        );
      }
      
    } catch (e) {
      print('❌ Error al verificar propiedades: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  Future<void> _createTestProperties() async {
    print('📊 DEBUG: Entrando a _createTestProperties');
    
    final random = math.Random();
    
    print('🔐 DEBUG: Verificando autenticación...');
    if (currentUserUid.isEmpty) {
      print('❌ DEBUG: No hay usuario autenticado!');
      throw Exception('Debes estar autenticado para crear propiedades');
    }
    print('✅ DEBUG: Usuario autenticado: $currentUserUid');
    
    // Datos de ejemplo para Tijuana
    final tijuanaData = [
      {
        'neighborhood': 'Zona Río',
        'coords': const LatLng(32.5149, -117.0382),
        'city': 'Tijuana',
        'state': 'Baja California',
        'zipCode': '22010',
      },
      {
        'neighborhood': 'Playas de Tijuana',
        'coords': const LatLng(32.4628, -117.1242),
        'city': 'Tijuana',
        'state': 'Baja California',
        'zipCode': '22504',
      },
      {
        'neighborhood': 'Chapultepec',
        'coords': const LatLng(32.5170, -117.0280),
        'city': 'Tijuana',
        'state': 'Baja California',
        'zipCode': '22420',
      },
      {
        'neighborhood': 'Otay',
        'coords': const LatLng(32.5550, -116.9380),
        'city': 'Tijuana',
        'state': 'Baja California',
        'zipCode': '22430',
      },
      {
        'neighborhood': 'La Cacho',
        'coords': const LatLng(32.4980, -117.0150),
        'city': 'Tijuana',
        'state': 'Baja California',
        'zipCode': '22105',
      },
    ];

    // Datos de ejemplo para Ciudad de México
    final cdmxData = [
      {
        'neighborhood': 'Polanco',
        'coords': const LatLng(19.4326, -99.1909),
        'city': 'Ciudad de México',
        'state': 'CDMX',
        'zipCode': '11560',
      },
      {
        'neighborhood': 'Roma Norte',
        'coords': const LatLng(19.4185, -99.1635),
        'city': 'Ciudad de México',
        'state': 'CDMX',
        'zipCode': '06700',
      },
      {
        'neighborhood': 'Condesa',
        'coords': const LatLng(19.4104, -99.1720),
        'city': 'Ciudad de México',
        'state': 'CDMX',
        'zipCode': '06140',
      },
      {
        'neighborhood': 'Santa Fe',
        'coords': const LatLng(19.3595, -99.2625),
        'city': 'Ciudad de México',
        'state': 'CDMX',
        'zipCode': '01376',
      },
      {
        'neighborhood': 'Coyoacán',
        'coords': const LatLng(19.3467, -99.1618),
        'city': 'Ciudad de México',
        'state': 'CDMX',
        'zipCode': '04000',
      },
    ];

    final propertyTypes = ['Casa', 'Departamento', 'Loft', 'Penthouse'];
    final sellerTypes = ['Dueño', 'Inmobiliaria', 'Agente'];
    final propertyNames = [
      'Hermosa Casa Moderna',
      'Departamento de Lujo',
      'Casa con Alberca',
      'Loft Contemporáneo',
      'Penthouse Vista Panorámica',
      'Casa Estilo Colonial',
      'Departamento Amueblado',
      'Residencia Exclusiva',
      'Apartamento Minimalista',
      'Villa Premium',
    ];

    final descriptions = [
      'Propiedad en excelente ubicación con acabados de primera calidad.',
      'Espacios amplios con diseño moderno y funcional.',
      'Ubicado en zona residencial exclusiva con todas las amenidades.',
      'Acabados de lujo, cocina integral y terrazas amplias.',
      'Perfecta para familias, cerca de escuelas y centros comerciales.',
    ];

    final imageUrls = [
      'https://images.unsplash.com/photo-1580587771525-78b9dba3b914?w=800',
      'https://images.unsplash.com/photo-1568605114967-8130f3a36994?w=800',
      'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=800',
      'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=800',
      'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=800',
    ];

    // Crear 10 propiedades (5 en Tijuana, 5 en CDMX)
    print('🏗️ DEBUG: Iniciando creación de 10 propiedades...');
    
    for (int i = 0; i < 10; i++) {
      try {
        print('\n📍 DEBUG: Creando propiedad ${i + 1}/10...');
        
        final isInTijuana = i < 5;
        final isRenta = i < 5; // Primeras 5 en renta, últimas 5 en venta
        final locationData = isInTijuana ? tijuanaData[i] : cdmxData[i - 5];
        
        print('  - Ubicación: ${locationData['city']} - ${locationData['neighborhood']}');
        print('  - Tipo: ${isRenta ? 'Renta' : 'Venta'}');
        
        final coords = locationData['coords'] as LatLng;
        
        final propertyData = {
          'propertyName': propertyNames[i],
          'propertyDescription': descriptions[random.nextInt(descriptions.length)],
          'mainImage': imageUrls[random.nextInt(imageUrls.length)],
          'propertyNeighborhood': locationData['neighborhood'],
          'propertyStreet': 'Calle ${random.nextInt(100) + 1}',
          'propertyNumber': '${random.nextInt(999) + 1}',
          'propertyCity': locationData['city'],
          'propertyState': locationData['state'],
          'propertyZipCode': locationData['zipCode'],
          'propertyCoords': firestore.GeoPoint(coords.latitude, coords.longitude), // Convertir a GeoPoint de Firestore
          'price': (random.nextInt(20) + 5) * 100000.0, // Entre $500k y $2.5M
          'roomsPropiedad': random.nextInt(4) + 2, // Entre 2 y 5 habitaciones
          'bathsPropiedad': random.nextInt(3) + 1, // Entre 1 y 3 baños
          'tipoPropiedad': isRenta ? 'Renta' : 'Venta', // 5 Renta, 5 Venta
          'tipoPropiedadInmueble': propertyTypes[random.nextInt(propertyTypes.length)], // Casa, Departamento, etc.
          'tipoVendedor': sellerTypes[random.nextInt(sellerTypes.length)],
          'status': 'Revisado', // CORREGIDO: Cambiar a 'Revisado' para que aparezca en el filtro
          'isLive': true,
          'isDraft': false,
          'userRef': currentUserReference,
          'idUser': currentUserUid,
          'lastUpdated': DateTime.now(),
          'fechaDisponibleProp': DateTime.now(),
          'telPropiedad': 6641234567,
          'ratingSummary': (random.nextInt(20) + 35) / 10.0, // Entre 3.5 y 5.0
          'minNights': random.nextInt(3) + 1,
          'coordenadas': [
            {
              'latitud': coords.latitude,
              'longitud': coords.longitude,
            }
          ],
        };

        print('  - Nombre: ${propertyData['propertyName']}');
        print('  - Precio: \$${propertyData['price']}');
        print('  - Tipo: ${propertyData['tipoPropiedad']}');
        print('  - Habitaciones: ${propertyData['roomsPropiedad']}');
        print('  📤 DEBUG: Enviando a Firestore...');

        final docRef = await PropertiesRecord.collection.add(propertyData);
        
        print('  ✅ DEBUG: Propiedad creada con ID: ${docRef.id}');
      } catch (e) {
        print('  ❌ DEBUG: Error al crear propiedad ${i + 1}: $e');
        rethrow; // Re-lanzar el error para que sea capturado por el try-catch principal
      }
    }
    
    print('\n🎉 DEBUG: ¡Todas las propiedades fueron creadas exitosamente!');
  }
}
