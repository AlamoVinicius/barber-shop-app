import 'package:asyncstate/widget/async_state_builder.dart';
import 'package:barber_app_reservation/src/core/ui/app_theme.dart';
import 'package:barber_app_reservation/src/features/auth/login/login_page.dart';
import 'package:barber_app_reservation/src/features/spash/splash_page.dart';
import 'package:flutter/material.dart';

class BarberReservationApp extends StatelessWidget {
  const BarberReservationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncStateBuilder(
      builder: (asyncNavigatorObserver) {
        return MaterialApp(
          title: "Barber shop App",
          theme: AppTheme.themeData,
          navigatorObservers: [asyncNavigatorObserver],
          routes: {
            '/': (_) => const SplashPage(),
            '/auth/login': (_) => const LoginPage(),
          },
        );
      },
    );
  }
}
