import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/core/style/assets.dart';
import 'package:app_melivra/app/modules/perfil/presentation/controllers/perfil_controller.dart';
import 'package:app_melivra/app/modules/perfil/presentation/widgets/logout_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/bloc/user_bloc.dart';
import '../widgets/card_deslogar_widget.dart';
import '../widgets/card_meu_perfil_widget.dart';
import '../widgets/card_retirada_widget.dart';
import '../widgets/card_sobre_widget.dart';

class PerfilPage extends StatelessWidget {
  PerfilPage({Key? key}) : super(key: key);
  final PerfilController controller = Modular.get<PerfilController>();
  final UserBloc bloc = Modular.get<UserBloc>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: theme.primaryColor,
          statusBarIconBrightness: Brightness.light,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              top: 32.scale,
              bottom: 40.scale,
            ),
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder(
                  bloc: bloc,
                  builder: (context, state) {
                    return Center(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 40.scale,
                            backgroundColor: theme.colorScheme.background,
                            child: Text(
                              controller.nameInitials,
                              style: theme.textTheme.headlineMedium!.merge(
                                TextStyle(
                                  color: theme.colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16.scale),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.scale),
                            child: Text(
                              controller.user.name,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.headlineSmall!.merge(
                                TextStyle(
                                  color: theme.colorScheme.background,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(height: 24.scale),
                Stack(
                  children: [
                    SvgPicture.asset(
                      AssetsMeLivra.waveHome,
                      width: size.width,
                      fit: BoxFit.fill,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32.scale),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: size.height * 0.08),
                          const CardMeuPerfil(),
                          SizedBox(height: 16.scale),
                          const CardSobre(),
                          SizedBox(height: 16.scale),
                          const CardRetirada(),
                          SizedBox(height: 16.scale),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) =>
                                    LogoutDialog(controller: controller),
                              );
                            },
                            child: const CardDeslogar(),
                          ),
                        ],
                      ),
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
