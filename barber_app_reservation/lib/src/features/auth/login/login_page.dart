import 'package:barber_app_reservation/src/core/ui/constants.dart';
import 'package:barber_app_reservation/src/core/ui/helpers/form_helper.dart';
import 'package:barber_app_reservation/src/core/ui/helpers/messages.dart';
import 'package:barber_app_reservation/src/features/auth/login/login_state.dart';
import 'package:barber_app_reservation/src/features/auth/login/login_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  @override
  void dispose() {
    emailEC.dispose();
    passwordEC.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // com riverpod ou provider as interações são feitas dentro do método build
    // with notifier class view modal
    final LoginVm(:login) = ref.watch(loginVmProvider.notifier);

    // without notifier only a state is listenner
    ref.listen(loginVmProvider, (_, state) {
      switch (state) {
        case LoginState(status: LoginStateStatus.initial):
          break;
        // se o error conter message
        case LoginState(status: LoginStateStatus.error, :final errorMessage?):
          Messages.showError(errorMessage, context);
        // se o error não conter message
        case LoginState(status: LoginStateStatus.error):
          Messages.showError('Erro ao realizar o login', context);
        case LoginState(status: LoginStateStatus.admLogin):
          break;
        case LoginState(status: LoginStateStatus.employeLogin):
          break;
      }
    });

    return Scaffold(
        backgroundColor: Colors.black,
        body: Form(
          key: formKey,
          child: DecoratedBox(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImageConstants.bgChair),
                opacity: 0.2,
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(ImageConstants.imgLogo),
                            const SizedBox(
                              height: 24,
                            ),
                            TextFormField(
                              onTapOutside: (_) => unfocus(context),
                              validator: Validatorless.multiple([
                                Validatorless.required('E-mail obrigatório'),
                                Validatorless.email('E-mail inválido'),
                              ]),
                              controller: emailEC,
                              decoration: const InputDecoration(
                                  label: Text('E-mail'),
                                  hintText: 'E-mail',
                                  hintStyle: TextStyle(color: Colors.black),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  labelStyle: TextStyle(color: Colors.black)),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            TextFormField(
                              onTapOutside: (_) => unfocus(context),
                              validator: Validatorless.multiple([
                                Validatorless.required('Senha obrigatória'),
                                Validatorless.min(6,
                                    'Senha deve ter pelo menos 6 caracteres'),
                              ]),
                              obscureText: true,
                              controller: passwordEC,
                              decoration: const InputDecoration(
                                label: Text('Senha'),
                                hintText: 'Senha',
                                hintStyle: TextStyle(color: Colors.black),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                labelStyle: TextStyle(color: Colors.black),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Esqueceu a senha?',
                                style: TextStyle(
                                    fontSize: 12, color: ColorsConstants.brow),
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(56),
                              ),
                              onPressed: () {
                                switch (formKey.currentState?.validate()) {
                                  case (false || null):
                                    Messages.showError(
                                        'Campos inválidos', context);
                                  case true:
                                    login(emailEC.text, passwordEC.text);
                                }
                              },
                              child: const Text('ACESSAR'),
                            )
                          ],
                        ),
                        const Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            'Criar conta',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
