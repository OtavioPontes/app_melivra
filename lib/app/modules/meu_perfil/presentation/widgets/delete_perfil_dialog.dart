import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/modules/meu_perfil/presentation/controllers/meu_perfil_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DeletePerfilDialog extends StatelessWidget {
  const DeletePerfilDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<MeuPerfilController>();
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
                    Icons.delete_forever,
                    size: 35.scale,
                    color: theme.colorScheme.error,
                  ),
                  SizedBox(height: 16.scale),
                  Text(
                    'Sua conta será deletada permanentemente!',
                    style: theme.textTheme.headlineSmall!.merge(
                      TextStyle(
                        color: theme.colorScheme.error,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 30.scale),
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
                          backgroundColor: theme.cardColor,
                        ),
                        onPressed: () {
                          controller.deleteProfile();
                          Modular.to.pop();
                        },
                        child: Text(
                          'Sim',
                          style: theme.textTheme.titleLarge,
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: theme.disabledColor,
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
