import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/core/widgets/score_widget.dart';
import 'package:app_melivra/app/modules/professores_details/professores_details_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CardInfoProfessor extends StatelessWidget {
  const CardInfoProfessor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.85,
      child: GestureDetector(
        onTap: () => Modular.to.pushNamed(ProfessoresDetailsModule.routeName),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(16.scale),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.school,
                    ),
                    SizedBox(width: 16.scale),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Professor 1',
                            style: theme.textTheme.headline6!.merge(
                              TextStyle(
                                color: theme.primaryColor,
                              ),
                            ),
                          ),
                          SizedBox(height: 2.scale),
                          Text(
                            'EMC',
                            style: theme.textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  ],
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
