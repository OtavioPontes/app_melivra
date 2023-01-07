import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ReportDialog extends StatelessWidget {
  const ReportDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);
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
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: 40.scale),
                  Text(
                    'Denunciar Comentário',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headline5!.merge(
                      TextStyle(
                        color: theme.primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.scale),
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
                        minLines: 3,
                        maxLines: 3,
                        textAlignVertical: TextAlignVertical.top,
                        style: theme.textTheme.caption!.merge(
                          TextStyle(color: theme.colorScheme.onSecondary),
                        ),
                        decoration: InputDecoration(
                          hintText:
                              'Descreva o motivo da sua denúncia (ex.: Desrespeito, assédio, ...)',
                          hintStyle: theme.textTheme.caption!.merge(
                            TextStyle(color: theme.disabledColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    style: TextButton.styleFrom(
                      fixedSize: Size(120.scale, 40.scale),
                      backgroundColor: theme.primaryColor,
                    ),
                    onPressed: () {},
                    child: Text(
                      'Enviar',
                      style: theme.textTheme.headline6!.merge(
                        TextStyle(
                          color: theme.backgroundColor,
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
            onTap: Modular.to.pop,
            child: Icon(
              Icons.close,
              size: 50,
              color: theme.backgroundColor,
            ),
          ),
        ),
      ],
    );
  }
}
