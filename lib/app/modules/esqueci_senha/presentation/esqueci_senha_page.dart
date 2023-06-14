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
  const EsqueciSenhaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<RecoverPasswordController>();
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: size.height,
            minWidth: size.width,
          ),
          child: IntrinsicHeight(
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
                Positioned(
                  top: size.height * 0.05,
                  width: size.width,
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Stack(
                      children: [
                        SvgPicture.asset(
                          AssetsMeLivra.waveLogin,
                          alignment: Alignment.topCenter,
                          width: size.width,
                          height: size.height * 0.6,
                          fit: BoxFit.fill,
                          color: theme.primaryColor,
                        ),
                        Positioned.fill(
                          top: size.height * 0.12,
                          child: PageView(
                            controller: controller.pageController,
                            physics: const NeverScrollableScrollPhysics(),
                            children: const [
                              SendRecoverCodePage(),
                              ValidateRecoverCodePage(),
                              UpdatePasswordPage()
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
        ),
      ),
    );
  }
}
