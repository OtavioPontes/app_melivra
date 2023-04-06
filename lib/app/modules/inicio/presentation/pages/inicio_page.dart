import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/core/style/assets.dart';
import 'package:app_melivra/app/modules/inicio/presentation/controller/inicio_controller.dart';
import 'package:app_melivra/app/modules/cadastro/cadastro_module.dart';
import 'package:app_melivra/app/modules/login/login_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({Key? key}) : super(key: key);

  @override
  _InicioPageState createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  final InicioController controller = Modular.get<InicioController>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: theme.cardColor,
        ),
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 48.scale,
                ),
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
            ),
            Positioned(
              bottom: 0,
              width: size.width,
              child: SvgPicture.asset(
                AssetsMeLivra.inicio,
                fit: BoxFit.fill,
                color: theme.primaryColor,
                width: size.width,
                height: size.height * 0.65,
              ),
            ),
            Positioned(
              bottom: size.height * 0.16,
              width: size.width,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 36.scale,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bem vindo (a)',
                      style: theme.textTheme.headline4!.merge(
                        TextStyle(
                          color: theme.colorScheme.background,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24.scale,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        fixedSize: Size(size.width * 0.8, 54.scale),
                        backgroundColor: theme.colorScheme.background,
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
                        style: theme.textTheme.headline5!.merge(
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
                          color: theme.colorScheme.background,
                          width: 2,
                        ),
                      ),
                      onPressed: () =>
                          Modular.to.pushNamed(CadastroModule.routeName),
                      child: Text(
                        "Cadastrar",
                        style: theme.textTheme.headline5!.merge(
                          TextStyle(
                            color: theme.colorScheme.background,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
