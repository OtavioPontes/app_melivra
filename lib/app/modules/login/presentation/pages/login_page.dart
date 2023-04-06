import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/core/utils/validators.dart';
import 'package:app_melivra/app/modules/esqueci_senha/esqueci_senha_module.dart';
import 'package:app_melivra/app/modules/login/presentation/bloc/login_bloc_states.dart';
import 'package:app_melivra/app/modules/login/presentation/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/style/assets.dart';
import '../../../../core/widgets/textfield_inicio_widget.dart';
import '../../../bottom_navigation/bottom_navigation_module.dart';
import '../widgets/login_failure_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController controller = Modular.get<LoginController>();

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
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: theme.backgroundColor,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: size.height,
              minWidth: size.width,
            ),
            child: IntrinsicHeight(
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
                  Positioned(
                    top: size.height * 0.05,
                    width: size.width,
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          AssetsMeLivra.logo,
                          width: 85.scale,
                          height: 85.scale,
                          fit: BoxFit.fitWidth,
                        ),
                        SizedBox(
                          height: 16.scale,
                        ),
                        Text(
                          'Me Livra',
                          style: theme.textTheme.headline2,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Stack(
                        children: [
                          SvgPicture.asset(
                            AssetsMeLivra.waveLogin,
                            width: size.width,
                            color: theme.primaryColor,
                          ),
                          Positioned(
                            right: 10.scale,
                            child: SvgPicture.asset(
                              AssetsMeLivra.loginDrawing,
                              width: size.width,
                              height: 100.scale,
                            ),
                          ),
                          Positioned(
                            top: size.height * 0.12,
                            width: size.width,
                            child: Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: 64.scale),
                              child: Form(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Login',
                                      style: theme.textTheme.headline4!.merge(
                                        TextStyle(
                                          color: theme.colorScheme.background,
                                        ),
                                      ),
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
                                      controller: controller.passwordController,
                                      fieldHint: 'Senha',
                                      prefixIcon: Icons.lock,
                                      isPassword: true,
                                    ),
                                    SizedBox(height: 16.scale),
                                    Padding(
                                      padding: EdgeInsets.only(left: 12.scale),
                                      child: GestureDetector(
                                        onTap: () => Modular.to.pushNamed(
                                          EsqueciSenhaModule.routeName,
                                        ),
                                        child: Text(
                                          'Esqueci minha senha',
                                          style:
                                              theme.textTheme.bodyText2!.merge(
                                            TextStyle(
                                              color: theme.backgroundColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 24.scale),
                                    BlocConsumer(
                                      bloc: controller.bloc,
                                      listener: (context, state) {
                                        if (state.runtimeType ==
                                            LoginSuccessState) {
                                          Modular.to.navigate(
                                              BottomNavigationModule.routeName);
                                        }
                                        if (state.runtimeType ==
                                            LoginFailureState) {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return LoginFailureDialog(
                                                message:
                                                    (state as LoginFailureState)
                                                        .message,
                                              );
                                            },
                                          );
                                        }
                                      },
                                      builder: (context, state) {
                                        return Center(
                                          child: TextButton(
                                            style: TextButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                // Change your radius here
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              fixedSize:
                                                  Size(140.scale, 50.scale),
                                              backgroundColor:
                                                  theme.backgroundColor,
                                            ),
                                            onPressed: controller.login,
                                            child: Text(
                                              'Entrar',
                                              style: theme.textTheme.headline6!
                                                  .merge(
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
        ),
      ),
    );
  }
}
