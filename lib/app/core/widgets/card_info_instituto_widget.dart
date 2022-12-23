import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/core/widgets/score_widget.dart';
import 'package:app_melivra/app/modules/instituto_details/instituto_details_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CardInfoInstituto extends StatelessWidget {
  const CardInfoInstituto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.85,
      child: GestureDetector(
        onTap: () => Modular.to.pushNamed(InstitutoDetailsModule.routeName),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(16.scale),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.account_balance,
                      ),
                      SizedBox(width: 16.scale),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'EMC',
                              style: theme.textTheme.headline6!.merge(
                                TextStyle(
                                  color: theme.primaryColor,
                                ),
                              ),
                            ),
                            SizedBox(height: 2.scale),
                            Text(
                              'Escola de Engenharia Elétrica, Mecânica e da Computação',
                              style: theme.textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const ScoreWidget(score: 90),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
