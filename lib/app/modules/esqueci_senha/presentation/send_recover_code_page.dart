import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/modules/esqueci_senha/presentation/controllers/recover_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/widgets/textfield_inicio_widget.dart';

class SendRecoverCodePage extends StatelessWidget {
  const SendRecoverCodePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<RecoverPasswordController>();
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 64.scale),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Esqueci minha senha',
              style: theme.textTheme.headlineMedium!.merge(
                TextStyle(
                  color: theme.colorScheme.surface,
                ),
              ),
            ),
            SizedBox(height: 16.scale),
            Text(
              'Insira seu email e logo mandaremos o código de recuperação',
              style: theme.textTheme.bodyMedium!.merge(
                TextStyle(
                  color: theme.colorScheme.surface,
                ),
              ),
            ),
            SizedBox(height: 32.scale),
            TextFieldInicio(
              onChange: (value) => controller.email = value ?? "",
              fieldHint: 'Email',
              prefixIcon: Icons.email,
            ),
            SizedBox(height: 32.scale),
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
                onPressed: controller.sendRecoverCode,
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
