import 'package:barber_app_reservation/src/core/ui/barbershop_icon.dart';
import 'package:barber_app_reservation/src/core/ui/constants.dart';
import 'package:flutter/material.dart';

class HomeEmployTile extends StatelessWidget {
  const HomeEmployTile({super.key});
  final imageNetwork = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: ColorsConstants.grey),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: switch (imageNetwork) {
                  true => const NetworkImage("url"),
                  false => const AssetImage(ImageConstants.avatar)
                  //parse to Image Provider is need because generic types is differents
                } as ImageProvider,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Nome e Sobrenome',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 12)),
                      child: const Text('AGENDAR'),
                    ),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 12)),
                      child: const Text('VER AGENDA'),
                    ),
                    const Icon(
                      BarbershopIcon.penEdit,
                      size: 16,
                      color: ColorsConstants.brow,
                    ),
                    const Icon(
                      BarbershopIcon.trash,
                      size: 16,
                      color: ColorsConstants.red,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
