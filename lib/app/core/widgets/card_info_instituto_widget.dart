import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/core/widgets/score_widget.dart';
import 'package:app_melivra/app/modules/instituto_details/instituto_details_module.dart';
import 'package:app_melivra/app/modules/institutos/domain/entities/instituto_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CardInfoInstituto extends StatelessWidget {
  final Instituto instituto;
  const CardInfoInstituto({
    Key? key,
    required this.instituto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.85,
      child: GestureDetector(
        onTap: () => Modular.to.pushNamed(
          InstitutoDetailsModule.routeName,
          arguments: {
            'id': instituto.id,
          },
        ),
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
                              instituto.initials!,
                              style: theme.textTheme.titleMedium!.merge(
                                TextStyle(
                                  color: theme.primaryColor,
                                ),
                              ),
                            ),
                            SizedBox(height: 4.scale),
                            Text(
                              instituto.name,
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 16.scale),
                    ],
                  ),
                ),
                ScoreWidget(score: instituto.averageGrade),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
