import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/modules/perfil/presentation/controllers/perfil_controller.dart';

class LogoutDialog extends StatelessWidget {
  final PerfilController controller;
  const LogoutDialog({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);
    return Dialog(
      elevation: 10,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        height: size.height * 0.4,
        width: size.width * 0.8,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24.scale,
            vertical: 16.scale,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 16.scale),
              Icon(
                Icons.logout,
                size: 35.scale,
              ),
              SizedBox(height: 16.scale),
              Text(
                'Você vai deslogar do app',
                style: theme.textTheme.headline5!.merge(
                  TextStyle(color: theme.primaryColor),
                ),
              ),
              SizedBox(height: 24.scale),
              Text(
                'Tem certeza?',
                style: theme.textTheme.headline6,
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    style:
                        TextButton.styleFrom(backgroundColor: theme.cardColor),
                    onPressed: controller.logout,
                    child: Text(
                      'Sim',
                      style: theme.textTheme.headline6!.merge(
                        TextStyle(
                          color: theme.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                    ),
                    onPressed: Modular.to.pop,
                    child: Text(
                      'Não',
                      style: theme.textTheme.headline6!.merge(
                        TextStyle(
                          color: theme.cardColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
