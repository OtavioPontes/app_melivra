import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/core/style/assets.dart';

import '../../../core/widgets/textfield_inicio_widget.dart';

class CadastroPage extends StatelessWidget {
  const CadastroPage({Key? key}) : super(key: key);

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
                child: InkWell(
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
            Stack(
              children: [
                SvgPicture.asset(
                  AssetsMeLivra.wave,
                  width: size.width,
                  color: theme.primaryColor,
                  fit: BoxFit.fitWidth,
                ),
                Positioned(
                  top: size.height * 0.1,
                  width: size.width,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 64.scale),
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
                          controller: TextEditingController(),
                          fieldHint: 'Nome',
                          prefixIcon: Icons.person,
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
                        SizedBox(height: 24.scale),
                        TextFieldInicio(
                          controller: TextEditingController(),
                          fieldHint: 'Confirme sua senha',
                          prefixIcon: Icons.lock,
                        ),
                        SizedBox(height: 48.scale),
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
                              'Cadastrar',
                              style: theme.textTheme.headline6!.merge(TextStyle(
                                color: theme.primaryColor,
                              )),
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
      ),
    );
  }
}
