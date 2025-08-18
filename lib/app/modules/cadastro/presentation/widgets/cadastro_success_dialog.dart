import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../inicio/inicio_module.dart';
import '../../../login/login_module.dart';

class CadastroSuccessDialog extends StatelessWidget {
  const CadastroSuccessDialog({Key? key}) : super(key: key);

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
              borderRadius: BorderRadius.circular(50),
            ),
            height: 300.scale,
            width: size.width * 0.6,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  SizedBox(height: 64.scale),
                  Text(
                    'Cadastro realizado com Sucesso',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineSmall,
                  ),
                  const Spacer(),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                    ),
                    onPressed: () {
                      Modular.to.navigate(InicioModule.routeName);
                      Modular.to.pushNamed(LoginModule.routeName);
                    },
                    child: Text(
                      'Ok',
                      style: TextStyle(
                        color: theme.cardColor,
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
          top: size.height * 0.2,
          width: size.width,
          child: CircleAvatar(
            backgroundColor: theme.primaryColor,
            radius: 30,
            child: const Icon(
              Icons.check,
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
              color: theme.colorScheme.surface,
            ),
          ),
        ),
      ],
    );
  }
}
