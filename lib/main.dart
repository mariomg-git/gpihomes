import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'auth/firebase_auth/firebase_user_provider.dart';
import 'auth/firebase_auth/auth_util.dart';

import 'backend/push_notifications/push_notifications_util.dart';
import 'backend/firebase/firebase_config.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/internationalization.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  usePathUrlStrategy();

  await initFirebase();

  await FFLocalizations.initialize();

  final appState = FFAppState(); // Initialize FFAppState
  await appState.initializePersistedState();

  runApp(ChangeNotifierProvider(
    create: (context) => appState,
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  ThemeMode _themeMode = ThemeMode.system;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;

  late Stream<BaseAuthUser> userStream;

  final authUserSub = authenticatedUserStream.listen((_) {});
  final fcmTokenSub = fcmTokenUserStream.listen((_) {});

  @override
  void initState() {
    super.initState();

    // Inicializar locale con el guardado o detectar del sistema
    _locale = FFLocalizations.getStoredLocale();

    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier);
    userStream = gpiHomesFirebaseUserStream()
      ..listen((user) {
        _appStateNotifier.update(user);
      });
    jwtTokenStream.listen((_) {});
    Future.delayed(
      const Duration(milliseconds: 1000),
      () => _appStateNotifier.stopShowingSplashImage(),
    );
  }

  @override
  void dispose() {
    authUserSub.cancel();
    fcmTokenSub.cancel();
    super.dispose();
  }

  void setLocale(String language) {
    safeSetState(() => _locale = createLocale(language));
    FFLocalizations.storeLocale(language);
  }

  void setThemeMode(ThemeMode mode) => safeSetState(() {
        _themeMode = mode;
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'GpiHomes',
      localizationsDelegates: const [
        FFLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FallbackMaterialLocalizationDelegate(),
        FallbackCupertinoLocalizationDelegate(),
      ],
      locale: _locale,
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        // Si ya hay un locale guardado, úsalo
        if (_locale != null) return _locale;
        
        // Detectar el idioma del navegador/sistema
        if (locale != null) {
          // Verificar si el idioma del sistema está soportado
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode) {
              return supportedLocale;
            }
          }
        }
        
        // Por defecto, usar español
        return const Locale('es');
      },
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: false,
      ),
      themeMode: _themeMode,
      routerConfig: _router,
    );
  }
}

class NavBarPage extends StatefulWidget {
  const NavBarPage({super.key, this.initialPage, this.page});

  final String? initialPage;
  final Widget? page;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  String _currentPageName = 'homePage_MAIN';
  late Widget? _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPageName = widget.initialPage ?? _currentPageName;
    _currentPage = widget.page;
  }

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = loggedIn;
    
    final Map<String, Widget> tabs = isLoggedIn
        ? {
            'homePage_MAIN': const HomePageMAINWidget(),
            'homePage_Comprar': const HomePageComprarWidget(),
            'homePage_Publicar': const HomePagePublicarWidget(),
            'profilePage': const ProfilePageWidget(),
          }
        : {
            'homePage_MAIN': const HomePageMAINWidget(),
            'homePage_Comprar': const HomePageComprarWidget(),
            'login': const LoginWidget(),
          };
    
    final currentIndex = tabs.keys.toList().indexOf(_currentPageName);

    final MediaQueryData queryData = MediaQuery.of(context);

    return Scaffold(
      body: MediaQuery(
          data: queryData
              .removeViewInsets(removeBottom: true)
              .removeViewPadding(removeBottom: true),
          child: _currentPage ?? tabs[_currentPageName] ?? tabs.values.first),
      extendBody: true,
      bottomNavigationBar: FloatingNavbar(
        currentIndex: currentIndex >= 0 ? currentIndex : 0,
        onTap: (i) => safeSetState(() {
          _currentPage = null;
          _currentPageName = tabs.keys.toList()[i];
        }),
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        selectedItemColor: FlutterFlowTheme.of(context).primary,
        unselectedItemColor: FlutterFlowTheme.of(context).grayIcon,
        selectedBackgroundColor: FlutterFlowTheme.of(context).accent1,
        borderRadius: 16.0,
        itemBorderRadius: 12.0,
        margin: const EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 8.0),
        padding: const EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
        width: double.infinity,
        elevation: 8.0,
        items: isLoggedIn
            ? [
                // Tab 1: Rentas (siempre visible)
                FloatingNavbarItem(
                  customWidget: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        currentIndex == 0 ? Icons.home_rounded : Icons.home_outlined,
                        color: currentIndex == 0
                            ? FlutterFlowTheme.of(context).primary
                            : FlutterFlowTheme.of(context).grayIcon,
                        size: currentIndex == 0 ? 26.0 : 24.0,
                      ),
                      Text(
                        FFLocalizations.of(context).getText(
                          'pc1xe8og' /* Rent */,
                        ),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: currentIndex == 0
                              ? FlutterFlowTheme.of(context).primary
                              : FlutterFlowTheme.of(context).grayIcon,
                          fontSize: 11.0,
                          fontWeight: currentIndex == 0 ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                // Tab 2: Ventas (siempre visible)
                FloatingNavbarItem(
                  customWidget: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        currentIndex == 1 ? Icons.add_home_work : Icons.add_home_work,
                        color: currentIndex == 1
                            ? FlutterFlowTheme.of(context).primary
                            : FlutterFlowTheme.of(context).grayIcon,
                        size: currentIndex == 1 ? 26.0 : 24.0,
                      ),
                      Text(
                        FFLocalizations.of(context).getText(
                          'begxdg5m' /* Buy */,
                        ),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: currentIndex == 1
                              ? FlutterFlowTheme.of(context).primary
                              : FlutterFlowTheme.of(context).grayIcon,
                          fontSize: 11.0,
                          fontWeight: currentIndex == 1 ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                // Tab 3: Publicar (solo si está logueado)
                FloatingNavbarItem(
                  customWidget: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        currentIndex == 2
                            ? Icons.publish_rounded
                            : Icons.publish_outlined,
                        color: currentIndex == 2
                            ? FlutterFlowTheme.of(context).primary
                            : FlutterFlowTheme.of(context).grayIcon,
                        size: currentIndex == 2 ? 26.0 : 24.0,
                      ),
                      Text(
                        FFLocalizations.of(context).getText(
                          'sm6qo734' /* Publish */,
                        ),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: currentIndex == 2
                              ? FlutterFlowTheme.of(context).primary
                              : FlutterFlowTheme.of(context).grayIcon,
                          fontSize: 11.0,
                          fontWeight: currentIndex == 2 ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                // Tab 4: Perfil (solo si está logueado)
                FloatingNavbarItem(
                  customWidget: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        currentIndex == 3
                            ? Icons.account_circle
                            : Icons.account_circle_outlined,
                        color: currentIndex == 3
                            ? FlutterFlowTheme.of(context).primary
                            : FlutterFlowTheme.of(context).grayIcon,
                        size: currentIndex == 3 ? 26.0 : 24.0,
                      ),
                      Text(
                        FFLocalizations.of(context).getText(
                          'ihyid5uw' /* Profile */,
                        ),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: currentIndex == 3
                              ? FlutterFlowTheme.of(context).primary
                              : FlutterFlowTheme.of(context).grayIcon,
                          fontSize: 11.0,
                          fontWeight: currentIndex == 3 ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                )
              ]
            : [
                // Usuario NO logueado: Rentas, Ventas, Login
                FloatingNavbarItem(
                  customWidget: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        currentIndex == 0 ? Icons.home_rounded : Icons.home_outlined,
                        color: currentIndex == 0
                            ? FlutterFlowTheme.of(context).primary
                            : FlutterFlowTheme.of(context).grayIcon,
                        size: currentIndex == 0 ? 26.0 : 24.0,
                      ),
                      Text(
                        FFLocalizations.of(context).getText(
                          'pc1xe8og' /* Rent */,
                        ),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: currentIndex == 0
                              ? FlutterFlowTheme.of(context).primary
                              : FlutterFlowTheme.of(context).grayIcon,
                          fontSize: 11.0,
                          fontWeight: currentIndex == 0 ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                FloatingNavbarItem(
                  customWidget: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        currentIndex == 1 ? Icons.add_home_work : Icons.add_home_work,
                        color: currentIndex == 1
                            ? FlutterFlowTheme.of(context).primary
                            : FlutterFlowTheme.of(context).grayIcon,
                        size: currentIndex == 1 ? 26.0 : 24.0,
                      ),
                      Text(
                        FFLocalizations.of(context).getText(
                          'begxdg5m' /* Buy */,
                        ),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: currentIndex == 1
                              ? FlutterFlowTheme.of(context).primary
                              : FlutterFlowTheme.of(context).grayIcon,
                          fontSize: 11.0,
                          fontWeight: currentIndex == 1 ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                FloatingNavbarItem(
                  customWidget: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        currentIndex == 2
                            ? Icons.login_rounded
                            : Icons.login_outlined,
                        color: currentIndex == 2
                            ? FlutterFlowTheme.of(context).primary
                            : FlutterFlowTheme.of(context).grayIcon,
                        size: currentIndex == 2 ? 26.0 : 24.0,
                      ),
                      Text(
                        'Login',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: currentIndex == 2
                              ? FlutterFlowTheme.of(context).primary
                              : FlutterFlowTheme.of(context).grayIcon,
                          fontSize: 11.0,
                          fontWeight: currentIndex == 2 ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                )
              ],
      ),
    );
  }
}
