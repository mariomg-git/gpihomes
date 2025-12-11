import 'dart:async';

import 'serialization_util.dart';
import '../backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';


final _handledMessageIds = <String?>{};

class PushNotificationsHandler extends StatefulWidget {
  const PushNotificationsHandler({super.key, required this.child});

  final Widget child;

  @override
  _PushNotificationsHandlerState createState() =>
      _PushNotificationsHandlerState();
}

class _PushNotificationsHandlerState extends State<PushNotificationsHandler> {
  bool _loading = false;

  Future handleOpenedPushNotification() async {
    if (isWeb) {
      return;
    }

    final notification = await FirebaseMessaging.instance.getInitialMessage();
    if (notification != null) {
      await _handlePushNotification(notification);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handlePushNotification);
  }

  Future _handlePushNotification(RemoteMessage message) async {
    if (_handledMessageIds.contains(message.messageId)) {
      return;
    }
    _handledMessageIds.add(message.messageId);

    safeSetState(() => _loading = true);
    try {
      final initialPageName = message.data['initialPageName'] as String;
      final initialParameterData = getInitialParameterData(message.data);
      final parametersBuilder = parametersBuilderMap[initialPageName];
      if (parametersBuilder != null) {
        final parameterData = await parametersBuilder(initialParameterData);
        context.pushNamed(
          initialPageName,
          pathParameters: parameterData.pathParameters,
          extra: parameterData.extra,
        );
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      safeSetState(() => _loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      handleOpenedPushNotification();
    });
  }

  @override
  Widget build(BuildContext context) => _loading
      ? Container(
          color: FlutterFlowTheme.of(context).primaryText,
          child: Center(
            child: Image.asset(
              'assets/images/GPI-Homes.png',
              width: MediaQuery.sizeOf(context).width * 0.8,
              fit: BoxFit.contain,
            ),
          ),
        )
      : widget.child;
}

class ParameterData {
  const ParameterData(
      {this.requiredParams = const {}, this.allParams = const {}});
  final Map<String, String?> requiredParams;
  final Map<String, dynamic> allParams;

  Map<String, String> get pathParameters => Map.fromEntries(
        requiredParams.entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
  Map<String, dynamic> get extra => Map.fromEntries(
        allParams.entries.where((e) => e.value != null),
      );

  static Future<ParameterData> Function(Map<String, dynamic>) none() =>
      (data) async => const ParameterData();
}

final parametersBuilderMap =
    <String, Future<ParameterData> Function(Map<String, dynamic>)>{
  'login': ParameterData.none(),
  'createAccount': ParameterData.none(),
  'homePage_MAIN': ParameterData.none(),
  'propertyDetails': (data) async => ParameterData(
        allParams: {
          'propertyRef': await getDocumentParameter<PropertiesRecord>(
              data, 'propertyRef', PropertiesRecord.fromSnapshot),
        },
      ),
  'searchProperties': (data) async => ParameterData(
        allParams: {
          'searchTerm': getParameter<String>(data, 'searchTerm'),
        },
      ),
  'myTrips': ParameterData.none(),
  'tripDetails': (data) async => ParameterData(
        allParams: {
          'propertyRef': await getDocumentParameter<PropertiesRecord>(
              data, 'propertyRef', PropertiesRecord.fromSnapshot),
          'tripRef': await getDocumentParameter<TripsRecord>(
              data, 'tripRef', TripsRecord.fromSnapshot),
        },
      ),
  'chatMain': ParameterData.none(),
  'chatDetails': (data) async => ParameterData(
        allParams: {
          'chatUser': await getDocumentParameter<UsersRecord>(
              data, 'chatUser', UsersRecord.fromSnapshot),
          'chatRef': getParameter<DocumentReference>(data, 'chatRef'),
        },
      ),
  'propertyReview': (data) async => ParameterData(
        allParams: {
          'propertyRef': await getDocumentParameter<PropertiesRecord>(
              data, 'propertyRef', PropertiesRecord.fromSnapshot),
        },
      ),
  'bookNow': (data) async => ParameterData(
        allParams: {
          'propertyDetails': await getDocumentParameter<PropertiesRecord>(
              data, 'propertyDetails', PropertiesRecord.fromSnapshot),
        },
      ),
  'profilePage': ParameterData.none(),
  'paymentInfo': ParameterData.none(),
  'editProfile': (data) async => ParameterData(
        allParams: {
          'userProfile': await getDocumentParameter<UsersRecord>(
              data, 'userProfile', UsersRecord.fromSnapshot),
        },
      ),
  'changePassword': (data) async => ParameterData(
        allParams: {
          'userProfile': await getDocumentParameter<UsersRecord>(
              data, 'userProfile', UsersRecord.fromSnapshot),
        },
      ),
  'createProperty_1': ParameterData.none(),
  'HomePage_ALT': ParameterData.none(),
  'createProperty_2': (data) async => ParameterData(
        allParams: {
          'propertyRef': await getDocumentParameter<PropertiesRecord>(
              data, 'propertyRef', PropertiesRecord.fromSnapshot),
          'propertyAmenities': await getDocumentParameter<AmenititiesRecord>(
              data, 'propertyAmenities', AmenititiesRecord.fromSnapshot),
        },
      ),
  'createProperty_3': (data) async => ParameterData(
        allParams: {
          'propertyRef': await getDocumentParameter<PropertiesRecord>(
              data, 'propertyRef', PropertiesRecord.fromSnapshot),
        },
      ),
  'myProperties': ParameterData.none(),
  'propertyDetails_Owner': (data) async => ParameterData(
        allParams: {
          'propertyRef': await getDocumentParameter<PropertiesRecord>(
              data, 'propertyRef', PropertiesRecord.fromSnapshot),
        },
      ),
  'myBookings': ParameterData.none(),
  'tripDetailsHOST': (data) async => ParameterData(
        allParams: {
          'propertyRef': await getDocumentParameter<PropertiesRecord>(
              data, 'propertyRef', PropertiesRecord.fromSnapshot),
          'tripRef': await getDocumentParameter<TripsRecord>(
              data, 'tripRef', TripsRecord.fromSnapshot),
        },
      ),
  'editProperty_1': (data) async => ParameterData(
        allParams: {
          'propertyRef': await getDocumentParameter<PropertiesRecord>(
              data, 'propertyRef', PropertiesRecord.fromSnapshot),
        },
      ),
  'editProperty_2': (data) async => ParameterData(
        allParams: {
          'propertyRef': await getDocumentParameter<PropertiesRecord>(
              data, 'propertyRef', PropertiesRecord.fromSnapshot),
          'propertyAmenities': await getDocumentParameter<AmenititiesRecord>(
              data, 'propertyAmenities', AmenititiesRecord.fromSnapshot),
        },
      ),
  'editProperty_3': (data) async => ParameterData(
        allParams: {
          'propertyRef': await getDocumentParameter<PropertiesRecord>(
              data, 'propertyRef', PropertiesRecord.fromSnapshot),
        },
      ),
  'asesorMenu': ParameterData.none(),
  'profile_pruebas': ParameterData.none(),
  'homePage_Comprar': ParameterData.none(),
  'homePage_Publicar': ParameterData.none(),
  'createProperty360': (data) async => ParameterData(
        allParams: {
          'idProperty': getParameter<String>(data, 'idProperty'),
        },
      ),
  'createProperty360Panos': (data) async => ParameterData(
        allParams: {
          'idProperty': getParameter<String>(data, 'idProperty'),
          'idVirtualTour': getParameter<String>(data, 'idVirtualTour'),
        },
      ),
  'createProperty360Dialog': (data) async => ParameterData(
        allParams: {
          'idProperty': getParameter<String>(data, 'idProperty'),
        },
      ),
  'createCalendarDate': (data) async => ParameterData(
        allParams: {
          'idProperty': getParameter<String>(data, 'idProperty'),
          'idUser': getParameter<String>(data, 'idUser'),
        },
      ),
  'createCalendarGpiTours': (data) async => ParameterData(
        allParams: {
          'idProperty': getParameter<String>(data, 'idProperty'),
        },
      ),
  'calendarUserCreate': (data) async => ParameterData(
        allParams: {
          'idProperty': getParameter<String>(data, 'idProperty'),
        },
      ),
  'calendarDisponibilidadUser': (data) async => ParameterData(
        allParams: {
          'idProperty': getParameter<String>(data, 'idProperty'),
        },
      ),
  'createProperty360DialogPerfil': (data) async => ParameterData(
        allParams: {
          'idProperty': getParameter<String>(data, 'idProperty'),
        },
      ),
  'createCalendarDateGPI': (data) async => ParameterData(
        allParams: {
          'idProperty': getParameter<String>(data, 'idProperty'),
          'idUser': getParameter<String>(data, 'idUser'),
        },
      ),
  'editProperty_3_GPI': (data) async => ParameterData(
        allParams: {
          'propertyRef': await getDocumentParameter<PropertiesRecord>(
              data, 'propertyRef', PropertiesRecord.fromSnapshot),
        },
      ),
  'homePage_Autorizate': ParameterData.none(),
  'propertyDetailsAtorize': (data) async => ParameterData(
        allParams: {
          'propertyRef': await getDocumentParameter<PropertiesRecord>(
              data, 'propertyRef', PropertiesRecord.fromSnapshot),
        },
      ),
  'aCrearNombrePano': (data) async => ParameterData(
        allParams: {
          'idProperty': getParameter<String>(data, 'idProperty'),
        },
      ),
  'aConsultarNombrePano': (data) async => ParameterData(
        allParams: {
          'idProperty': getParameter<String>(data, 'idProperty'),
        },
      ),
  'homePage_Favoritos': (data) async => const ParameterData(
        allParams: {},
      ),
};

Map<String, dynamic> getInitialParameterData(Map<String, dynamic> data) {
  try {
    final parameterDataStr = data['parameterData'];
    if (parameterDataStr == null ||
        parameterDataStr is! String ||
        parameterDataStr.isEmpty) {
      return {};
    }
    return jsonDecode(parameterDataStr) as Map<String, dynamic>;
  } catch (e) {
    print('Error parsing parameter data: $e');
    return {};
  }
}
