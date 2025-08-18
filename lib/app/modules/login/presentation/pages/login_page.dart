import 'package:app_melivra/app/core/assets/wave_login.dart';
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
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/style/assets.dart';
import '../../../../core/widgets/textfield_inicio_widget.dart';
import '../../../bottom_navigation/bottom_navigation_module.dart';

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
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: theme.colorScheme.surface,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 16.scale),
          child: Column(
            children: [
              SizedBox(
                width: size.width,
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
                    Center(
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
                            style: theme.textTheme.displayMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.scale),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Stack(
                    children: [
                      CustomPaint(
                        painter: WaveLogin(),
                        size: Size(size.width, size.height * 0.8),
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
                          padding: EdgeInsets.symmetric(horizontal: 64.scale),
                          child: Form(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Login',
                                  style: theme.textTheme.headlineMedium!.merge(
                                    TextStyle(
                                      color: theme.colorScheme.surface,
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
                                  onDone: controller.login,
                                  textInputAction: TextInputAction.done,
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
                                      style: theme.textTheme.bodyMedium!.merge(
                                        TextStyle(
                                          color: theme.colorScheme.surface,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 24.scale),
                                BlocConsumer(
                                  bloc: controller.bloc,
                                  listener: (context, state) {
                                    if (state is LoginSuccessState) {
                                      Modular.to.navigate(
                                        BottomNavigationModule.routeName,
                                      );
                                    }
                                    if (state is LoginFailureState) {
                                      Fluttertoast.showToast(
                                        msg: state.message,
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: Colors.redAccent,
                                        textColor: Colors.white,
                                        fontSize:
                                            theme.textTheme.bodyLarge?.fontSize,
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
                                          fixedSize: Size(140.scale, 50.scale),
                                          backgroundColor:
                                              theme.colorScheme.surface,
                                        ),
                                        onPressed: controller.login,
                                        child: Text(
                                          'Entrar',
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
