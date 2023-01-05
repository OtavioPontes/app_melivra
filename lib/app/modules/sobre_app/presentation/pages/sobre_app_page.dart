import 'package:app_melivra/app/core/utils/appinfo.dart';
import 'package:app_melivra/app/modules/perfil/presentation/widgets/card_meu_perfil_widget.dart';
import 'package:app_melivra/app/modules/sobre_app/presentation/widgets/card_autores_widget.dart';
import 'package:app_melivra/app/modules/sobre_app/presentation/widgets/card_sugestoes_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/core/style/assets.dart';

class SobreAppPage extends StatelessWidget {
  SobreAppPage({Key? key}) : super(key: key);

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
            child: Stack(
              children: [
                Positioned(
                  left: 20.scale,
                  top: 10.scale,
                  child: GestureDetector(
                    onTap: Modular.to.pop,
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 40.scale,
                      color: theme.backgroundColor,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.info,
                            color: theme.backgroundColor,
                            size: 40.scale,
                          ),
                          SizedBox(height: 16.scale),
                          Text(
                            'Sobre o App',
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
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top: 20.scale,
                          child: SvgPicture.asset(
                            AssetsMeLivra.waveHome,
                            width: size.width,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 40.scale,
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 48.scale),
                              SizedBox(
                                width: size.width * 0.5,
                                child: Text(
                                  'Me Livra é um app para facilitar a avaliação dos professores e te ajudar a se livrar de problemas.',
                                  style: theme.textTheme.headline5!.merge(
                                    TextStyle(
                                      color: theme.backgroundColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 32.scale),
                    const Center(child: CardSugestoes()),
                    SizedBox(height: 16.scale),
                    const Center(child: CardDesenvolvedores()),
                    SizedBox(height: 16.scale),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Me Livra',
                              style: theme.textTheme.headline6!.merge(
                                TextStyle(
                                  color: theme.backgroundColor,
                                ),
                              ),
                            ),
                            SizedBox(height: 4.scale),
                            Text(
                              'Versão ${AppInfo.instance.packageInfo.version}',
                              style: theme.textTheme.caption!.merge(
                                TextStyle(
                                  color: theme.backgroundColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Positioned(
                  right: 10.scale,
                  top: 100.scale,
                  child: SvgPicture.asset(AssetsMeLivra.sobre),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
