import 'dart:convert';

import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/core/widgets/score_widget.dart';
import 'package:app_melivra/app/modules/home/presentation/bloc/ultimos_pesquisados_bloc.dart';
import 'package:app_melivra/app/modules/professores/data/model/professor_model.dart';
import 'package:app_melivra/app/modules/professores/domain/entities/professor_entity.dart';
import 'package:app_melivra/app/modules/professores_details/professores_details_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';

class CardInfoProfessor extends StatelessWidget {
  final Professor professor;
  final bool isTiny;
  const CardInfoProfessor({
    Key? key,
    required this.professor,
    this.isTiny = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Modular.get<UltimosPesquisadosBloc>();
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: isTiny ? size.width * 0.65 : size.width * 0.85,
      child: GestureDetector(
        onTap: () async {
          final rawData = await Hive.box('melivra').get('lastProfessors');
          final decodedData = rawData != null ? jsonDecode(rawData) : null;

          var professors = <Professor>[];
          if (decodedData != null) {
            professors = List.generate(
              decodedData.length,
              (index) => ProfessorModel.fromJson(
                decodedData[index],
              ).toEntity(),
            );
          }
          professors = professors.reversed.toList();
          if (professors.every((element) => element.id != professor.id)) {
            professors.add(professor);
            if (professors.length > 3) {
              professors.removeAt(0);
            }
            final inverted = professors.reversed.toList();
            await Hive.box('melivra').put(
              'lastProfessors',
              jsonEncode(
                inverted
                    .map((e) => ProfessorModel.fromEntity(e).toJson())
                    .toList(),
              ),
            );
            bloc.add(
              UltimosPesquisadosSuccessEvent(professors: inverted),
            );
          }

          await Modular.to.pushNamed(
            ProfessoresDetailsModule.routeName,
            arguments: {
              'id': professor.id,
            },
          );
        },
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(16.scale),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
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
                              professor.name,
                              maxLines: 2,
                              overflow: TextOverflow.clip,
                              style: theme.textTheme.titleMedium!.merge(
                                TextStyle(
                                  color: theme.primaryColor,
                                ),
                              ),
                            ),
                            SizedBox(height: 4.scale),
                            Text(
                              professor.instituto.initials ??
                                  professor.instituto.name,
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 16.scale),
                    ],
                  ),
                ),
                ScoreWidget(
                  score: professor.grades?.average ?? professor.averageGrade,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
