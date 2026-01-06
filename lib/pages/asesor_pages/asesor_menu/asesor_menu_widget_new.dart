import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'asesor_menu_model.dart';
export 'asesor_menu_model.dart';

class AsesorMenuWidget extends StatefulWidget {
  const AsesorMenuWidget({super.key});

  @override
  State<AsesorMenuWidget> createState() => _AsesorMenuWidgetState();
}

class _AsesorMenuWidgetState extends State<AsesorMenuWidget>
    with TickerProviderStateMixin {
  late AsesorMenuModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AsesorMenuModel());

    animationsMap.addAll({
      'containerOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 400.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          ScaleEffect(
            curve: Curves.easeOut,
            delay: 0.0.ms,
            duration: 400.0.ms,
            begin: const Offset(0.8, 0.8),
            end: const Offset(1.0, 1.0),
          ),
        ],
      ),
      'containerOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 100.0.ms,
            duration: 400.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          ScaleEffect(
            curve: Curves.easeOut,
            delay: 100.0.ms,
            duration: 400.0.ms,
            begin: const Offset(0.8, 0.8),
            end: const Offset(1.0, 1.0),
          ),
        ],
      ),
      'containerOnPageLoadAnimation3': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 200.0.ms,
            duration: 400.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          ScaleEffect(
            curve: Curves.easeOut,
            delay: 200.0.ms,
            duration: 400.0.ms,
            begin: const Offset(0.8, 0.8),
            end: const Offset(1.0, 1.0),
          ),
        ],
      ),
      'containerOnPageLoadAnimation4': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 300.0.ms,
            duration: 400.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          ScaleEffect(
            curve: Curves.easeOut,
            delay: 300.0.ms,
            duration: 400.0.ms,
            begin: const Offset(0.8, 0.8),
            end: const Offset(1.0, 1.0),
          ),
        ],
      ),
      'containerOnPageLoadAnimation5': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 400.0.ms,
            duration: 400.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          ScaleEffect(
            curve: Curves.easeOut,
            delay: 400.0.ms,
            duration: 400.0.ms,
            begin: const Offset(0.8, 0.8),
            end: const Offset(1.0, 1.0),
          ),
        ],
      ),
      'containerOnPageLoadAnimation6': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 500.0.ms,
            duration: 400.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          ScaleEffect(
            curve: Curves.easeOut,
            delay: 500.0.ms,
            duration: 400.0.ms,
            begin: const Offset(0.8, 0.8),
            end: const Offset(1.0, 1.0),
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Widget _buildMenuCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
    required String animationKey,
  }) {
    return Material(
      color: Colors.transparent,
      elevation: 4,
      shadowColor: color.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color,
                color.withOpacity(0.7),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 32.0,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).bodyLarge.override(
                        fontFamily: 'Poiret One',
                        color: Colors.white,
                        fontSize: 16.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).bodySmall.override(
                        fontFamily: 'Poiret One',
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 12.0,
                        letterSpacing: 0.0,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    ).animateOnPageLoad(animationsMap[animationKey]!);
  }

  @override
  Widget build(BuildContext context) {
    return Title(
        title: 'asesorMenu',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
              automaticallyImplyLeading: false,
              leading: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30.0,
                borderWidth: 1.0,
                buttonSize: 60.0,
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 30.0,
                ),
                onPressed: () async {
                  context.pop();
                },
              ),
              title: Text(
                FFLocalizations.of(context).getText(
                  'f3fjlzeu' /* Menu */,
                ),
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: 'Poiret One',
                      letterSpacing: 0.0,
                    ),
              ),
              actions: const [],
              centerTitle: false,
              elevation: 0,
            ),
            body: SafeArea(
              top: true,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header con bienvenida
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              FlutterFlowTheme.of(context).primary,
                              FlutterFlowTheme.of(context).secondary,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: [
                            BoxShadow(
                              color: FlutterFlowTheme.of(context).primary.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '👋 Bienvenido',
                              style: FlutterFlowTheme.of(context).headlineSmall.override(
                                fontFamily: 'Poiret One',
                                color: Colors.white,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Gestiona tus tours y citas',
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Poiret One',
                                color: Colors.white.withOpacity(0.9),
                                letterSpacing: 0.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Sección: Gestión de Tours
                      Text(
                        '📅 Gestión de Tours',
                        style: FlutterFlowTheme.of(context).titleLarge.override(
                          fontFamily: 'Poiret One',
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 16.0,
                        crossAxisSpacing: 16.0,
                        childAspectRatio: 0.9,
                        children: [
                          _buildMenuCard(
                            context,
                            icon: Icons.calendar_month_rounded,
                            title: 'Tours GPI',
                            subtitle: 'Crear citas',
                            color: const Color(0xFF667EEA),
                            onTap: () {
                              context.pushNamed(
                                'createCalendarGpiTours',
                                queryParameters: {
                                  'idProperty': serializeParam(
                                    '5QHFnZyyL2SmAGIq4CZE',
                                    ParamType.String,
                                  ),
                                }.withoutNulls,
                              );
                            },
                            animationKey: 'containerOnPageLoadAnimation1',
                          ),
                          _buildMenuCard(
                            context,
                            icon: Icons.event_available_rounded,
                            title: 'Mis Citas',
                            subtitle: 'Ver programadas',
                            color: const Color(0xFF764BA2),
                            onTap: () {
                              context.pushNamed(
                                'calendarDisponibilidadUser',
                                queryParameters: {
                                  'idProperty': serializeParam(
                                    '5QHFnZyyL2SmAGIq4CZE',
                                    ParamType.String,
                                  ),
                                }.withoutNulls,
                              );
                            },
                            animationKey: 'containerOnPageLoadAnimation2',
                          ),
                          _buildMenuCard(
                            context,
                            icon: Icons.edit_calendar_rounded,
                            title: 'Agendar Tour',
                            subtitle: 'Nueva cita GPI',
                            color: const Color(0xFFFA8BFF),
                            onTap: () {
                              context.pushNamed(
                                'createCalendarDate',
                                queryParameters: {
                                  'idProperty': serializeParam(
                                    '5QHFnZyyL2SmAGIq4CZE',
                                    ParamType.String,
                                  ),
                                  'idUser': serializeParam(
                                    currentUserUid,
                                    ParamType.String,
                                  ),
                                }.withoutNulls,
                              );
                            },
                            animationKey: 'containerOnPageLoadAnimation3',
                          ),
                          _buildMenuCard(
                            context,
                            icon: Icons.person_add_rounded,
                            title: 'Visita Usuario',
                            subtitle: 'Agendar cliente',
                            color: const Color(0xFF2BDA8E),
                            onTap: () {
                              context.pushNamed(
                                'calendarUserCreate',
                                queryParameters: {
                                  'idProperty': serializeParam(
                                    '5QHFnZyyL2SmAGIq4CZE',
                                    ParamType.String,
                                  ),
                                }.withoutNulls,
                              );
                            },
                            animationKey: 'containerOnPageLoadAnimation4',
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Sección: Administración
                      Text(
                        '⚙️ Administración',
                        style: FlutterFlowTheme.of(context).titleLarge.override(
                          fontFamily: 'Poiret One',
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 16.0,
                        crossAxisSpacing: 16.0,
                        childAspectRatio: 0.9,
                        children: [
                          _buildMenuCard(
                            context,
                            icon: Icons.pending_actions_rounded,
                            title: 'Pendientes',
                            subtitle: 'Visitas GPI',
                            color: const Color(0xFFFF6B9D),
                            onTap: () {
                              context.pushNamed(
                                'createCalendarDateGPI',
                                queryParameters: {
                                  'idProperty': serializeParam(
                                    'xxx',
                                    ParamType.String,
                                  ),
                                  'idUser': serializeParam(
                                    'xxx',
                                    ParamType.String,
                                  ),
                                }.withoutNulls,
                              );
                            },
                            animationKey: 'containerOnPageLoadAnimation5',
                          ),
                          _buildMenuCard(
                            context,
                            icon: Icons.verified_rounded,
                            title: 'Verificar',
                            subtitle: 'Check-in/out',
                            color: const Color(0xFFFEC84B),
                            onTap: () {
                              context.pushNamed('homePage_Autorizate');
                            },
                            animationKey: 'containerOnPageLoadAnimation6',
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Debug: imprimir email del usuario
                      Builder(
                        builder: (context) {
                          print('Current User Email in asesor menu: $currentUserEmail');
                          return const SizedBox.shrink();
                        },
                      ),
                      
                      // Sección: Super Admin (solo para emails específicos)
                      if (currentUserEmail?.toLowerCase() == 'mario@gmail.com' || currentUserEmail?.toLowerCase() == 'mariomg.tj@gmail.com') ...[
                        Text(
                          '🔑 Super Admin',
                          style: FlutterFlowTheme.of(context).titleLarge.override(
                            fontFamily: 'Poiret One',
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        GridView.count(
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          mainAxisSpacing: 16.0,
                          crossAxisSpacing: 16.0,
                          childAspectRatio: 0.9,
                          children: [
                            _buildMenuCard(
                              context,
                              icon: Icons.admin_panel_settings_rounded,
                              title: 'Administrar Usuarios',
                              subtitle: 'Permisos de admin',
                              color: const Color(0xFFDC2626),
                              onTap: () {
                                context.pushNamed('adminUsersPage');
                              },
                              animationKey: 'containerOnPageLoadAnimation7',
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
