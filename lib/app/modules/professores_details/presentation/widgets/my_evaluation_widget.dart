import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/modules/professores_details/presentation/controllers/professor_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:profanity_filter/profanity_filter.dart';

import '../../../../core/style/colors.dart';
import '../../../../core/utils/bad_words.dart';

class MyEvaluation extends StatefulWidget {
  const MyEvaluation({
    Key? key,
  }) : super(key: key);

  @override
  State<MyEvaluation> createState() => _MyEvaluationState();
}

class _MyEvaluationState extends State<MyEvaluation> {
  final _formKey = GlobalKey<FormState>();
  final controller = Modular.get<ProfessorDetailsController>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Form(
          key: _formKey,
          child: Container(
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
                  color: theme.colorScheme.onPrimary.withValues(alpha: 0.2),
                  offset: const Offset(-1, 2),
                  blurRadius: 5,
                  spreadRadius: 2,
                ),
              ],
              color: theme.cardColor,
            ),
            child: TextFormField(
              controller: controller.evaluationController,
              maxLength: 200,
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Escreva alguma coisa...';
                }
                final filter = ProfanityFilter.filterOnly(badWords);
                if (filter.hasProfanity(
                  value.replaceAll(RegExp(r'[\p{P}\p{S}]+', unicode: true), ''),
                )) {
                  return 'Comentário desrespeitoso ⛔';
                }
                return null;
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(right: 40.scale),
                counterText: '',
                hintText: 'Escreva seu comentário...',
                hintStyle: theme.textTheme.bodyMedium!.merge(
                  TextStyle(
                    color: theme.disabledColor,
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: GestureDetector(
            onTap: () {
              if (_formKey.currentState!.validate()) {
                controller.updateProfessorEvaluation();
              }
            },
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
