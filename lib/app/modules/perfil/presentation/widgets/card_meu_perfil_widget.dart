import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/modules/meu_perfil/meu_perfil_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CardMeuPerfil extends StatelessWidget {
  const CardMeuPerfil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.85,
      child: GestureDetector(
        onTap: () => Modular.to.pushNamed(MeuPerfilModule.routeName),
        child: Card(
          child: Padding(
            padding: EdgeInsets.only(
              left: 24.scale,
              right: 16.scale,
              top: 16.scale,
              bottom: 16.scale,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.person,
                        size: 32.scale,
                      ),
                      SizedBox(width: 24.scale),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Meu Perfil',
                              style: theme.textTheme.headline6!.merge(
                                TextStyle(
                                  color: theme.primaryColor,
                                ),
                              ),
                            ),
                            SizedBox(height: 4.scale),
                            Text(
                              'Ver e editar perfil',
                              style: theme.textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 24.scale,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
