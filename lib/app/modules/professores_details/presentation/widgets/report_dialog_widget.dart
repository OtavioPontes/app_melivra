// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/modules/professores_details/presentation/controllers/evalute_professor_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ReportDialog extends StatefulWidget {
  final int id;
  const ReportDialog({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<ReportDialog> createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {
  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<EvaluateProfessorController>();
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Stack(
      children: [
        Dialog(
          elevation: 10,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            ),
            height: size.height * 0.5,
            width: size.width,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  SizedBox(height: 40.scale),
                  Text(
                    'Denunciar Comentário',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineSmall!.merge(
                      TextStyle(
                        color: theme.primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.scale),
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(16.scale),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: theme.colorScheme.onPrimary.withOpacity(0.2),
                            offset: const Offset(0, 3),
                            blurRadius: 1,
                            spreadRadius: 1,
                          ),
                        ],
                        color: theme.canvasColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      width: size.width * 0.6,
                      child: TextField(
                        controller: controller.reportController,
                        minLines: 3,
                        maxLines: 3,
                        textAlignVertical: TextAlignVertical.top,
                        style: theme.textTheme.bodySmall!.merge(
                          TextStyle(color: theme.colorScheme.onSecondary),
                        ),
                        decoration: InputDecoration(
                          hintText:
                              'Descreva o motivo da sua denúncia (ex.: Desrespeito, assédio, ...)',
                          hintStyle: theme.textTheme.bodySmall!.merge(
                            TextStyle(color: theme.disabledColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 64.scale),
                  TextButton(
                    style: TextButton.styleFrom(
                      fixedSize: Size(120.scale, 40.scale),
                      backgroundColor: theme.primaryColor,
                    ),
                    onPressed: () {
                      if (controller.reportController.text.isNotEmpty) {
                        controller.sendReport(id: widget.id).then(
                              (value) => Modular.to.pop(),
                            );
                      }
                    },
                    child: Text(
                      'Enviar',
                      style: theme.textTheme.titleLarge!.merge(
                        TextStyle(
                          color: theme.colorScheme.background,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.scale),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: size.height * 0.2 -
              MediaQuery.of(context).viewInsets.bottom * 0.5,
          width: size.width,
          child: CircleAvatar(
            backgroundColor: theme.primaryColor,
            radius: 30,
            child: const Icon(
              Icons.warning,
            ),
          ),
        ),
        Positioned(
          top: 50 - MediaQuery.of(context).viewInsets.bottom * 0.5,
          right: 20,
          child: GestureDetector(
            onTap: () {
              controller.reportController.clear();
              Modular.to.pop();
            },
            child: Icon(
              Icons.close,
              size: 50,
              color: theme.colorScheme.background,
            ),
          ),
        ),
      ],
    );
  }
}
