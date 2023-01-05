import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/modules/suggestions/suggestions_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CardSugestoes extends StatelessWidget {
  const CardSugestoes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.85,
      child: GestureDetector(
        onTap: () => Modular.to.pushNamed(SuggestionModule.routeName),
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
                        Icons.rocket_launch,
                        size: 32.scale,
                      ),
                      SizedBox(width: 24.scale),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sugestões',
                              style: theme.textTheme.headline6!.merge(
                                TextStyle(
                                  color: theme.primaryColor,
                                ),
                              ),
                            ),
                            SizedBox(height: 4.scale),
                            Text(
                              'Sugira melhorias e nos informe sobre erros no app',
                              style: theme.textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 24.scale),
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
