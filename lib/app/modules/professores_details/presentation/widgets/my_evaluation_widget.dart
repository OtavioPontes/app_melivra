import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/modules/professores_details/presentation/controllers/professor_details_controller.dart';
import 'package:flutter/material.dart';

import '../../../../core/style/colors.dart';

class MyEvaluation extends StatelessWidget {
  final ProfessorDetailsController controller;
  const MyEvaluation({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16.scale,
            vertical: 16.scale,
          ),
          width: size.width * 0.8,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(30),
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
          child: TextField(
            controller: controller.evaluationController,
            minLines: 2,
            maxLines: 2,
            decoration: InputDecoration(
              hintText: 'Escreva seu comentário...',
              hintStyle: theme.textTheme.bodyText2!.merge(
                TextStyle(
                  color: theme.disabledColor,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: GestureDetector(
            onTap: controller.updateProfessorEvaluation,
            child: CircleAvatar(
              radius: 25,
              backgroundColor: ColorsMeLivra().lightPurple,
              child: Icon(
                Icons.send,
                color: theme.primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
