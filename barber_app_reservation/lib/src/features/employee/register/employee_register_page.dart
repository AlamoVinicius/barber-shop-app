import 'dart:developer';
import 'dart:ui';

import 'package:barber_app_reservation/src/core/ui/widgets/avatar_widget.dart';
import 'package:barber_app_reservation/src/core/ui/widgets/hours_panel.dart';
import 'package:barber_app_reservation/src/core/ui/widgets/weekdays_panel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EmployeeRegisterPage extends StatefulWidget {
  const EmployeeRegisterPage({super.key});

  @override
  State<EmployeeRegisterPage> createState() => _EmployeeRegisterPageState();
}

class _EmployeeRegisterPageState extends State<EmployeeRegisterPage> {
  bool registerAdm = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar colaborador'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Column(
              children: [
                const AvatarWidget(),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  children: [
                    Checkbox.adaptive(
                        value: registerAdm,
                        onChanged: (value) {
                          setState(() {
                            registerAdm = !registerAdm;
                          });
                        }),
                    const Expanded(
                      child: Text(
                        "Sou administrador e quero me cadastrar como colaborador",
                        style: TextStyle(fontSize: 14),
                      ),
                    )
                  ],
                ),
                Offstage(
                  offstage: registerAdm,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 24,
                      ),
                      const TextField(
                        decoration: InputDecoration(
                          label: Text('Nome'),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      const TextField(
                        decoration: InputDecoration(
                          label: Text('E-mail'),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      const TextField(
                        decoration: InputDecoration(
                          label: Text('Senha'),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      WeekdaysPanel(
                        onDayPressed: (String day) {},
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                    ],
                  ),
                ),
                HoursPanel(
                    startTime: 6, endTime: 23, onHourPressed: (int hour) {}),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(56),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'CADASTRAR COLABORADOR',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
