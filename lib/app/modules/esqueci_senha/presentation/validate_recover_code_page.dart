import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/modules/esqueci_senha/presentation/controllers/recover_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ValidateRecoverCodePage extends StatelessWidget {
  const ValidateRecoverCodePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = Modular.get<RecoverPasswordController>();
    return WillPopScope(
      onWillPop: () async {
        await controller.pageController.previousPage(
          duration: const Duration(milliseconds: 200),
          curve: Curves.ease,
        );
        return false;
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 48.scale),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Digite seu Código',
              style: theme.textTheme.headlineMedium!.merge(
                TextStyle(
                  color: theme.colorScheme.background,
                ),
              ),
            ),
            SizedBox(height: 16.scale),
            Text(
              'O código de recuperação foi mandando no email cadastrado',
              style: theme.textTheme.bodyMedium!.merge(
                TextStyle(
                  color: theme.colorScheme.background,
                ),
              ),
            ),
            SizedBox(height: 32.scale),
            PinCodeTextField(
              appContext: context,
              length: 6,
              animationType: AnimationType.fade,
              dialogConfig: DialogConfig(
                affirmativeText: 'Colar',
                negativeText: 'Cancelar',
                dialogContent: 'Gostaria de colar o código: ',
                dialogTitle: 'Colar Código',
              ),
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                fieldWidth: 40.scale,
                fieldHeight: 50.scale,
                borderRadius: BorderRadius.circular(10),
                inactiveColor: theme.colorScheme.background,
                inactiveFillColor: theme.colorScheme.background,
                activeColor: theme.colorScheme.background,
                activeFillColor: theme.colorScheme.background,
                selectedFillColor: theme.colorScheme.background,
                selectedColor: theme.colorScheme.background,
              ),
              textStyle: theme.textTheme.bodyLarge,
              enableActiveFill: true,
              onChanged: (value) => controller.code = value,
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
                  backgroundColor: theme.colorScheme.background,
                ),
                onPressed: controller.validateRecoverCode,
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
