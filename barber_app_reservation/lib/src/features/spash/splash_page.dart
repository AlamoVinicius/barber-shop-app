import 'dart:async';
import 'dart:developer';

import 'package:barber_app_reservation/src/core/ui/constants.dart';
import 'package:barber_app_reservation/src/core/ui/helpers/messages.dart';
import 'package:barber_app_reservation/src/features/spash/splash_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  var _scale = 10.0;
  var _animationOpacityLogo = 0.0;

  double get _logoAnimationWidgetWidth => 100 * _scale;
  double get _logoAnimationWidgetHeight => 120 * _scale;

  bool endAnimation = false;
  Timer? redirectTimer;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _animationOpacityLogo = 1.0;
        _scale = 1.0;
      });
    });
    super.initState();
  }

  void _redirect(String routeName) {
    if (!endAnimation) {
      redirectTimer?.cancel();
      redirectTimer = Timer(
        const Duration(milliseconds: 300),
        () {
          _redirect(routeName);
        },
      );
    } else {
      redirectTimer?.cancel();
      Navigator.of(context)
          .pushNamedAndRemoveUntil(routeName, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(splashVmProvider, (_, state) {
      state.whenOrNull(error: (error, stackTrace) {
        log('Erro ao validar o login', error: error, stackTrace: stackTrace);
        Messages.showError('Erro ao validar o login', context);
        _redirect('auth/login');
      }, data: (data) {
        switch (data) {
          case SplashState.loggedADM:
            _redirect('/home/adm');
          case SplashState.loggedEmployee:
            _redirect('/home/employee');
          case _:
            _redirect('/auth/login');
        }
      });
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageConstants.bgChair),
            opacity: 0.2,
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: AnimatedOpacity(
            duration: const Duration(seconds: 3),
            curve: Curves.easeIn,
            opacity: _animationOpacityLogo,
            onEnd: () {
              setState(() {
                endAnimation = true;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(seconds: 3),
              width: _logoAnimationWidgetWidth,
              height: _logoAnimationWidgetHeight,
              curve: Curves.linearToEaseOut,
              child: Image.asset(
                'assets/images/imgLogo.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
