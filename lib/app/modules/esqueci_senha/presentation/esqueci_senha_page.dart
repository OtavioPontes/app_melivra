import 'package:app_melivra/app/core/assets/wave_login.dart';
import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/modules/esqueci_senha/presentation/controllers/recover_password_controller.dart';
import 'package:app_melivra/app/modules/esqueci_senha/presentation/send_recover_code_page.dart';
import 'package:app_melivra/app/modules/esqueci_senha/presentation/update_password_page.dart';
import 'package:app_melivra/app/modules/esqueci_senha/presentation/validate_recover_code_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/style/assets.dart';

class EsqueciSenhaPage extends StatelessWidget {
  EsqueciSenhaPage({Key? key}) : super(key: key);
  final controller = Modular.get<RecoverPasswordController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: size.width,
              child: Stack(
                children: [
                  Positioned(
                    top: 50.scale,
                    left: 30.scale,
                    child: GestureDetector(
                      onTap: () async {
                        if (controller.pageController.page == 0) {
                          Modular.to.pop();
                        } else {
                          await controller.pageController.previousPage(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.ease,
                          );
                        }
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 40.scale,
                      ),
                    ),
                  ),
                  Center(
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          AssetsMeLivra.logo,
                          width: 85.scale,
                          height: 85.scale,
                          fit: BoxFit.fitWidth,
                        ),
                        SizedBox(
                          height: 16.scale,
                        ),
                        Text(
                          'Me Livra',
                          style: theme.textTheme.displayMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.scale),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Stack(
                  children: [
                    CustomPaint(
                      painter: WaveLogin(),
                      size: Size(size.width, size.height * 0.8),
                    ),
                    Positioned.fill(
                      top: size.height * 0.12,
                      child: PageView(
                        controller: controller.pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: const [
                          SendRecoverCodePage(),
                          ValidateRecoverCodePage(),
                          UpdatePasswordPage(),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
