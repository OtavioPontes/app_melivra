import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/style/assets.dart';
import '../../../core/widgets/textfield_inicio_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 20.scale),
        child: Stack(
          children: [
            Positioned(
              top: 50.scale,
              left: 30.scale,
              child: InkWell(
                onTap: Modular.to.pop,
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 40.scale,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: 16.scale),
                Column(
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
                SizedBox(height: 16.scale),
                Stack(
                  children: [
                    Positioned(
                      child: SvgPicture.asset(
                        AssetsMeLivra.waveLogin,
                        width: size.width,
                        color: theme.primaryColor,
                      ),
                    ),
                    Positioned(
                      right: 10,
                      child: SvgPicture.asset(
                        AssetsMeLivra.loginDrawing,
                        width: size.width,
                        height: 100,
                      ),
                    ),
                    Positioned(
                      top: size.height * 0.12,
                      width: size.width,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 64.scale),
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
                              controller: TextEditingController(),
                              fieldHint: 'Email',
                              prefixIcon: Icons.email,
                            ),
                            SizedBox(height: 24.scale),
                            TextFieldInicio(
                              controller: TextEditingController(),
                              fieldHint: 'Senha',
                              prefixIcon: Icons.lock,
                            ),
                            SizedBox(height: 16.scale),
                            Padding(
                              padding: EdgeInsets.only(left: 12.scale),
                              child: InkWell(
                                child: Text(
                                  'Esqueci minha senha',
                                  style: theme.textTheme.bodyText2!.merge(
                                    TextStyle(
                                      color: theme.backgroundColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 32.scale),
                            Center(
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    // Change your radius here
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  fixedSize: Size(140.scale, 50.scale),
                                  backgroundColor: theme.backgroundColor,
                                ),
                                onPressed: () {},
                                child: Text(
                                  'Entrar',
                                  style: theme.textTheme.headline6!.merge(
                                    TextStyle(
                                      color: theme.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
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
