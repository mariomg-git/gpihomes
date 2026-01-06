import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'es'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? esText = '',
  }) =>
      [enText, esText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

/// Used if the locale is not supported by GlobalMaterialLocalizations.
class FallbackMaterialLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      SynchronousFuture<MaterialLocalizations>(
        const DefaultMaterialLocalizations(),
      );

  @override
  bool shouldReload(FallbackMaterialLocalizationDelegate old) => false;
}

/// Used if the locale is not supported by GlobalCupertinoLocalizations.
class FallbackCupertinoLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      SynchronousFuture<CupertinoLocalizations>(
        const DefaultCupertinoLocalizations(),
      );

  @override
  bool shouldReload(FallbackCupertinoLocalizationDelegate old) => false;
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

bool _isSupportedLocale(Locale locale) {
  final language = locale.toString();
  return FFLocalizations.languages().contains(
    language.endsWith('_')
        ? language.substring(0, language.length - 1)
        : language,
  );
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // login
  {
    'aq2e33xu': {
      'en': 'Welcome Back,',
      'es': 'Bienvenido de nuevo,',
    },
    '1ymostph': {
      'en': 'Email Address',
      'es': 'Dirección de correo electrónico',
    },
    'tkcrd0f7': {
      'en': 'Enter your email here...',
      'es': 'Introduzca su correo electrónico aquí...',
    },
    '148k5xwy': {
      'en': '',
      'es': '',
    },
    'z2ixtsuu': {
      'en': 'Password',
      'es': 'Contraseña',
    },
    'unp9r3y4': {
      'en': 'Enter your password here...',
      'es': 'Introduzca su contraseña aquí...',
    },
    'ce9lxqq1': {
      'en': '',
      'es': '',
    },
    'q48jvz5c': {
      'en': 'Forgot Password?',
      'es': '¿Has olvidado tu contraseña?',
    },
    'ib9ens87': {
      'en': 'Login',
      'es': 'Acceso',
    },
    'd48flnu6': {
      'en': 'Don\'t have an account?',
      'es': '¿No tienes una cuenta?',
    },
    'tca8bg2o': {
      'en': 'Create Account',
      'es': 'Crear una cuenta',
    },
    'q0th9xkn': {
      'en': 'Continue With Google',
      'es': 'Continua con Google',
    },
    '8k64a68l': {
      'en': 'Home',
      'es': 'Hogar',
    },
  },
  // createAccount
  {
    'l87k5rxi': {
      'en': 'Get Started Below,',
      'es': 'Comience a continuación,',
    },
    '08b6dvji': {
      'en': 'Email Address',
      'es': 'Dirección de correo electrónico',
    },
    'evz9qwy6': {
      'en': 'Enter your email here...',
      'es': 'Introduzca su correo electrónico aquí...',
    },
    '16463fof': {
      'en': 'Password',
      'es': 'Contraseña',
    },
    'mqmnikzo': {
      'en': 'Enter your email here...',
      'es': 'Introduzca su correo electrónico aquí...',
    },
    'ak4x6k2z': {
      'en': 'Create Account',
      'es': 'Crear una cuenta',
    },
    '1my9cxj8': {
      'en': 'Already have an account?',
      'es': '¿Ya tienes una cuenta?',
    },
    'lzbqgpoy': {
      'en': 'Login',
      'es': 'Acceso',
    },
    'btjndi2q': {
      'en': 'Home',
      'es': 'Hogar',
    },
  },
  // homePage_MAIN
  {
    'orqu6q11': {
      'en': 'Filters',
      'es': 'Filtros',
    },
    'jex417fd': {
      'en': 'Rating',
      'es': 'Clasificación',
    },
    'pc1xe8og': {
      'en': 'Rent',
      'es': 'Rentar',
    },
  },
  // propertyDetails
  {
    'qkr1aph3': {
      'en': '360 view',
      'es': 'Vista 360',
    },
    '09q407oz': {
      'en': 'Reviews',
      'es': 'Reseñas',
    },
    'q47r7obn': {
      'en': 'DESCRIPTION',
      'es': 'DESCRIPCIÓN',
    },
    'kom0tmll': {
      'en': 'Amenities',
      'es': 'Comodidades',
    },
    '7t98ku89': {
      'en': 'Available:',
      'es': 'Disponible a Partir de:',
    },
    'ejaihwtq': {
      'en': 'Rooms',
      'es': 'Habitaciones:',
    },
    'djzami7e': {
      'en': 'BathRooms:',
      'es': 'Baños:',
    },
    '14gxn1vt': {
      'en': 'Josh Richardson',
      'es': 'Jose Richardson',
    },
    'd8ak8nw4': {
      'en':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam...',
      'es':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam...',
    },
    'enlq98gb': {
      'en': 'Josh Richardson',
      'es': 'Jose Richardson',
    },
    'fs8cjt4j': {
      'en':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam...',
      'es':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam...',
    },
    '5kvysfsb': {
      'en': 'Next',
      'es': 'Continuar',
    },
    'ccft9517': {
      'en': 'Home',
      'es': 'Hogar',
    },
  },
  // searchProperties
  {
    'dtc1gakb': {
      'en': 'Search',
      'es': 'Buscar',
    },
    'u8d0e5tv': {
      'en': 'Address, city, state...',
      'es': 'Dirección, ciudad, estado...',
    },
    'mew9burf': {
      'en': 'Search',
      'es': 'Buscar',
    },
    'eqllwd2p': {
      'en': 'Rating',
      'es': 'Clasificación',
    },
    '6pljzs87': {
      'en': 'Home',
      'es': 'Hogar',
    },
  },
  // myTrips
  {
    'irlhzld4': {
      'en': 'Upcoming',
      'es': 'Próximo',
    },
    '54lo3hte': {
      'en': ' - ',
      'es': '-',
    },
    'xs58p2qa': {
      'en': 'Total',
      'es': 'Total',
    },
    'wocoo376': {
      'en': 'Completed',
      'es': 'Terminado',
    },
    'wt4cetep': {
      'en': 'Cancelled',
      'es': 'Cancelado',
    },
    '8wxljfcf': {
      'en': ' - ',
      'es': '-',
    },
    'badwlnmu': {
      'en': 'Rate Trip',
      'es': 'Calificar viaje',
    },
    'zvo2d7qt': {
      'en': 'My Trips',
      'es': 'Mis viajes',
    },
    'st9o7itr': {
      'en': 'My Trips',
      'es': 'Mis viajes',
    },
  },
  // tripDetails
  {
    'p1yvzyw8': {
      'en': 'Trip Details',
      'es': 'Detalles del viaje',
    },
    '2zcqi669': {
      'en': 'Dates of trip',
      'es': 'fechas de viaje',
    },
    't5s83i7g': {
      'en': 'Home on Beachront',
      'es': '',
    },
    'edfzfv7f': {
      'en': 'Home on Beachront',
      'es': '',
    },
    'zh445a0k': {
      'en': 'Destination',
      'es': 'Destino',
    },
    '8xvrm2r1': {
      'en': 'Price Breakdown',
      'es': 'Caída de precios',
    },
    '6z5l153k': {
      'en': 'Base Price',
      'es': 'Precio base',
    },
    'lke7ofqz': {
      'en': 'Taxes',
      'es': 'Impuestos',
    },
    '4ivtoelr': {
      'en': '\$24.20',
      'es': '\$24.20',
    },
    '5hfgy6zi': {
      'en': 'Cleaning Fee',
      'es': 'Tarifa de limpieza',
    },
    '71f0svmb': {
      'en': '\$40.00',
      'es': '\$40.00',
    },
    '7dit07x3': {
      'en': 'Total',
      'es': 'Total',
    },
    'm0wvxjzp': {
      'en': 'Your trip has been completed!',
      'es': '¡Tu viaje ha sido completado!',
    },
    'jkiey2e4': {
      'en': 'Review Trip',
      'es': 'Revisar viaje',
    },
    'eg8iu2wa': {
      'en': 'Host Info',
      'es': 'Información del anfitrión',
    },
    'fhgadv40': {
      'en': 'Chat',
      'es': 'Charlar',
    },
    'wfmv934l': {
      'en': 'Home',
      'es': 'Hogar',
    },
  },
  // chatMain
  {
    'owavh5cp': {
      'en': 'Back',
      'es': '',
    },
    'gnmz5vs2': {
      'en': 'All Chats',
      'es': 'Todos los chats',
    },
    '90udp0d6': {
      'en': 'Chats',
      'es': 'Chat',
    },
  },
  // chatDetails
  {
    'tbx9b10r': {
      'en': 'Home',
      'es': 'Hogar',
    },
  },
  // propertyReview
  {
    'iczejxco': {
      'en': 'Reviews',
      'es': 'Reseñas',
    },
    'irl5yevd': {
      'en': '# of Ratings',
      'es': '# de calificaciones',
    },
    'jzdj4iyr': {
      'en': 'Avg. Rating',
      'es': 'Promedio Clasificación',
    },
    'csw6smu0': {
      'en': 'Home',
      'es': 'Hogar',
    },
  },
  // bookNow
  {
    'gpljfamq': {
      'en': 'Book Now',
      'es': 'Reservar ahora',
    },
    '4s02fgee': {
      'en': 'Choose Dates',
      'es': 'Elige ',
    },
    '1hbr9675': {
      'en': 'Booking Date',
      'es': 'Fecha Tentativa Inicio Contrato',
    },
    'yryxg8aq': {
      'en': 'Choose an Option',
      'es': 'Elige una opcion',
    },
    'lwdfe4r4': {
      'en': 'Breakfast',
      'es': 'Desayuno',
    },
    'byxlxe7q': {
      'en': 'No Breakfast',
      'es': 'No hay desayuno',
    },
    'rq2udjek': {
      'en': 'Hot Tub Access',
      'es': 'Acceso al jacuzzi',
    },
    'i1si04dx': {
      'en': 'No Access',
      'es': 'Sin acceso',
    },
    'kzzfgqsg': {
      'en': 'Payment Information',
      'es': 'Información del pago',
    },
    'uczr3f7w': {
      'en': 'Base Price',
      'es': 'Precio base',
    },
    'amn823a8': {
      'en': '\$156.00',
      'es': '\$156.00',
    },
    'y4e7r9ff': {
      'en': 'Taxes',
      'es': 'Impuestos',
    },
    'j1xlz4up': {
      'en': '\$24.20',
      'es': '\$24.20',
    },
    'ycbi2m4f': {
      'en': 'Cleaning Fee',
      'es': 'Tarifa de limpieza',
    },
    'pky27ayo': {
      'en': '\$40.00',
      'es': '\$40.00',
    },
    'h15b4fju': {
      'en': 'Total',
      'es': 'Total',
    },
    'bzvgdc3x': {
      'en': '\$230.20',
      'es': '\$230.20',
    },
    'r1tn850e': {
      'en': 'Book Now',
      'es': 'Reservar ahora',
    },
    'hknelz6a': {
      'en': 'Home',
      'es': 'Hogar',
    },
  },
  // profilePage
  {
    'ypolyzi1': {
      'en': 'Menu Asesor',
      'es': 'Menú Asesor',
    },
    'i0gowm7t': {
      'en': 'Add 360 Virtual tour',
      'es': 'Agregar Tour Virtual 360',
    },
    'bgnlbhsg': {
      'en': 'Edit Profile',
      'es': 'Editar perfil',
    },
    '92aizswo': {
      'en': 'Payment Information',
      'es': 'Información del pago',
    },
    '66uqfku3': {
      'en': 'My Bookmarks',
      'es': 'Mis Favoritos',
    },
    'n44e9et7': {
      'en': 'Change Password',
      'es': 'Cambiar Password',
    },
    'tubcsctu': {
      'en': 'My Properties',
      'es': 'Mis Propiedades',
    },
    'b89l93yb': {
      'en': 'Chat',
      'es': 'Chat',
    },
    'aqxq5byc': {
      'en': 'Log Out',
      'es': 'Cerrar sesión',
    },
    'ihyid5uw': {
      'en': 'Profile',
      'es': 'Perfil',
    },
  },
  // paymentInfo
  {
    '45pt4uic': {
      'en': 'Save Changes',
      'es': 'Guardar cambios',
    },
    'nwf6xeam': {
      'en': 'Payment Information',
      'es': 'Información del pago',
    },
    'idhh0kyl': {
      'en': 'Home',
      'es': 'Hogar',
    },
  },
  // editProfile
  {
    'xw14wga8': {
      'en': 'Edit Profile',
      'es': 'Editar perfil',
    },
    'eu42cwfp': {
      'en': 'Change Photo',
      'es': 'Cambiar foto',
    },
    'pzgwlnf0': {
      'en': 'Full Name',
      'es': 'Nombre completo',
    },
    '2u5sgqfh': {
      'en': 'Your full name...',
      'es': 'Tu nombre completo...',
    },
    'x8x891a2': {
      'en': 'Email Address',
      'es': 'Dirección de correo electrónico',
    },
    'f94olveq': {
      'en': 'Your email..',
      'es': 'Tu correo electrónico..',
    },
    'bxcf7aj4': {
      'en': 'Bio',
      'es': 'Biografía',
    },
    '4p3h5loe': {
      'en': 'A little about you...',
      'es': 'Un poco sobre ti...',
    },
    'hbn74z4s': {
      'en': 'Save Changes',
      'es': 'Guardar cambios',
    },
    'bptssppm': {
      'en': 'Home',
      'es': 'Hogar',
    },
  },
  // changePassword
  {
    'n5p5fb3b': {
      'en': 'Email Address',
      'es': 'Dirección de correo electrónico',
    },
    'panrzlai': {
      'en': 'Your email..',
      'es': 'Tu correo electrónico..',
    },
    'fjiai871': {
      'en':
          'We will send you an email with a link to reset your password, please enter the email associated with your account above.',
      'es':
          'Le enviaremos un correo electrónico con un enlace para restablecer su contraseña; ingrese el correo electrónico asociado con su cuenta arriba.',
    },
    'bqfjmjfx': {
      'en': 'Send Reset Link',
      'es': 'Enviar enlace de reinicio',
    },
    'cadegtmm': {
      'en': 'Change Password',
      'es': 'Cambiar la contraseña',
    },
    'amat2i7d': {
      'en': 'Home',
      'es': 'Hogar',
    },
  },
  // createProperty_1
  {
    'htmx9q8t': {
      'en': 'Create Property',
      'es': 'Crear propiedad',
    },
    'b90ov91u': {
      'en': 'ADD LOCATION IN THE MAP :',
      'es': 'AGREGA LA UBICACIÓN DEL INMUEBLE EN EL SIG MAPA:',
    },
    '9wau4n0a': {
      'en': 'ADD COVER IMAGE :',
      'es': '',
    },
    '87da8r3q': {
      'en': 'Add Image',
      'es': 'Agrega Imagen',
    },
    'ummc3a35': {
      'en': 'PROPERTIE NAME',
      'es': 'NOMBRE PROPIEDAD',
    },
    'm521o3k7': {
      'en': 'Something Catchy...',
      'es': 'Ponle un Nombre a la Propiedad...',
    },
    'xq5b0hj6': {
      'en': 'STREET',
      'es': 'CALLE',
    },
    '3kdjgthc': {
      'en': 'STREET',
      'es': '',
    },
    'dpvhl1mg': {
      'en': 'Street…',
      'es': 'Calle...',
    },
    'hriv7c9b': {
      'en': 'NUMBER',
      'es': 'NUMERO EXT & INT',
    },
    'ftmuwrlk': {
      'en': 'Number ext & int…',
      'es': 'Numero Ext & Int..',
    },
    'zih3p9he': {
      'en': 'NEIGHBORHOOD',
      'es': 'MUNICIPIO',
    },
    'd8q42bs6': {
      'en': 'Neighborhood…',
      'es': 'Delegacion o Municipio…',
    },
    '7de7fx5c': {
      'en': 'CITY',
      'es': 'CIUDAD',
    },
    'qluxiuqo': {
      'en': ' City…',
      'es': 'Ciudad…',
    },
    'ommdwyd1': {
      'en': 'STATE',
      'es': 'ESTADO',
    },
    'k8uknldw': {
      'en': ' State…',
      'es': 'Estado…',
    },
    'o7se6vfi': {
      'en': 'ZIP CODE',
      'es': 'CODIGO POSTAL',
    },
    '5zdpn8bo': {
      'en': ' Zip Code…',
      'es': 'Código Postal…',
    },
    '5om0it05': {
      'en': 'DESCRIPTION',
      'es': 'DESCRIPCIÓN',
    },
    '1o9k66qq': {
      'en': 'Description…',
      'es': 'Descripcion…',
    },
    'cvy0n1wj': {
      'en': 'STEP',
      'es': 'PASO',
    },
    'xtu7lnqn': {
      'en': '1/3',
      'es': '1/3',
    },
    '88wnhyyi': {
      'en': 'NEXT',
      'es': 'PRÓXIMO',
    },
    '1djl64fp': {
      'en': 'Field is required',
      'es': 'Se requiere campo',
    },
    'kppx7uwm': {
      'en': 'Please choose an option from the dropdown',
      'es': '',
    },
    '10aii9x7': {
      'en': 'Field is required',
      'es': 'Se requiere campo',
    },
    '865ob2gp': {
      'en': 'Please choose an option from the dropdown',
      'es': '',
    },
    'oe3ye8yv': {
      'en': 'Field is required',
      'es': '',
    },
    'gap0i36q': {
      'en': 'Please choose an option from the dropdown',
      'es': '',
    },
    'qk512n4k': {
      'en': 'Field is required',
      'es': 'Se requiere campo',
    },
    'hl311zug': {
      'en': 'Please choose an option from the dropdown',
      'es': '',
    },
    'obam3jjc': {
      'en': 'Field is required',
      'es': 'Se requiere campo',
    },
    'dg8r8td0': {
      'en': 'Please choose an option from the dropdown',
      'es': '',
    },
    'qs6nzyqy': {
      'en': 'Field is required',
      'es': 'Se requiere campo',
    },
    'o4g1u76u': {
      'en': 'Please choose an option from the dropdown',
      'es': '',
    },
    'l205gmu2': {
      'en': 'Field is required',
      'es': 'Se requiere campo',
    },
    'ucqrk941': {
      'en': 'Please choose an option from the dropdown',
      'es': '',
    },
    'z33zu48g': {
      'en': 'Field is required',
      'es': 'Se requiere campo',
    },
    'wasdp4h2': {
      'en': 'Please choose an option from the dropdown',
      'es': '',
    },
    '9a7tta6i': {
      'en': 'Home',
      'es': 'Hogar',
    },
  },
  // HomePage_ALT
  {
    '4f8s39xu': {
      'en': 'Welcome!',
      'es': '¡Bienvenido!',
    },
    '05zm4joy': {
      'en': 'Find your Dream Space',
      'es': 'Encuentra el espacio de tus sueños',
    },
    'lmkaw7xx': {
      'en': 'Address, city, state...',
      'es': 'Dirección, ciudad, estado...',
    },
    '7g6iell8': {
      'en': 'Search',
      'es': 'Buscar',
    },
    'tcfj8io4': {
      'en': '4/5 reviews',
      'es': '4/5 opiniones',
    },
    'm036oj9r': {
      'en': 'Home',
      'es': 'Hogar',
    },
  },
  // createProperty_2
  {
    'yxs8b0x3': {
      'en': 'Create Property',
      'es': 'Crear propiedad',
    },
    'cfolpjkd': {
      'en': 'CHOOSE YOUR AMENITIES',
      'es': 'ELIGE TUS AMENIDADES',
    },
    'vjuno670': {
      'en': 'Pool',
      'es': 'Piscina',
    },
    'bhw032kl': {
      'en': 'EV Car Charging',
      'es': 'Carga de vehículos eléctricos',
    },
    'wcr7zdtp': {
      'en': 'Air Conditioning (AC)',
      'es': 'Aire acondicionado (AC)',
    },
    '7w1851gr': {
      'en': 'Heating',
      'es': 'Calefacción',
    },
    'dfkmk8n6': {
      'en': 'Washer',
      'es': 'Lavadora',
    },
    'tmirq250': {
      'en': 'Dryer',
      'es': 'Secadora',
    },
    'eviayn1r': {
      'en': 'Pet Friendly',
      'es': 'Permite Mascotas ',
    },
    'hu1bytza': {
      'en': 'Workout Facility',
      'es': 'Instalaciones de entrenamiento',
    },
    'j964aodn': {
      'en': 'STEP',
      'es': 'PASO',
    },
    'mbsv29zw': {
      'en': '2/3',
      'es': '2/3',
    },
    '5lojo25o': {
      'en': 'NEXT',
      'es': 'PRÓXIMO',
    },
    'gpeug4hv': {
      'en': 'Home',
      'es': 'Hogar',
    },
  },
  // createProperty_3
  {
    'mqyl5x4f': {
      'en': 'Create Property',
      'es': 'Crear propiedad',
    },
    'l5iy4zxb': {
      'en': 'BEDROOMS',
      'es': 'RECAMARAS',
    },
    'c2p0jp20': {
      'en': 'BATHROOMS',
      'es': 'BAÑOS',
    },
    't6pjbgf8': {
      'en': 'PRICE ',
      'es': 'PRECIO ',
    },
    'v4l8aegl': {
      'en': '\$',
      'es': '\$',
    },
    'm3rz8ldl': {
      'en': '00.00',
      'es': '00.00',
    },
    'u0ylvruj': {
      'en': '',
      'es': '',
    },
    'ch2n2ojo': {
      'en': 'CONTACT PHONE',
      'es': 'TEL DE CONTACTO',
    },
    'zw4w8tj7': {
      'en': '# Phone',
      'es': '# Telefono',
    },
    '7vzhvupa': {
      'en': '',
      'es': '',
    },
    '554sp2xr': {
      'en': 'DATE PROPERTY AVAILABILITY:',
      'es': 'FECHA DISPONIBLE INMUEBLE:',
    },
    'nkyuqrc6': {
      'en': 'CONTACT TYPE',
      'es': 'TIPO DE CONTACTO',
    },
    '2k4vawso': {
      'en': 'Propietario',
      'es': 'Propietario',
    },
    'gt3fg7v9': {
      'en': 'Agente Inmobiliario',
      'es': 'Agente Inmobiliario',
    },
    '8u0twbob': {
      'en': 'Please select...',
      'es': 'Por favor seleccione...',
    },
    '2gt874a0': {
      'en': 'Search for an item...',
      'es': '',
    },
    'n9is0pz5': {
      'en': 'PROPERTY TYPE',
      'es': 'TIPO DE PROPIEDAD',
    },
    'djacudh9': {
      'en': 'Renta',
      'es': 'Renta',
    },
    '4lxpj196': {
      'en': 'Venta',
      'es': 'Venta',
    },
    '5pivy89m': {
      'en': 'Please select...',
      'es': 'Por favor seleccione...',
    },
    'klg0oz2t': {
      'en': 'Search for an item...',
      'es': '',
    },
    'etm9vhmg': {
      'en': 'ADD MORE IMAGES',
      'es': 'AGREGAR MAS IMAGENES:',
    },
    'z8xk5fhk': {
      'en': 'Additional Notes',
      'es': 'Notas adicionales',
    },
    'j61fcpae': {
      'en': 'Additional notes...',
      'es': 'Notas adicionales...',
    },
    'clejnpt9': {
      'en': 'STEP',
      'es': 'PASO',
    },
    'inxsy3zr': {
      'en': '3/3',
      'es': '3/3',
    },
    'ry1ag78p': {
      'en': 'PUBLISH',
      'es': 'PUBLICAR',
    },
    '23el320c': {
      'en': 'Field is required',
      'es': '',
    },
    'f6fi0mnc': {
      'en': 'Please choose an option from the dropdown',
      'es': '',
    },
    'ht7oiztr': {
      'en': 'Field is required',
      'es': '',
    },
    'klpernub': {
      'en': 'Please choose an option from the dropdown',
      'es': '',
    },
    'himp6091': {
      'en': 'Field is required',
      'es': '',
    },
    '8k5pfpn5': {
      'en': 'Please choose an option from the dropdown',
      'es': '',
    },
    '0jiv72bu': {
      'en': 'Home',
      'es': 'Hogar',
    },
  },
  // myProperties
  {
    '2yce1etj': {
      'en': 'Published',
      'es': 'Publicado',
    },
    'mbrw98ye': {
      'en': 'Price Per Night',
      'es': 'Precio por noche',
    },
    '1d6iy19y': {
      'en': 'Drafts',
      'es': 'Borradores',
    },
    'kcquik1w': {
      'en': 'Price Per Night',
      'es': 'Precio por noche',
    },
    'nxuyj56y': {
      'en': 'My Properties',
      'es': 'Mis Propiedades',
    },
    'uqfvvmz7': {
      'en': 'My Trips',
      'es': 'Mis viajes',
    },
  },
  // propertyDetails_Owner
  {
    'rj1762k3': {
      'en': 'Reviews',
      'es': 'Reseñas',
    },
    '3mkiionq': {
      'en': 'DESCRIPTION',
      'es': 'DESCRIPCIÓN',
    },
    '6q63fsd8': {
      'en': 'Amenities',
      'es': 'Comodidades',
    },
    'zgs05rxn': {
      'en': 'What people are saying',
      'es': 'Lo que la gente esta diciendo',
    },
    'ocbcu0vc': {
      'en': 'Josh Richardson',
      'es': 'Jose Richardson',
    },
    'eoqxk6ur': {
      'en':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam...',
      'es':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam...',
    },
    'utezim5a': {
      'en': 'Josh Richardson',
      'es': 'Jose Richardson',
    },
    'l74nyxp7': {
      'en':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam...',
      'es':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam...',
    },
    'do0iwgfv': {
      'en': '\$156',
      'es': '\$156',
    },
    '15j9v1sj': {
      'en': '+ taxes/fees',
      'es': '+ impuestos/tarifas',
    },
    'gurzj359': {
      'en': 'per night',
      'es': 'por noche',
    },
    '1468ncv3': {
      'en': 'Edit Property',
      'es': 'Editar propiedad',
    },
    'xzvgu2nc': {
      'en': 'Home',
      'es': 'Hogar',
    },
  },
  // myBookings
  {
    'dt98rsfz': {
      'en': 'Upcoming ',
      'es': 'Próximo',
    },
    '0ayhh4c5': {
      'en': ' - ',
      'es': '-',
    },
    'mexorwgq': {
      'en': 'Total',
      'es': 'Total',
    },
    '2k5mss3l': {
      'en': 'Completed',
      'es': 'Terminado',
    },
    '2s0cj0sn': {
      'en': ' - ',
      'es': '-',
    },
    'imu0d7xv': {
      'en': 'Total',
      'es': 'Total',
    },
    'ku4sy8tb': {
      'en': 'My Bookings',
      'es': 'Mis Reservas',
    },
    '57hh3nyn': {
      'en': 'My Trips',
      'es': 'Mis viajes',
    },
  },
  // tripDetailsHOST
  {
    '7sbliwz9': {
      'en': 'Trip Details',
      'es': 'Detalles del viaje',
    },
    'a43ajk9r': {
      'en': 'Dates of trip',
      'es': 'fechas de viaje',
    },
    'djn01g6g': {
      'en': ' - ',
      'es': '-',
    },
    '40zdrv7e': {
      'en': 'Destination',
      'es': 'Destino',
    },
    'vnx466vy': {
      'en': 'Price Breakdown',
      'es': 'Caída de precios',
    },
    'pri47own': {
      'en': 'Base Price',
      'es': 'Precio base',
    },
    'e8ieyeai': {
      'en': 'Taxes',
      'es': 'Impuestos',
    },
    'kv1lm9j6': {
      'en': '\$24.20',
      'es': '\$24.20',
    },
    'vah7tak3': {
      'en': 'Cleaning Fee',
      'es': 'Tarifa de limpieza',
    },
    '1fqr39aj': {
      'en': '\$40.00',
      'es': '\$40.00',
    },
    '9xvf73gj': {
      'en': 'Total',
      'es': 'Total',
    },
    'y22c88cw': {
      'en': 'Mark this trip as complete below.',
      'es': 'Marque este viaje como completo a continuación.',
    },
    '9blvn675': {
      'en': 'Mark as Complete',
      'es': 'Marcar como completo',
    },
    'k9znqgaa': {
      'en': 'Guest Info',
      'es': 'Información del huésped',
    },
    'qwoxe2sk': {
      'en': 'Chat',
      'es': 'Charlar',
    },
    'rg0jfik9': {
      'en': 'Home',
      'es': 'Hogar',
    },
  },
  // editProperty_1
  {
    'btetdp86': {
      'en': 'Edit Property',
      'es': 'Editar propiedad',
    },
    '2ag7gv89': {
      'en': 'PROPERTY NAME',
      'es': 'NOMBRE DE LA PROPIEDAD',
    },
    'w8p07g6o': {
      'en': 'Something Catchy...',
      'es': 'Algo pegadizo...',
    },
    '5rakdsi5': {
      'en': 'PROPERTY ADDRESS',
      'es': 'DIRECCIÓN DE PROPIEDAD',
    },
    '0zpb5yna': {
      'en': '123 Disney way here…',
      'es': '123 Disney camino hasta aquí...',
    },
    'bqphtd5m': {
      'en': 'NEIGHBORHOOD',
      'es': 'VECINDARIO',
    },
    'y5bd2s7d': {
      'en': 'Neighborhood or city…',
      'es': 'Barrio o ciudad…',
    },
    '2b5gdq6a': {
      'en': 'DESCRIPTION',
      'es': 'DESCRIPCIÓN',
    },
    'xh9loelk': {
      'en': 'Neighborhood or city…',
      'es': 'Barrio o ciudad…',
    },
    'et4yrrua': {
      'en': 'STEP',
      'es': 'PASO',
    },
    'j6fefa95': {
      'en': '1/3',
      'es': '1/3',
    },
    '9j9u59bi': {
      'en': 'NEXT',
      'es': 'PRÓXIMO',
    },
    '3cbnqsi0': {
      'en': 'We need to know the name of the place...',
      'es': 'Necesitamos saber el nombre del lugar...',
    },
    'nowxrq4h': {
      'en': 'Home',
      'es': 'Hogar',
    },
  },
  // editProperty_2
  {
    'fh3juznt': {
      'en': 'Edit Property',
      'es': 'Editar propiedad',
    },
    'p9q7ljoy': {
      'en': 'CHOOSE YOUR AMENITIES',
      'es': 'ELIGE TUS AMENIDADES',
    },
    'ypqjfjhu': {
      'en': 'Pool',
      'es': 'Piscina',
    },
    '7jkuevjs': {
      'en': 'EV Car Charging',
      'es': 'Carga de vehículos eléctricos',
    },
    '6kuo29zx': {
      'en': 'Extra Outlets',
      'es': 'Puntos de venta adicionales',
    },
    'suvb4sek': {
      'en': 'Air Conditioning (AC)',
      'es': 'Aire acondicionado (AC)',
    },
    'd0tbjzxp': {
      'en': 'Heating',
      'es': 'Calefacción',
    },
    'j8c1bu25': {
      'en': 'Washer',
      'es': 'Lavadora',
    },
    '8b0w3w4n': {
      'en': 'Dryer',
      'es': 'Secadora',
    },
    'u576osk4': {
      'en': 'Pet Friendly',
      'es': 'Mascota amigable',
    },
    '4fkqg7hp': {
      'en': 'Workout Facility',
      'es': 'Instalaciones de entrenamiento',
    },
    'q86g62dg': {
      'en': 'Hip',
      'es': 'Cadera',
    },
    'q4za4o4p': {
      'en': 'Night Life',
      'es': 'La vida nocturna',
    },
    '17orm4mc': {
      'en': 'STEP',
      'es': 'PASO',
    },
    'akj5hylw': {
      'en': '2/3',
      'es': '2/3',
    },
    '6s7f57jb': {
      'en': 'NEXT',
      'es': 'PRÓXIMO',
    },
    'xqdtr0mq': {
      'en': 'Home',
      'es': 'Hogar',
    },
  },
  // editProperty_3
  {
    'ekc4lc4x': {
      'en': 'Edit Property',
      'es': 'Editar propiedad',
    },
    'ui2rgva5': {
      'en': 'PRICE PER NIGHT',
      'es': 'PRECIO POR NOCHE',
    },
    '7y5xrtcc': {
      'en': '\$ Price',
      'es': '\$ Precio',
    },
    'gogo7nod': {
      'en': 'MINIMUM NIGHT STAY',
      'es': 'ESTANCIA MÍNIMA DE NOCHES',
    },
    'j9230nzc': {
      'en': 'TAX RATE',
      'es': 'TASA DE IMPUESTO',
    },
    'gdh4ljbj': {
      'en': '% Rate',
      'es': '% Tasa',
    },
    'esab6hp6': {
      'en': 'CLEANING FEE',
      'es': 'TARIFA DE LIMPIEZA',
    },
    '8z4est85': {
      'en': '\$ Price',
      'es': '\$ Precio',
    },
    '6kp3j8aw': {
      'en': 'Additional Notes',
      'es': 'Notas adicionales',
    },
    '9cmaggml': {
      'en': 'Additional notes...',
      'es': 'Notas adicionales...',
    },
    'jnwyw4f8': {
      'en': 'Listing is Live',
      'es': 'El listado está activo',
    },
    '4aiiz5vw': {
      'en': 'Turn this on for guests to start booking your listing.',
      'es':
          'Activa esta opción para que los huéspedes comiencen a reservar tu anuncio.',
    },
    'rf2qoe08': {
      'en': 'STEP',
      'es': 'PASO',
    },
    'feh36f4a': {
      'en': '3/3',
      'es': '3/3',
    },
    'd7zfxsl5': {
      'en': 'Save Changes',
      'es': 'Guardar cambios',
    },
    'pjtd9htr': {
      'en': 'Home',
      'es': 'Hogar',
    },
  },
  // asesorMenu
  {
    'nexjm9q9': {
      'en': 'Options',
      'es': 'Opciones',
    },
    '9cwx3qoe': {
      'en': 'Tours GPI Dating',
      'es': 'Tours GPI Pendientes',
    },
    '2e8ln3rr': {
      'en': 'CalendarTourWidget',
      'es': 'CalendarTourWidget',
    },
    '0p2ru495': {
      'en': 'My datings',
      'es': 'Mis Visitas',
    },
    'ce70pwzl': {
      'en': 'Date Gpi Tour',
      'es': 'Agendar Gpi Tour',
    },
    '20jsbnud': {
      'en': 'CalendarDisponibilidad',
      'es': 'CalendarDisponibilidad',
    },
    '0r8ou9kh': {
      'en': 'Date User Visit',
      'es': 'Agendar Visita Usuario',
    },
    'zaw9x3o9': {
      'en': 'GPI Visitas Pendientes',
      'es': 'GPI Visitas Pendientes',
    },
    '6isenrbp': {
      'en': 'CalendarDisponibilidadGPI',
      'es': 'CalendarDisponibilidadGPI',
    },
    'gqsh2l7o': {
      'en': 'Check',
      'es': 'Aprobar',
    },
    'rbkxk1wm': {
      'en': '...',
      'es': '...',
    },
    '6qnucy6i': {
      'en': '...',
      'es': '...',
    },
    'f3fjlzeu': {
      'en': 'Menu',
      'es': 'Menu',
    },
    'xjpxsi8r': {
      'en': 'Home',
      'es': 'Hogar',
    },
  },
  // profile_pruebas
  {
    'sqhebrqg': {
      'en': 'Profile',
      'es': 'Perfil',
    },
  },
  // homePage_Comprar
  {
    'np6lqj45': {
      'en': 'Welcome!',
      'es': '¡Bienvenido!',
    },
    'lrxcya1k': {
      'en': 'Find your Dream Space ',
      'es': 'Encuentra el espacio de tus sueños',
    },
    '5abwwi9y': {
      'en': 'Rating',
      'es': 'Clasificación',
    },
    'begxdg5m': {
      'en': 'Buy',
      'es': 'Comprar',
    },
  },
  // homePage_Publicar
  {
    '1s2q0j7g': {
      'en': 'Welcome!',
      'es': '¡Bienvenido!',
    },
    'u71lugq4': {
      'en': 'Find your Dream Space ',
      'es': 'Encuentra el espacio de tus sueños',
    },
    'odcn6twf': {
      'en': 'Publish Propertie',
      'es': 'Publicar Propiedad',
    },
    'sm6qo734': {
      'en': 'Publish',
      'es': 'Publicar',
    },
  },
  // createProperty360
  {
    'r89djfn5': {
      'en': 'Next',
      'es': 'Continuar',
    },
    'jeq5qdoy': {
      'en': 'Publish',
      'es': 'Publicar',
    },
  },
  // createProperty360Panos
  {
    '088zd5nf': {
      'en': 'Finish',
      'es': 'Terminar',
    },
    '8ithv7he': {
      'en': 'Publish',
      'es': 'Publicar',
    },
  },
  // createProperty360Dialog
  {
    '6tzohz2z': {
      'en': 'Welcome!',
      'es': '¡Bienvenido!',
    },
    'dhylgcep': {
      'en': 'Find your Dream Space ',
      'es': 'Encuentra el espacio de tus sueños',
    },
    'l4og44xw': {
      'en': 'Generate 360 Virtual Tour',
      'es': 'Crear Tour Virtual 360',
    },
    '7j9vbq13': {
      'en': 'I Dont Have 360 Cam...',
      'es': 'No tengo Camara 360...',
    },
    'n1wmj5ug': {
      'en': 'Schedule a visit for us to bring the Camera',
      'es': 'Agenda una visita para nosotros llevar la Camara ',
    },
    '8jo02tfi': {
      'en': 'Other Time...',
      'es': 'En otro momento...',
    },
    '3i3h35kq': {
      'en': 'You can add after in \'My Profile\'',
      'es': 'Vista 360',
    },
    '1jblzor0': {
      'en': 'Publish',
      'es': 'Publicar',
    },
  },
  // createCalendarDate
  {
    'rovtghe9': {
      'en': 'Finish',
      'es': 'Terminar',
    },
    'wt2kdg7c': {
      'en': 'Publish',
      'es': 'Publicar',
    },
  },
  // createCalendarGpiTours
  {
    'erld4vlh': {
      'en': 'Finish',
      'es': 'Terminar',
    },
    'zl4q2ami': {
      'en': 'Publish',
      'es': 'Publicar',
    },
  },
  // calendarUserCreate
  {
    'nxrfcpcq': {
      'en': 'Finish',
      'es': 'Terminar',
    },
    'b26j5w5t': {
      'en': 'Publish',
      'es': 'Publicar',
    },
  },
  // calendarDisponibilidadUser
  {
    '7cc7t3me': {
      'en': 'Finish',
      'es': 'Terminar',
    },
    'kqlftycn': {
      'en': 'Publish',
      'es': 'Publicar',
    },
  },
  // createProperty360DialogPerfil
  {
    'h39uzind': {
      'en': 'Welcome!',
      'es': '¡Bienvenido!',
    },
    'bd1z0k8s': {
      'en': 'Find your Dream Space ',
      'es': 'Encuentra el espacio de tus sueños',
    },
    'cvk1ria3': {
      'en': 'Generate 360 Virtual Tour',
      'es': 'Crear Tour Virtual 360',
    },
    'dzaua64a': {
      'en': 'I Dont Have 360 Cam...',
      'es': 'No tengo Camara 360...',
    },
    'x7l9qfti': {
      'en': 'Schedule a visit for us to bring the Camera',
      'es': 'Agenda una visita para nosotros llevar la Camara ',
    },
    'aa85s48k': {
      'en': 'Other Time...',
      'es': 'En otro momento...',
    },
    '6mzflgtc': {
      'en': 'You can add after in \'My Profile\'',
      'es': 'Puedes agregarlo despues en \'Mi Perfil\'',
    },
    'd3oh72se': {
      'en': 'Publish',
      'es': 'Publicar',
    },
  },
  // createCalendarDateGPI
  {
    'juwq0bob': {
      'en': 'Finish',
      'es': 'Terminar',
    },
    '5qlhb5b5': {
      'en': 'Publish',
      'es': 'Publicar',
    },
  },
  // editProperty_3_GPI
  {
    '08zfa6a0': {
      'en': 'Create Property',
      'es': 'Crear propiedad',
    },
    '2xv29xbi': {
      'en': 'PRICE ',
      'es': 'PRECIO ',
    },
    'lfzcbbgh': {
      'en': '\$ Price',
      'es': '\$ Precio',
    },
    'jrbxzmzq': {
      'en': '',
      'es': '',
    },
    'z95q0mbt': {
      'en': 'CONTACT PHONE',
      'es': 'TEL DE CONTACTO',
    },
    'igjphn4n': {
      'en': '# Phone',
      'es': '# Telefono',
    },
    '60r3ykx2': {
      'en': '',
      'es': '',
    },
    '877mlv4k': {
      'en': 'CONTACT TYPE',
      'es': 'TIPO DE CONTACTO',
    },
    '3rex0l26': {
      'en': 'OWNER',
      'es': 'PROPIETARIO',
    },
    '8v55xfzc': {
      'en': ' REAL STATE SELLER',
      'es': 'AGENTE INMOBILIARIO',
    },
    'lro4qxh8': {
      'en': 'Please select...',
      'es': 'Por favor seleccione...',
    },
    'bok6ftjs': {
      'en': 'Search for an item...',
      'es': '',
    },
    'f9kmr8de': {
      'en': 'PROPERTY TYPE',
      'es': 'TIPO DE PROPIEDAD',
    },
    'r5bzpkv0': {
      'en': 'RENT',
      'es': 'RENTA',
    },
    'ucoipv2n': {
      'en': 'SELL',
      'es': 'VENTA',
    },
    'z6gzygq9': {
      'en': 'Please select...',
      'es': 'Por favor seleccione...',
    },
    'ge7743r1': {
      'en': 'Search for an item...',
      'es': '',
    },
    '1g707zvh': {
      'en': 'ADD MORE PHOTOS:',
      'es': 'AGREGAR MAS FOTOS:',
    },
    'p2vg2lx0': {
      'en': 'Additional Notes',
      'es': 'Notas adicionales',
    },
    'sukloly5': {
      'en': 'Additional notes...',
      'es': 'Notas adicionales...',
    },
    'xnrnngib': {
      'en': 'STEP',
      'es': 'PASO',
    },
    'l91iif14': {
      'en': '3/3',
      'es': '3/3',
    },
    'ypv4uzwh': {
      'en': 'PUBLISH',
      'es': 'PUBLICAR',
    },
    'fsrg5efe': {
      'en': 'Field is required',
      'es': '',
    },
    'h9khrbap': {
      'en': 'Please choose an option from the dropdown',
      'es': '',
    },
    'cjn2ds13': {
      'en': 'Field is required',
      'es': '',
    },
    'ala1p99t': {
      'en': 'Please choose an option from the dropdown',
      'es': '',
    },
    '1bbrid6r': {
      'en': 'Field is required',
      'es': '',
    },
    'm7hlsbv3': {
      'en': 'Please choose an option from the dropdown',
      'es': '',
    },
    'e0g6fqsy': {
      'en': 'Home',
      'es': 'Hogar',
    },
  },
  // homePage_Autorizate
  {
    'wk75hgir': {
      'en': 'Welcome!',
      'es': 'Aprobar Publicaciones',
    },
    '8r921kts': {
      'en': 'Rating',
      'es': 'Clasificación',
    },
    'a01nmsin': {
      'en': 'Rent',
      'es': 'Rentar',
    },
  },
  // propertyDetailsAtorize
  {
    '5o3grq18': {
      'en': 'Reviews',
      'es': 'Reseñas',
    },
    'vaauhg0d': {
      'en': 'DESCRIPTION',
      'es': 'DESCRIPCIÓN',
    },
    'l5c3w1o9': {
      'en': 'Amenities',
      'es': 'Comodidades',
    },
    'dodz75f6': {
      'en': 'Available:',
      'es': 'Disponible a Partir de:',
    },
    'cqe1x6wm': {
      'en': 'Rooms',
      'es': 'Habitaciones:',
    },
    'u5fy0igb': {
      'en': 'BathRooms:',
      'es': 'Baños:',
    },
    '9uucqhih': {
      'en': 'Josh Richardson',
      'es': 'Jose Richardson',
    },
    'gglbq7df': {
      'en':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam...',
      'es':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam...',
    },
    'h79sap27': {
      'en': 'Josh Richardson',
      'es': 'Jose Richardson',
    },
    '4ooyt9ws': {
      'en':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam...',
      'es':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam...',
    },
    '4ybdzoj0': {
      'en': 'Approved',
      'es': 'Aprobado',
    },
    'ey98f2my': {
      'en': 'Home',
      'es': 'Hogar',
    },
  },
  // aCrearNombrePano
  {
    'l91hm8sg': {
      'en': 'Welcome!',
      'es': '¡Bienvenido!',
    },
    'vgu7l9q5': {
      'en': 'Find your Dream Space ',
      'es': 'Encuentra el espacio de tus sueños',
    },
    'mnhewfnw': {
      'en': 'Tours:',
      'es': 'Tours Encontrados:',
    },
    '5ent2698': {
      'en': 'New Tour',
      'es': 'Crea Nuevo Tour',
    },
    'orq8it3e': {
      'en': 'Save',
      'es': 'Guardar',
    },
    'bhgn671d': {
      'en': 'Version Name',
      'es': 'Nombre de Versión',
    },
    'ecklld5v': {
      'en': 'Publish',
      'es': 'Publicar',
    },
  },
  // aConsultarNombrePano
  {
    'ufwmph7f': {
      'en': 'Welcome!',
      'es': '¡Bienvenido!',
    },
    'qncfrajx': {
      'en': 'Find your Dream Space ',
      'es': 'Encuentra el espacio de tus sueños',
    },
    'i2ckf4aa': {
      'en': 'Tours',
      'es': 'Tours Encontrados:',
    },
    'i0kbbg1l': {
      'en': 'Publish',
      'es': 'Publicar',
    },
  },
  // homePage_Favoritos
  {
    'p7zthz0n': {
      'en': 'Bookmarks',
      'es': 'Mis Favoritos',
    },
    '2g9osyth': {
      'en': 'Rating',
      'es': '',
    },
    'mi88c69x': {
      'en': 'Rent',
      'es': '',
    },
  },
  // bottomSheet
  {
    'm8rywydj': {
      'en': 'Session Booked!',
      'es': '¡Sesión reservada!',
    },
    'vmjkzlpf': {
      'en': 'You have successfully booked a session on:',
      'es': 'Ha reservado con éxito una sesión en:',
    },
    'pbl7domm': {
      'en': 'Mon, Dec 11 - 2021',
      'es': 'lun, dic 11 - 2021',
    },
  },
  // total
  {
    'olmzhllq': {
      'en': 'Order Total',
      'es': 'Total del pedido',
    },
    'qnisiojw': {
      'en':
          'Your order total is a summary of all items in your order minus any fees and taxes associated with your purchase.',
      'es':
          'El total de su pedido es un resumen de todos los artículos de su pedido menos las tarifas e impuestos asociados con su compra.',
    },
    'hcei233s': {
      'en': 'Okay',
      'es': 'Bueno',
    },
  },
  // changePhoto
  {
    '35t3j1hy': {
      'en': 'Change Profile Photo',
      'es': 'Cambiar foto de perfil',
    },
    'b6i0qrxd': {
      'en': 'Upload Photo',
      'es': 'Subir foto',
    },
    'y1uqcwtu': {
      'en': 'Save Photo',
      'es': 'Salvar Foto',
    },
  },
  // reviewTrip
  {
    '1xzvobvy': {
      'en': 'Rate Your Trip',
      'es': 'Califica tu viaje',
    },
    'tipbgz8l': {
      'en': 'Let us know what you thought of the place below!',
      'es': '¡Cuéntanos qué te pareció el lugar a continuación!',
    },
    '4ml9og4a': {
      'en': 'How would you rate it?',
      'es': '¿Cómo lo calificarías?',
    },
    'i2zqamur': {
      'en': 'Please leave a description of the place...',
      'es': 'Por favor deja una descripción del lugar...',
    },
    'e8ehp6e3': {
      'en': 'Submit Review',
      'es': 'Enviar opinión',
    },
  },
  // changeMainPhoto
  {
    'qvppgoie': {
      'en': 'Change Main Photo',
      'es': 'Cambiar foto principal',
    },
    '8nn6pd0d': {
      'en': 'Upload Photo',
      'es': 'Subir foto',
    },
    '1w9oraw7': {
      'en': 'Save Photo',
      'es': 'Salvar Foto',
    },
  },
  // cancelTrip
  {
    'p59d89lc': {
      'en': 'Cancel Trip',
      'es': 'Cancelar viaje',
    },
    'v35fgepj': {
      'en':
          'If you want to cancel your tripl please leave a note below to send to the host.',
      'es':
          'Si desea cancelar su viaje, deje una nota a continuación para enviársela al anfitrión.',
    },
    'l8xvknly': {
      'en': 'Your reason for cancelling...',
      'es': 'Tu motivo para cancelar...',
    },
    'ql29hiif': {
      'en': 'Yes, Cancel Trip',
      'es': 'Sí, cancelar viaje',
    },
    't6gec4iu': {
      'en': 'Never Mind',
      'es': 'No importa',
    },
  },
  // cancelTripHOST
  {
    '1zrs5mz9': {
      'en': 'Cancel Trip',
      'es': 'Cancelar viaje',
    },
    'pcp78xrs': {
      'en':
          'If you want to cancel your tripl please leave a note below to send to the host.',
      'es':
          'Si desea cancelar su viaje, deje una nota a continuación para enviársela al anfitrión.',
    },
    'b02rfcl7': {
      'en': 'Your reason for cancelling...',
      'es': 'Tu motivo para cancelar...',
    },
    'mzm4ulmt': {
      'en': 'Yes, Cancel Trip',
      'es': 'Sí, cancelar viaje',
    },
    'm4cvcyjc': {
      'en': 'Never Mind',
      'es': 'No importa',
    },
  },
  // aModalProspectosOpc
  {
    '959sxcpp': {
      'en': 'Options',
      'es': 'Opciones:',
    },
    '8lomu3oa': {
      'en': 'Bid',
      'es': 'Apartar Inmuble',
    },
    'xe8nefw9': {
      'en': 'CalendarDisponibilidadGPI',
      'es': '',
    },
    'pdpwgcde': {
      'en': 'Pre-Aplication',
      'es': 'Pre-Aplicar',
    },
  },
  // Miscellaneous
  {
    'pnbvjy9e': {
      'en':
          'Necesitamos acceder a la camara para que pueda subir fotos de las propiedades directamente',
      'es': '',
    },
    'eyiqamkr': {
      'en': 'Necesitamos Permisos para acceder a sus Fotos de propiedades',
      'es': '',
    },
    'uohuqt8r': {
      'en':
          'Necesitamos acceder a su ubicacion para guardar la ubicacion de inmuebes',
      'es': '',
    },
    'fljhyb7t': {
      'en':
          'Necesitamos Permisos para enviarle Notificaciones de las Propiedades y de las citas para mantenerle infomado',
      'es': '',
    },
    'gdj4h0ox': {
      'en':
          'Necesitamos acceder al Calendario para Agendar citas y recordarle de ellas ',
      'es': '',
    },
    'ecyht956': {
      'en':
          'Necesitamos Acceder  a su ubicacion mientras usa la app para ubicar las propiedades que se den de alta',
      'es': '',
    },
    'd7chqmld': {
      'en': '',
      'es': '',
    },
    '2lypwhc8': {
      'en': '',
      'es': '',
    },
    't2b2te5c': {
      'en': '',
      'es': '',
    },
    'kk4qbkgu': {
      'en': '',
      'es': '',
    },
    'zkw7db1n': {
      'en': '',
      'es': '',
    },
    'eghmjkwa': {
      'en': '',
      'es': '',
    },
    'p3w6icqi': {
      'en': '',
      'es': '',
    },
    'ka43m37c': {
      'en': '',
      'es': '',
    },
    'aspwoxs5': {
      'en': '',
      'es': '',
    },
    'nj7hvppu': {
      'en': '',
      'es': '',
    },
    'hccbv10l': {
      'en': '',
      'es': '',
    },
    '17vv7m70': {
      'en': '',
      'es': '',
    },
    'sz4ofksw': {
      'en': '',
      'es': '',
    },
    'wj70rz9q': {
      'en': '',
      'es': '',
    },
    'ncicre4r': {
      'en': '',
      'es': '',
    },
    'zcod1rtw': {
      'en': '',
      'es': '',
    },
    'nbfcbdya': {
      'en': '',
      'es': '',
    },
    'yy1qx30l': {
      'en': '',
      'es': '',
    },
    '52kz15az': {
      'en': '',
      'es': '',
    },
    '15zocukn': {
      'en': '',
      'es': '',
    },
    'ikhsdn13': {
      'en': '',
      'es': '',
    },
    'h2d90fuz': {
      'en': '',
      'es': '',
    },
    'yfzclpyv': {
      'en': '',
      'es': '',
    },
    'hzupow5c': {
      'en': '',
      'es': '',
    },
    '3e83c9ec': {
      'en': '',
      'es': '',
    },
  },
].reduce((a, b) => a..addAll(b));
