import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/core/style/assets.dart';
import 'package:app_melivra/app/modules/perfil/presentation/controllers/perfil_controller.dart';
import 'package:app_melivra/app/modules/perfil/presentation/widgets/logout_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/card_deslogar_widget.dart';
import '../widgets/card_meu_perfil_widget.dart';
import '../widgets/card_retirada_widget.dart';
import '../widgets/card_sobre_widget.dart';

class PerfilPage extends StatelessWidget {
  PerfilPage({Key? key}) : super(key: key);
  final PerfilController controller = Modular.get<PerfilController>();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: theme.primaryColor,
          statusBarIconBrightness: Brightness.light,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              top: 32.scale,
              bottom: 40.scale,
            ),
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40.scale,
                        backgroundColor: theme.backgroundColor,
                        child: Text(
                          'OP',
                          style: theme.textTheme.headline4!.merge(
                            TextStyle(
                              color: theme.colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.scale),
                      Text(
                        'Otávio Pontes',
                        style: theme.textTheme.headline5!.merge(
                          TextStyle(
                            color: theme.backgroundColor,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Stack(
                  children: [
                    Positioned(
                      height: size.height * 0.8,
                      child: SvgPicture.asset(
                        AssetsMeLivra.waveHome,
                        width: size.width,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32.scale),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 64.scale),
                          const CardMeuPerfil(),
                          SizedBox(height: 16.scale),
                          const CardSobre(),
                          SizedBox(height: 16.scale),
                          const CardRetirada(),
                          SizedBox(height: 16.scale),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) =>
                                    LogoutDialog(controller: controller),
                              );
                            },
                            child: const CardDeslogar(),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
