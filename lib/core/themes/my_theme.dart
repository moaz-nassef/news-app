import 'package:flutter/material.dart';

class MyTheme {
  // Brand colors
  static const Color primary = Color(0xFFFF2E00);
  static const Color secondary = Color(0xFFC714D7);
  static const Color tertiary = Color(0xFF3F0E70);

  // Surfaces
  static const Color background = Color(0xFFF6F7F9);
  static const Color surface = Colors.white;

  // Text
  static const Color textPrimary = Color(0xFF14151A);
  static const Color textSecondary = Color(0xFF6B7280);

  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, secondary, tertiary],
  );

  static ThemeData get myTheme {
    const scheme = ColorScheme.light(
      primary: primary,
      onPrimary: Colors.white,
      secondary: secondary,
      onSecondary: Colors.white,
      tertiary: tertiary,
      surface: surface,
      onSurface: textPrimary,
      error: Color(0xFFE53935),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: background,

      // Smooth fade + slide transition between every page in the app.
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: _AppPageTransitionsBuilder(),
          TargetPlatform.iOS: _AppPageTransitionsBuilder(),
          TargetPlatform.macOS: _AppPageTransitionsBuilder(),
          TargetPlatform.windows: _AppPageTransitionsBuilder(),
          TargetPlatform.linux: _AppPageTransitionsBuilder(),
          TargetPlatform.fuchsia: _AppPageTransitionsBuilder(),
        },
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: surface,
        elevation: 0,
        scrolledUnderElevation: 0.6,
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.3,
        ),
        iconTheme: IconThemeData(color: textPrimary),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: surface,
        selectedColor: secondary,
        labelStyle: const TextStyle(
          color: textSecondary,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        side: BorderSide(color: Colors.black.withValues(alpha: 0.06)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          minimumSize: const Size(0, 46),
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),

      dividerTheme: DividerThemeData(
        color: Colors.black.withValues(alpha: 0.08),
        space: 1,
        thickness: 1,
      ),

      textTheme: const TextTheme(
        // screen titles
        displayLarge: TextStyle(
          letterSpacing: -0.5,
          color: textPrimary,
          fontSize: 38,
          fontWeight: FontWeight.w800,
        ),
        // hero text on gradient cards
        labelLarge: TextStyle(
          letterSpacing: -0.5,
          color: Colors.white,
          fontSize: 32,
          fontWeight: FontWeight.w700,
        ),
        // section titles
        labelMedium: TextStyle(
          fontSize: 25,
          color: textPrimary,
          fontWeight: FontWeight.w700,
        ),
        // white on-gradient secondary text
        labelSmall: TextStyle(
          letterSpacing: -0.1,
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        // subtitles / descriptions
        displaySmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 1.3,
          letterSpacing: 0.1,
          color: textSecondary,
        ),
        // card / list titles
        displayMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          height: 1,
          color: textPrimary,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

/// A subtle fade + upward slide used for every page transition in the app.
class _AppPageTransitionsBuilder extends PageTransitionsBuilder {
  const _AppPageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (route.isFirst) return child;

    // The page that is being left fades out slightly.
    final secondary = CurvedAnimation(
      parent: secondaryAnimation,
      curve: Curves.easeIn,
      reverseCurve: Curves.easeOut,
    );

    // The page that is being entered fades in while sliding up.
    final primary = CurvedAnimation(
      parent: animation,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );

    return FadeTransition(
      opacity: Tween<double>(begin: 1, end: 0.92).animate(secondary),
      child: FadeTransition(
        opacity: Tween<double>(begin: 0, end: 1).animate(primary),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.06),
            end: Offset.zero,
          ).animate(primary),
          child: child,
        ),
      ),
    );
  }
}
