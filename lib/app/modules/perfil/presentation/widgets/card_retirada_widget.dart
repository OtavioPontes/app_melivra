import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/modules/solicitar_retirada/solicitar_retirada_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CardRetirada extends StatelessWidget {
  const CardRetirada({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.85,
      child: GestureDetector(
        onTap: () => Modular.to.pushNamed(SolicitarRetiradaModule.routeName),
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
                        Icons.cancel,
                        color: theme.primaryColor,
                        size: 32.scale,
                      ),
                      SizedBox(width: 24.scale),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Solicitar Retirada',
                              style: theme.textTheme.titleMedium!.merge(
                                TextStyle(
                                  color: theme.primaryColor,
                                ),
                              ),
                            ),
                            SizedBox(height: 4.scale),
                            Text(
                              'Gostaria de retirar meu nome do app',
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.scale),
                GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 24.scale,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
