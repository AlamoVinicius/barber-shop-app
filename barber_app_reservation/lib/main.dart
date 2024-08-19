import 'package:barber_app_reservation/src/barber_app_reservation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: BarberReservationApp()));
}
