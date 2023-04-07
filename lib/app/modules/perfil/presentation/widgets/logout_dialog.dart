import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/modules/perfil/presentation/controllers/perfil_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LogoutDialog extends StatelessWidget {
  final PerfilController controller;
  const LogoutDialog({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Stack(
      children: [
        Dialog(
          elevation: 10,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            height: 300.scale,
            width: size.width * 0.8,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 24.scale,
                vertical: 16.scale,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.scale),
                  Icon(
                    Icons.logout,
                    size: 35.scale,
                  ),
                  SizedBox(height: 16.scale),
                  Text(
                    'Você vai deslogar do app',
                    style: theme.textTheme.headlineSmall!.merge(
                      TextStyle(color: theme.primaryColor),
                    ),
                  ),
                  SizedBox(height: 40.scale),
                  Text(
                    'Tem certeza?',
                    style: theme.textTheme.headlineSmall,
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: theme.cardColor,),
                        onPressed: controller.logout,
                        child: Text(
                          'Sim',
                          style: theme.textTheme.titleLarge!.merge(
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
                          style: theme.textTheme.titleLarge!.merge(
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
        ),
        Positioned(
          top: 50 - MediaQuery.of(context).viewInsets.bottom * 0.5,
          right: 20,
          child: GestureDetector(
            onTap: Modular.to.pop,
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
