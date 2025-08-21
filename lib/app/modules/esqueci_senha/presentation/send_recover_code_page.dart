import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/core/utils/validators.dart';
import 'package:app_melivra/app/modules/esqueci_senha/presentation/controllers/recover_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/widgets/textfield_inicio_widget.dart';

class SendRecoverCodePage extends StatefulWidget {
  const SendRecoverCodePage({Key? key}) : super(key: key);

  @override
  State<SendRecoverCodePage> createState() => _SendRecoverCodePageState();
}

class _SendRecoverCodePageState extends State<SendRecoverCodePage> {
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<RecoverPasswordController>();
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 64.scale),
        child: Form(
          key: formkey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                validator: (value) => Validators.validateEmail(
                  value,
                  validateCollege: false,
                ),
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
                    backgroundColor: formkey.currentState?.validate() == true
                        ? theme.colorScheme.surface
                        : theme.disabledColor,
                  ),
                  onPressed: () {
                    if (formkey.currentState?.validate() ?? false) {
                      controller.sendRecoverCode();
                    }
                  },
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
      ),
    );
  }
}
