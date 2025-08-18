import 'package:app_melivra/app/core/assets/initial_custom_path.dart';
import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/core/style/assets.dart';
import 'package:app_melivra/app/modules/bottom_navigation/bottom_navigation_module.dart';
import 'package:app_melivra/app/modules/cadastro/cadastro_module.dart';
import 'package:app_melivra/app/modules/inicio/presentation/bloc/inicio_bloc.dart';
import 'package:app_melivra/app/modules/inicio/presentation/controller/inicio_controller.dart';
import 'package:app_melivra/app/modules/login/login_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({Key? key}) : super(key: key);

  @override
  _InicioPageState createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  final InicioController controller = Modular.get<InicioController>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: theme.cardColor,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 48.scale),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        AssetsMeLivra.logo,
                        width: 85.scale,
                        height: 85.scale,
                        fit: BoxFit.fitWidth,
                      ),
                      SizedBox(height: 16.scale),
                      Text(
                        'Me Livra',
                        style: theme.textTheme.displayMedium,
                      ),
                    ],
                  ),
                ),
              ),
              Stack(
                children: [
                  CustomPaint(
                    painter: InitialCustomPath(),
                    size: Size(size.width, size.height * 0.75),
                  ),
                  Positioned(
                    top: 40.scale,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 36.scale,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 80.scale),
                          Text(
                            'Bem vindo (a)',
                            style: theme.textTheme.headlineMedium!.merge(
                              TextStyle(
                                color: theme.colorScheme.surface,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 24.scale,
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              fixedSize: Size(size.width * 0.8, 54.scale),
                              backgroundColor: theme.colorScheme.surface,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                            onPressed: () =>
                                Modular.to.pushNamed(LoginModule.routeName),
                            child: Text(
                              "Fazer Login",
                              style: theme.textTheme.labelLarge!.merge(
                                TextStyle(
                                  color: theme.primaryColor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16.scale,
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              fixedSize: Size(size.width * 0.8, 54.scale),
                              backgroundColor: theme.colorScheme.primary,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              side: BorderSide(
                                color: theme.colorScheme.surface,
                                width: 2,
                              ),
                            ),
                            onPressed: () =>
                                Modular.to.pushNamed(CadastroModule.routeName),
                            child: Text(
                              "Cadastrar",
                              style: theme.textTheme.labelLarge!.merge(
                                TextStyle(
                                  color: theme.colorScheme.surface,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 40.scale),
                          if (GoogleSignIn.instance.supportsAuthenticate())
                            TextButton(
                              style: TextButton.styleFrom(
                                fixedSize: Size(size.width * 0.8, 54.scale),
                                backgroundColor: theme.colorScheme.surface,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                try {
                                  await GoogleSignIn.instance.initialize(
                                    serverClientId:
                                        "834072919526-buv9le1jfvbsh6jk5cin1s3ffklsmd7p.apps.googleusercontent.com",
                                    clientId:
                                        "834072919526-buv9le1jfvbsh6jk5cin1s3ffklsmd7p.apps.googleusercontent.com",
                                  );
                                  final account = await GoogleSignIn.instance
                                      .authenticate();

                                  controller.add(
                                    InicioBlocSignInEvent(
                                      idToken: account.authentication.idToken!,
                                    ),
                                  );
                                } catch (e) {
                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Erro ao autenticar com o Google: $e',
                                      ),
                                      backgroundColor: Colors.redAccent,
                                    ),
                                  );
                                }
                              },
                              child: BlocConsumer<InicioController,
                                  InicioBlocState>(
                                bloc: controller,
                                listener: (context, state) {
                                  if (state is InicioBlocSuccessState) {
                                    Modular.to.navigate(
                                      BottomNavigationModule.routeName,
                                    );
                                  }
                                  if (state is InicioBlocFailureState) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(state.message),
                                        backgroundColor: Colors.redAccent,
                                      ),
                                    );
                                  }
                                },
                                builder: (context, state) {
                                  if (state is InicioBlocLoadingState) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SvgPicture.asset(
                                        AssetsMeLivra.googleLogo,
                                        height: 25,
                                      ),
                                      Text(
                                        "Entrar com Google",
                                        style: theme.textTheme.labelLarge,
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
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
