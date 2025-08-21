import 'dart:async';

import 'package:app_melivra/app/core/assets/wave_login.dart';
import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/core/utils/validators.dart';
import 'package:app_melivra/app/modules/cadastro/presentation/bloc/cadastro_bloc_states.dart';
import 'package:app_melivra/app/modules/cadastro/presentation/controllers/cadastro_controller.dart';
import 'package:app_melivra/app/modules/cadastro/presentation/controllers/validate_email_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/widgets/textfield_inicio_widget.dart';
import '../../../inicio/inicio_module.dart';
import '../../../login/login_module.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({Key? key}) : super(key: key);

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final controller = Modular.get<CadastroController>();
  final validateEmailController = Modular.get<ValidateEmailController>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  int _countdownTime = 30;
  Timer? _resendTimer;

  final ValueNotifier<int> countdownNotifier = ValueNotifier<int>(30);

  void _startResendTimer() {
    setState(() {
      _countdownTime = 30;
    });

    countdownNotifier.value = 30;

    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdownTime > 0) {
        _countdownTime--;
        // Update the notifier so listeners get notified
        countdownNotifier.value = _countdownTime;
        setState(() {});
      } else {
        setState(() {});
        _resendTimer?.cancel();
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _resendTimer?.cancel();
    controller.bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return BlocListener(
      bloc: validateEmailController,
      listener: (context, state) {
        if (state is ValidateEmailSuccessState) {
          _startResendTimer();
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(24.scale),
              ),
            ),
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: ValidateEmailSheetContent(
                  countdownNotifier: countdownNotifier,
                  controller: validateEmailController,
                  email: controller.emailController.text,
                  onResendPressed: _startResendTimer,
                ),
              );
            },
          );
        }
        if (state is ValidateEmailCodeSuccessState) {
          Fluttertoast.showToast(
            msg: 'Email validado com sucesso ✅',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.black,
            fontSize: theme.textTheme.bodyLarge?.fontSize,
          );
          Modular.to.pop();
          controller.cadastro();
        }

        if (state is ValidateEmailFailureState) {
          Fluttertoast.showToast(
            msg: state.message,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.redAccent,
            textColor: Colors.white,
            fontSize: theme.textTheme.bodyLarge?.fontSize,
          );
        }
        if (state is ValidateEmailCodeFailureState) {
          Fluttertoast.showToast(
            msg: state.message,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.redAccent,
            textColor: Colors.white,
            fontSize: theme.textTheme.bodyLarge?.fontSize,
          );
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(40.scale),
                  child: GestureDetector(
                    onTap: Modular.to.pop,
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 40.scale,
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Stack(
                    children: [
                      CustomPaint(
                        painter: WaveLogin(),
                        size: Size(size.width, size.height),
                      ),
                      Positioned(
                        top: size.height * 0.1,
                        width: size.width,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 64.scale),
                          child: Form(
                            key: formKey,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Cadastro',
                                  style: theme.textTheme.headlineMedium!.merge(
                                    TextStyle(
                                      color: theme.colorScheme.surface,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 32.scale),
                                TextFieldInicio(
                                  controller: controller.nameController,
                                  fieldHint: 'Nome',
                                  prefixIcon: Icons.person,
                                ),
                                SizedBox(height: 24.scale),
                                TextFieldInicio(
                                  validator: (value) =>
                                      Validators.validateEmail(
                                    controller.emailController.text,
                                  ),
                                  controller: controller.emailController,
                                  fieldHint: 'Email',
                                  prefixIcon: Icons.email,
                                ),
                                SizedBox(height: 24.scale),
                                TextFieldInicio(
                                  isPassword: true,
                                  controller: controller.passwordController,
                                  fieldHint: 'Senha',
                                  prefixIcon: Icons.lock,
                                  validator: (value) {
                                    if ((value?.length ?? 0) < 8) {
                                      return 'Tamanho mínimo de 8 caracteres';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 24.scale),
                                TextFieldInicio(
                                  isPassword: true,
                                  controller:
                                      controller.passwordConfirmationController,
                                  fieldHint: 'Confirme senha',
                                  prefixIcon: Icons.lock,
                                  validator: (value) {
                                    if ((value?.length ?? 0) < 8) {
                                      return 'Tamanho mínimo de 8 caracteres';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 48.scale),
                                BlocConsumer(
                                  listener: (context, state) {
                                    if (state is CadastroSuccessState) {
                                      Fluttertoast.showToast(
                                        msg:
                                            'Cadastro realizado com sucesso, faça o login para continuar',
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: Colors.greenAccent,
                                        textColor: Colors.black,
                                        fontSize:
                                            theme.textTheme.bodyLarge?.fontSize,
                                      );
                                      Modular.to
                                          .navigate(InicioModule.routeName);
                                    }
                                    if (state is CadastroFailureState) {
                                      Fluttertoast.showToast(
                                        msg: state.message,
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: Colors.redAccent,
                                        textColor: Colors.white,
                                        fontSize:
                                            theme.textTheme.bodyLarge?.fontSize,
                                      );
                                    }
                                  },
                                  bloc: controller.bloc,
                                  builder: (context, state) {
                                    if (state is CadastroLoadingState) {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          backgroundColor: theme.cardColor,
                                        ),
                                      );
                                    }
                                    return Center(
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            // Change your radius here
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          fixedSize: Size(140.scale, 50.scale),
                                          backgroundColor:
                                              theme.colorScheme.surface,
                                        ),
                                        onPressed: () {
                                          validateEmailController.add(
                                            SendValidationCodeEvent(
                                              email: controller
                                                  .emailController.text,
                                              name: controller
                                                  .nameController.text,
                                            ),
                                          );
                                        },
                                        child: Text(
                                          'Cadastrar',
                                          style:
                                              theme.textTheme.titleLarge!.merge(
                                            TextStyle(
                                              color: theme.primaryColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ValidateEmailSheetContent extends StatelessWidget {
  final String email;
  final Function() onResendPressed;
  final ValidateEmailController controller;
  final ValueListenable<int> countdownNotifier;
  const ValidateEmailSheetContent({
    super.key,
    required this.email,
    required this.onResendPressed,
    required this.controller,
    required this.countdownNotifier,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ValueListenableBuilder(
      valueListenable: countdownNotifier,
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.only(
            top: 40,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.scale,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.scale,
                      ),
                      child: Text(
                        'Validação de email',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: theme.primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.scale,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 32.scale,
                      ),
                      child: Text.rich(
                        TextSpan(
                          text:
                              'Digite o código de validação enviado para o email: ',
                          style: theme.textTheme.bodyMedium,
                          children: [
                            TextSpan(
                              text: email,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40.scale,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.scale,
                ),
                child: Pinput(
                  defaultPinTheme: PinTheme(
                    width: 60.scale,
                    height: 40.scale,
                    decoration: BoxDecoration(
                      color: theme.disabledColor,
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                  ),
                  length: 8,
                  onChanged: (value) {
                    controller.pinCode = value;
                  },
                ),
              ),
              SizedBox(
                height: 40.scale,
              ),
              BlocBuilder(
                bloc: controller,
                builder: (context, state) {
                  if (state is ValidateEmailLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: theme.cardColor,
                      ),
                    );
                  }
                  return Column(
                    children: [
                      Center(
                        child: TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              // Change your radius here
                              borderRadius: BorderRadius.circular(
                                12,
                              ),
                            ),
                            fixedSize: Size(
                              140.scale,
                              50.scale,
                            ),
                          ),
                          onPressed: () {
                            if (controller.pinCode.length == 8) {
                              controller.add(
                                ValidateEmailPinCodeEnteredEvent(
                                  email: email,
                                  pinCode: controller.pinCode,
                                ),
                              );
                            } else {
                              Fluttertoast.showToast(
                                msg: 'Por favor, insira o código de validação',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.redAccent,
                                textColor: Colors.white,
                                fontSize: theme.textTheme.bodyLarge?.fontSize,
                              );
                            }
                          },
                          child: Text(
                            'Enviar',
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: controller.pinCode.length == 8
                                  ? theme.primaryColor
                                  : theme.disabledColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24.scale),
                      Center(
                        child: TextButton.icon(
                          label: Text(
                            value == 0
                                ? 'Reenviar o código'
                                : 'Reenviar em $value s',
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: value == 0
                                  ? theme.colorScheme.onSurface
                                  : theme.colorScheme.onSurface.withValues(
                                      alpha: 0.5,
                                    ),
                            ),
                          ),
                          icon: Icon(
                            Icons.refresh,
                            color: value == 0
                                ? theme.colorScheme.onSurface
                                : theme.colorScheme.onSurface.withValues(
                                    alpha: 0.5,
                                  ),
                          ),
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              // Change your radius here
                              borderRadius: BorderRadius.circular(
                                12,
                              ),
                            ),
                          ),
                          onPressed: value == 0 ? onResendPressed : null,
                        ),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(
                height: 40.scale,
              ),
            ],
          ),
        );
      },
    );
  }
}
