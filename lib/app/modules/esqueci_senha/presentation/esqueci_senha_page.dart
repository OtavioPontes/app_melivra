import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/style/assets.dart';
import '../../../core/widgets/textfield_inicio_widget.dart';

class EsqueciSenhaPage extends StatelessWidget {
  const EsqueciSenhaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
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
                        style: theme.textTheme.displayMedium,
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Stack(
                      children: [
                        SvgPicture.asset(
                          AssetsMeLivra.waveLogin,
                          alignment: Alignment.topCenter,
                          width: size.width,
                          fit: BoxFit.cover,
                          color: theme.primaryColor,
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
                                  'Esqueci minha senha',
                                  style: theme.textTheme.headlineMedium!.merge(
                                    TextStyle(
                                      color: theme.colorScheme.background,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 16.scale),
                                Text(
                                  'Insira seu email e logo mandaremos o link de troca de senha',
                                  style: theme.textTheme.bodyMedium!.merge(
                                    TextStyle(
                                      color: theme.colorScheme.background,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 32.scale),
                                TextFieldInicio(
                                  controller: TextEditingController(),
                                  fieldHint: 'Email',
                                  prefixIcon: Icons.email,
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
                                      backgroundColor: theme.colorScheme.background,
                                    ),
                                    onPressed: () {},
                                    child: Text(
                                      'Enviar',
                                      style: theme.textTheme.titleLarge!.merge(
                                        TextStyle(
                                          color: theme.primaryColor,
                                        ),
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
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
