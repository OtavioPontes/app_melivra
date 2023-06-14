import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/core/style/assets.dart';
import 'package:app_melivra/app/core/utils/validators.dart';
import 'package:app_melivra/app/modules/cadastro/presentation/bloc/cadastro_bloc_states.dart';
import 'package:app_melivra/app/modules/cadastro/presentation/controllers/cadastro_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/widgets/textfield_inicio_widget.dart';
import '../../../inicio/inicio_module.dart';
import '../../../login/login_module.dart';

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
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: size.height,
            maxWidth: size.width,
          ),
          child: Stack(
            children: [
              Positioned(
                top: 50.scale,
                left: 30.scale,
                child: GestureDetector(
                  onTap: Modular.to.pop,
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 40.scale,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Stack(
                    children: [
                      SvgPicture.asset(
                        AssetsMeLivra.wave,
                        color: theme.primaryColor,
                        width: size.width,
                        height: size.height * 0.8,
                        fit: BoxFit.fitHeight,
                      ),
                      Positioned(
                        top: size.height * 0.1,
                        width: size.width,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 64.scale),
                          child: Form(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Cadastro',
                                  style: theme.textTheme.headlineMedium!.merge(
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
                                        msg: 'Cadastro realizado com sucesso ✅',
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: Colors.greenAccent,
                                        textColor: Colors.black,
                                        fontSize:
                                            theme.textTheme.bodyLarge?.fontSize,
                                      );
                                      Modular.to
                                          .navigate(InicioModule.routeName);
                                      Modular.to
                                          .pushNamed(LoginModule.routeName);
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
                                              theme.colorScheme.background,
                                        ),
                                        onPressed: controller.isNotEmpty
                                            ? controller.cadastro
                                            : null,
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
                                )
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
