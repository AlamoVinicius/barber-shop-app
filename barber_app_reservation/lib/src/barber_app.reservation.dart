import 'package:asyncstate/widget/async_state_builder.dart';
import 'package:barber_app_reservation/src/core/ui/app_theme.dart';
import 'package:barber_app_reservation/src/core/ui/barbershop_nav_global_key.dart';
import 'package:barber_app_reservation/src/features/auth/login/login_page.dart';
import 'package:barber_app_reservation/src/features/auth/register/barbershop/barbershop_register_page.dart';
import 'package:barber_app_reservation/src/features/spash/splash_page.dart';
import 'package:flutter/material.dart';

import 'features/auth/register/user/user_register_page.dart';

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
          navigatorKey: BarbershopNavGlobalKey.instance.navkey,
          routes: {
            '/': (_) => const SplashPage(),
            '/auth/login': (_) => const LoginPage(),
            '/auth/register/user': (_) => const UserRegisterPage(),
            '/auth/register/barbershop': (_) => const BarbershopRegisterPage(),
            '/home/adm': (_) => const Text('adm'),
            '/home/employee': (_) => const Text('Employee'),
          },
        );
      },
    );
  }
}
