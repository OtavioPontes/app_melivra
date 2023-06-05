import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/modules/esqueci_senha/presentation/controllers/recover_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pinput/pinput.dart';

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.scale),
            child: Column(
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.scale),
                  child: Text(
                    'O código de recuperação foi mandando no email cadastrado',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium!.merge(
                      TextStyle(
                        color: theme.colorScheme.background,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 40.scale),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.scale),
            child: Pinput(
              defaultPinTheme: PinTheme(
                width: 60.scale,
                height: 40.scale,
                decoration: BoxDecoration(
                  color: theme.colorScheme.background,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              length: 8,
              onChanged: (value) => controller.code = value,
            ),
          ),
          SizedBox(height: 40.scale),
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
    );
  }
}
