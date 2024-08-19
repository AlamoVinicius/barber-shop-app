import 'dart:developer';

import 'package:barber_app_reservation/src/core/ui/barbershop_icon.dart';
import 'package:barber_app_reservation/src/core/ui/constants.dart';
import 'package:barber_app_reservation/src/core/ui/widgets/custom_loader.dart';
import 'package:barber_app_reservation/src/features/home/adm/home_adm_state.dart';
import 'package:barber_app_reservation/src/features/home/adm/home_adm_vm.dart';
import 'package:barber_app_reservation/src/features/home/adm/widgets/home_employ_tile.dart';
import 'package:barber_app_reservation/src/features/home/widgets/home_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeAdmPage extends ConsumerWidget {
  const HomeAdmPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeAdmVmProvider);

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: ColorsConstants.brow,
          onPressed: () {
            Navigator.of(context).pushNamed('/employee/register');
          },
          child: const CircleAvatar(
            backgroundColor: Colors.white,
            maxRadius: 12,
            child:
                Icon(BarbershopIcon.addEmployee, color: ColorsConstants.brow),
          ),
        ),
        body: homeState.when(
          data: (HomeAdmState data) {
            return CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(
                  child: HomeHeader(),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (context, index) =>
                          HomeEmployTile(employee: data.employees[index]),
                      childCount: data.employees.length),
                )
              ],
            );
          },
          error: (Object error, StackTrace stackTrace) {
            log('Erro to loading employeers',
                error: error, stackTrace: stackTrace);

            return const Center(
              child: Text('Erro ao carregar página'),
            );
          },
          loading: () {
            return const CustomLoader();
          },
        ));
  }
}
