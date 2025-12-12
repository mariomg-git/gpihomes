// ignore_for_file: overridden_fields, annotate_overrides

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class FlutterFlowTheme {
  static FlutterFlowTheme of(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? DarkModeTheme()
        : LightModeTheme();
  }

  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary;
  late Color secondary;
  late Color tertiary;
  late Color alternate;
  late Color primaryText;
  late Color secondaryText;
  late Color primaryBackground;
  late Color secondaryBackground;
  late Color accent1;
  late Color accent2;
  late Color accent3;
  late Color accent4;
  late Color success;
  late Color warning;
  late Color error;
  late Color info;

  late Color cultured;
  late Color redApple;
  late Color celadon;
  late Color turquoise;
  late Color gunmetal;
  late Color grayIcon;
  late Color darkText;
  late Color dark600;
  late Color gray600;
  late Color lineGray;

  @Deprecated('Use displaySmallFamily instead')
  String get title1Family => displaySmallFamily;
  @Deprecated('Use displaySmall instead')
  TextStyle get title1 => typography.displaySmall;
  @Deprecated('Use headlineMediumFamily instead')
  String get title2Family => typography.headlineMediumFamily;
  @Deprecated('Use headlineMedium instead')
  TextStyle get title2 => typography.headlineMedium;
  @Deprecated('Use headlineSmallFamily instead')
  String get title3Family => typography.headlineSmallFamily;
  @Deprecated('Use headlineSmall instead')
  TextStyle get title3 => typography.headlineSmall;
  @Deprecated('Use titleMediumFamily instead')
  String get subtitle1Family => typography.titleMediumFamily;
  @Deprecated('Use titleMedium instead')
  TextStyle get subtitle1 => typography.titleMedium;
  @Deprecated('Use titleSmallFamily instead')
  String get subtitle2Family => typography.titleSmallFamily;
  @Deprecated('Use titleSmall instead')
  TextStyle get subtitle2 => typography.titleSmall;
  @Deprecated('Use bodyMediumFamily instead')
  String get bodyText1Family => typography.bodyMediumFamily;
  @Deprecated('Use bodyMedium instead')
  TextStyle get bodyText1 => typography.bodyMedium;
  @Deprecated('Use bodySmallFamily instead')
  String get bodyText2Family => typography.bodySmallFamily;
  @Deprecated('Use bodySmall instead')
  TextStyle get bodyText2 => typography.bodySmall;

  String get displayLargeFamily => typography.displayLargeFamily;
  TextStyle get displayLarge => typography.displayLarge;
  String get displayMediumFamily => typography.displayMediumFamily;
  TextStyle get displayMedium => typography.displayMedium;
  String get displaySmallFamily => typography.displaySmallFamily;
  TextStyle get displaySmall => typography.displaySmall;
  String get headlineLargeFamily => typography.headlineLargeFamily;
  TextStyle get headlineLarge => typography.headlineLarge;
  String get headlineMediumFamily => typography.headlineMediumFamily;
  TextStyle get headlineMedium => typography.headlineMedium;
  String get headlineSmallFamily => typography.headlineSmallFamily;
  TextStyle get headlineSmall => typography.headlineSmall;
  String get titleLargeFamily => typography.titleLargeFamily;
  TextStyle get titleLarge => typography.titleLarge;
  String get titleMediumFamily => typography.titleMediumFamily;
  TextStyle get titleMedium => typography.titleMedium;
  String get titleSmallFamily => typography.titleSmallFamily;
  TextStyle get titleSmall => typography.titleSmall;
  String get labelLargeFamily => typography.labelLargeFamily;
  TextStyle get labelLarge => typography.labelLarge;
  String get labelMediumFamily => typography.labelMediumFamily;
  TextStyle get labelMedium => typography.labelMedium;
  String get labelSmallFamily => typography.labelSmallFamily;
  TextStyle get labelSmall => typography.labelSmall;
  String get bodyLargeFamily => typography.bodyLargeFamily;
  TextStyle get bodyLarge => typography.bodyLarge;
  String get bodyMediumFamily => typography.bodyMediumFamily;
  TextStyle get bodyMedium => typography.bodyMedium;
  String get bodySmallFamily => typography.bodySmallFamily;
  TextStyle get bodySmall => typography.bodySmall;

  Typography get typography => ThemeTypography(this);
}

class LightModeTheme extends FlutterFlowTheme {
  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary = const Color(0xFF1E3A8A);        // Azul profundo elegante
  late Color secondary = const Color(0xFFF59E0B);      // Dorado cálido
  late Color tertiary = const Color(0xFF10B981);       // Verde esmeralda
  late Color alternate = const Color(0xFF06B6D4);      // Cyan moderno
  late Color primaryText = const Color(0xFF1F2937);    // Gris oscuro para texto
  late Color secondaryText = const Color(0xFF6B7280);  // Gris medio
  late Color primaryBackground = const Color(0xFFFAFAFA);  // Blanco cálido
  late Color secondaryBackground = const Color(0xFFFFFFFF); // Blanco puro
  late Color accent1 = const Color(0xFFF3F4F6);        // Gris muy claro
  late Color accent2 = const Color(0xFFE5E7EB);        // Gris claro
  late Color accent3 = const Color(0xFFD1D5DB);        // Gris medio claro
  late Color accent4 = const Color(0xFF9CA3AF);        // Gris medio
  late Color success = const Color(0xFF10B981);        // Verde éxito
  late Color warning = const Color(0xFFF59E0B);        // Ámbar advertencia
  late Color error = const Color(0xFFEF4444);          // Rojo error
  late Color info = const Color(0xFF3B82F6);           // Azul información

  late Color cultured = const Color(0xFFF9FAFB);
  late Color redApple = const Color(0xFFEF4444);
  late Color celadon = const Color(0xFF86EFAC);
  late Color turquoise = const Color(0xFF06B6D4);
  late Color gunmetal = const Color(0xFF374151);
  late Color grayIcon = const Color(0xFF9CA3AF);
  late Color darkText = const Color(0xFF111827);
  late Color dark600 = const Color(0xFF1F2937);
  late Color gray600 = const Color(0xFF6B7280);
  late Color lineGray = const Color(0xFFD1D5DB);
}

class DarkModeTheme extends FlutterFlowTheme {
  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary = const Color(0xFF3B82F6);        // Azul brillante
  late Color secondary = const Color(0xFFFBBF24);      // Ámbar cálido
  late Color tertiary = const Color(0xFF34D399);       // Verde menta
  late Color alternate = const Color(0xFF22D3EE);      // Cyan brillante
  late Color primaryText = const Color(0xFFF9FAFB);    // Blanco cálido
  late Color secondaryText = const Color(0xFFD1D5DB);  // Gris claro
  late Color primaryBackground = const Color(0xFF111827);  // Azul muy oscuro
  late Color secondaryBackground = const Color(0xFF1F2937); // Azul oscuro
  late Color accent1 = const Color(0xFF374151);        // Gris oscuro
  late Color accent2 = const Color(0xFF4B5563);        // Gris medio oscuro
  late Color accent3 = const Color(0xFF6B7280);        // Gris medio
  late Color accent4 = const Color(0xFF9CA3AF);        // Gris claro
  late Color success = const Color(0xFF34D399);        // Verde éxito
  late Color warning = const Color(0xFFFBBF24);        // Ámbar advertencia
  late Color error = const Color(0xFFF87171);          // Rojo suave
  late Color info = const Color(0xFF60A5FA);           // Azul claro

  late Color cultured = const Color(0xFF1F2937);
  late Color redApple = const Color(0xFFF87171);
  late Color celadon = const Color(0xFF6EE7B7);
  late Color turquoise = const Color(0xFF22D3EE);
  late Color gunmetal = const Color(0xFF9CA3AF);
  late Color grayIcon = const Color(0xFF6B7280);
  late Color darkText = const Color(0xFFF9FAFB);
  late Color dark600 = const Color(0xFF374151);
  late Color gray600 = const Color(0xFF9CA3AF);
  late Color lineGray = const Color(0xFF4B5563);
}

abstract class Typography {
  String get displayLargeFamily;
  TextStyle get displayLarge;
  String get displayMediumFamily;
  TextStyle get displayMedium;
  String get displaySmallFamily;
  TextStyle get displaySmall;
  String get headlineLargeFamily;
  TextStyle get headlineLarge;
  String get headlineMediumFamily;
  TextStyle get headlineMedium;
  String get headlineSmallFamily;
  TextStyle get headlineSmall;
  String get titleLargeFamily;
  TextStyle get titleLarge;
  String get titleMediumFamily;
  TextStyle get titleMedium;
  String get titleSmallFamily;
  TextStyle get titleSmall;
  String get labelLargeFamily;
  TextStyle get labelLarge;
  String get labelMediumFamily;
  TextStyle get labelMedium;
  String get labelSmallFamily;
  TextStyle get labelSmall;
  String get bodyLargeFamily;
  TextStyle get bodyLarge;
  String get bodyMediumFamily;
  TextStyle get bodyMedium;
  String get bodySmallFamily;
  TextStyle get bodySmall;
}

class ThemeTypography extends Typography {
  ThemeTypography(this.theme);

  final FlutterFlowTheme theme;

  String get displayLargeFamily => 'Playfair Display';
  TextStyle get displayLarge => TextStyle(
        fontFamily: 'Playfair Display',
        color: theme.primaryText,
        fontWeight: FontWeight.bold,
        fontSize: 48.0,
      );
  String get displayMediumFamily => 'Playfair Display';
  TextStyle get displayMedium => TextStyle(
        fontFamily: 'Playfair Display',
        color: theme.primaryText,
        fontWeight: FontWeight.bold,
        fontSize: 36.0,
      );
  String get displaySmallFamily => 'Playfair Display';
  TextStyle get displaySmall => TextStyle(
        fontFamily: 'Playfair Display',
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 28.0,
      );
  String get headlineLargeFamily => 'Playfair Display';
  TextStyle get headlineLarge => TextStyle(
        fontFamily: 'Playfair Display',
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 32.0,
      );
  String get headlineMediumFamily => 'Playfair Display';
  TextStyle get headlineMedium => TextStyle(
        fontFamily: 'Playfair Display',
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 24.0,
      );
  String get headlineSmallFamily => 'Playfair Display';
  TextStyle get headlineSmall => TextStyle(
        fontFamily: 'Playfair Display',
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 20.0,
      );
  String get titleLargeFamily => 'Inter';
  TextStyle get titleLarge => TextStyle(
        fontFamily: 'Inter',
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 20.0,
      );
  String get titleMediumFamily => 'Inter';
  TextStyle get titleMedium => TextStyle(
        fontFamily: 'Inter',
        color: theme.secondaryText,
        fontWeight: FontWeight.w600,
        fontSize: 18.0,
      );
  String get titleSmallFamily => 'Inter';
  TextStyle get titleSmall => TextStyle(
        fontFamily: 'Inter',
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 16.0,
      );
  String get labelLargeFamily => 'Inter';
  TextStyle get labelLarge => TextStyle(
        fontFamily: 'Inter',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 14.0,
      );
  String get labelMediumFamily => 'Inter';
  TextStyle get labelMedium => TextStyle(
        fontFamily: 'Inter',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 12.0,
      );
  String get labelSmallFamily => 'Inter';
  TextStyle get labelSmall => TextStyle(
        fontFamily: 'Inter',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 11.0,
      );
  String get bodyLargeFamily => 'Inter';
  TextStyle get bodyLarge => TextStyle(
        fontFamily: 'Inter',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 16.0,
      );
  String get bodyMediumFamily => 'Inter';
  TextStyle get bodyMedium => TextStyle(
        fontFamily: 'Inter',
        color: theme.secondaryText,
        fontWeight: FontWeight.normal,
        fontSize: 14.0,
      );
  String get bodySmallFamily => 'Inter';
  TextStyle get bodySmall => TextStyle(
        fontFamily: 'Inter',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 13.0,
      );
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    String? fontFamily,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    FontStyle? fontStyle,
    bool useGoogleFonts = false, // Cambiado a false para web
    TextDecoration? decoration,
    double? lineHeight,
    List<Shadow>? shadows,
  }) =>
      copyWith(
        fontFamily: fontFamily,
        color: color,
        fontSize: fontSize,
        letterSpacing: letterSpacing,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        decoration: decoration,
        height: lineHeight,
        shadows: shadows,
      );
}
