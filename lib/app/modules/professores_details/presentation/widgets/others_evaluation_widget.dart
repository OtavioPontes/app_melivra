import 'package:app_melivra/app/core/domain/entities/grade_response.dart';
import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/core/widgets/score_tiny_widget.dart';
import 'package:app_melivra/app/modules/professores_details/presentation/controllers/professor_details_controller.dart';
import 'package:app_melivra/app/modules/professores_details/presentation/widgets/report_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/style/colors.dart';

class OthersEvaluation extends StatelessWidget {
  final GradeResponse response;
  const OthersEvaluation({
    Key? key,
    required this.response,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<ProfessorDetailsController>();
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(
            24.scale,
            16.scale,
            24.scale,
            8.scale,
          ),
          width: size.width * 0.8,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              //bottomRight: Radius.circular(30),
              bottomRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.onPrimary.withOpacity(0.2),
                offset: const Offset(-1, 2),
                blurRadius: 5,
                spreadRadius: 2,
              )
            ],
            color: theme.cardColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ScoreTinyWidget(score: response.averageGrade),
                  SizedBox(width: 16.scale),
                  Flexible(
                    child: Text(
                      response.userName,
                      style: theme.textTheme.bodyLarge,
                    ),
                  )
                ],
              ),
              SizedBox(height: 16.scale),
              Text(
                response.description,
              ),
              Padding(
                padding: EdgeInsets.only(right: 32.scale),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () => controller.evaluateComment(
                        gradeId: response.id,
                        isLike: true,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.thumb_up,
                            color: ColorsMeLivra().green,
                            size: 20,
                          ),
                          SizedBox(width: 4.scale),
                          Text(
                            '(${response.likes})',
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8.scale),
                    GestureDetector(
                      onTap: () => controller.evaluateComment(
                        gradeId: response.id,
                        isLike: false,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.thumb_down,
                            color: ColorsMeLivra().red,
                            size: 20,
                          ),
                          SizedBox(width: 4.scale),
                          Text(
                            '(${response.dislikes})',
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return ReportDialog(id: response.id);
                },
              );
            },
            child: CircleAvatar(
              radius: 20,
              backgroundColor: ColorsMeLivra().yellow,
              child: Icon(
                Icons.warning,
                color: theme.colorScheme.background,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
