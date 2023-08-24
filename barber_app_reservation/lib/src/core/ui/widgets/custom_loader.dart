import 'package:barber_app_reservation/src/core/ui/constants.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.horizontalRotatingDots(
          color: ColorsConstants.brow, size: 60),
    );
  }
}
