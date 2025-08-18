import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/modules/esqueci_senha/presentation/controllers/recover_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/widgets/textfield_inicio_widget.dart';

class UpdatePasswordPage extends StatelessWidget {
  const UpdatePasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<RecoverPasswordController>();
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 64.scale),
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Digite sua nova senha',
              style: theme.textTheme.headlineMedium!.merge(
                TextStyle(
                  color: theme.colorScheme.surface,
                ),
              ),
            ),
            SizedBox(height: 32.scale),
            TextFieldInicio(
              isPassword: true,
              controller: controller.passwordController,
              onChange: (value) => controller.password = value ?? "",
              fieldHint: 'Senha',
              prefixIcon: Icons.lock,
              validator: (value) {
                if ((value?.length ?? 0) < 8) {
                  return 'Tamanho mínimo de 8 caracteres';
                }
                return null;
              },
            ),
            SizedBox(height: 16.scale),
            TextFieldInicio(
              isPassword: true,
              controller: controller.passwordConfirmController,
              onChange: (value) =>
                  controller.passwordConfirmation = value ?? "",
              fieldHint: 'Confirme a Senha',
              prefixIcon: Icons.lock,
              validator: (value) {
                if ((value?.length ?? 0) < 8) {
                  return 'Tamanho mínimo de 8 caracteres';
                }
                return null;
              },
            ),
            SizedBox(height: 24.scale),
            Center(
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    // Change your radius here
                    borderRadius: BorderRadius.circular(12),
                  ),
                  fixedSize: Size(140.scale, 50.scale),
                  backgroundColor: theme.colorScheme.surface,
                ),
                onPressed: controller.updatePassword,
                child: Text(
                  'Enviar',
                  style: theme.textTheme.titleLarge!.merge(
                    TextStyle(
                      color: theme.primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
