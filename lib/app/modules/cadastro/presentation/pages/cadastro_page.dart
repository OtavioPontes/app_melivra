import 'package:app_melivra/app/core/utils/validators.dart';
import 'package:app_melivra/app/modules/cadastro/presentation/bloc/cadastro_bloc_states.dart';
import 'package:app_melivra/app/modules/cadastro/presentation/controllers/cadastro_controller.dart';
import 'package:app_melivra/app/modules/cadastro/presentation/widgets/cadastro_failure_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/core/style/assets.dart';

import '../../../../core/widgets/textfield_inicio_widget.dart';
import '../widgets/cadastro_success_dialog.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({Key? key}) : super(key: key);

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final CadastroController controller = Modular.get<CadastroController>();

  @override
  void dispose() {
    controller.bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 64.scale),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 32.scale),
                child: GestureDetector(
                  onTap: Modular.to.pop,
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 40.scale,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 32.scale,
            ),
            Column(
              children: [
                Stack(
                  children: [
                    SvgPicture.asset(
                      AssetsMeLivra.wave,
                      height: size.height,
                      color: theme.primaryColor,
                      fit: BoxFit.fitHeight,
                    ),
                    Positioned(
                      top: size.height * 0.1,
                      width: size.width,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 64.scale),
                        child: Form(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Cadastro',
                                style: theme.textTheme.headline4!.merge(
                                  TextStyle(
                                    color: theme.colorScheme.background,
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
                                validator: (value) => Validators.validateEmail(
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
                              ),
                              SizedBox(height: 24.scale),
                              TextFieldInicio(
                                isPassword: true,
                                controller:
                                    controller.passwordConfirmationController,
                                fieldHint: 'Confirme senha',
                                prefixIcon: Icons.lock,
                              ),
                              SizedBox(height: 48.scale),
                              BlocConsumer(
                                  listener: (context, state) {
                                    if (state.runtimeType ==
                                        CadastroSuccessState) {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (context) {
                                          return const CadastroSuccessDialog();
                                        },
                                      );
                                    }
                                    if (state.runtimeType ==
                                        CadastroFailureState) {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return CadastroFailureDialog(
                                            message:
                                                (state as CadastroFailureState)
                                                    .message,
                                          );
                                        },
                                      );
                                    }
                                  },
                                  bloc: controller.bloc,
                                  builder: (context, state) {
                                    if (state.runtimeType ==
                                        CadastroLoadingState) {
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
                                              theme.backgroundColor,
                                        ),
                                        onPressed: controller.isNotEmpty
                                            ? controller.cadastro
                                            : null,
                                        child: Text(
                                          'Cadastrar',
                                          style:
                                              theme.textTheme.headline6!.merge(
                                            TextStyle(
                                              color: theme.primaryColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  })
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
    );
  }
}
