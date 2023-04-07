import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/core/style/assets.dart';
import 'package:app_melivra/app/modules/perfil/presentation/controllers/perfil_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/bloc/user_bloc.dart';
import '../controllers/meu_perfil_controller.dart';

class MeuPerfilPage extends StatelessWidget {
  MeuPerfilPage({Key? key}) : super(key: key);
  final PerfilController controller = Modular.get<PerfilController>();
  final MeuPerfilController meuPerfilController =
      Modular.get<MeuPerfilController>();
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
            child: Stack(
              children: [
                Positioned(
                  left: 20.scale,
                  top: 10.scale,
                  child: GestureDetector(
                    onTap: Modular.to.pop,
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 40.scale,
                      color: theme.colorScheme.background,
                    ),
                  ),
                ),
                Column(
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
                              Text(
                                controller.user.name,
                                style: theme.textTheme.headlineSmall!.merge(
                                  TextStyle(
                                    color: theme.colorScheme.background,
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top: 20.scale,
                          child: SvgPicture.asset(
                            AssetsMeLivra.waveHome,
                            width: size.width,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32.scale),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 80.scale),
                              MeuPerfilTextField(
                                controller: meuPerfilController.nameController!,
                                fieldHint: 'Nome',
                                prefixIcon: Icons.person,
                              ),
                              SizedBox(height: 24.scale),
                              MeuPerfilTextField(
                                controller:
                                    meuPerfilController.emailController!,
                                fieldHint: 'Email',
                                prefixIcon: Icons.email,
                              ),
                              SizedBox(height: 64.scale),
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
                                  onPressed: meuPerfilController.updateProfile,
                                  child: Text(
                                    'Salvar',
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
                      ],
                    )
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

class MeuPerfilTextField extends StatelessWidget {
  final String fieldHint;
  final IconData prefixIcon;
  final String? Function(String? value)? validator;
  final TextEditingController controller;

  const MeuPerfilTextField({
    Key? key,
    required this.fieldHint,
    required this.prefixIcon,
    this.validator,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        padding: EdgeInsets.only(
          left: 8.scale,
          top: 4.scale,
          bottom: 4.scale,
        ),
        decoration: BoxDecoration(
          color: theme.canvasColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 1),
            )
          ],
        ),
        width: size.width * 0.8,
        child: TextFormField(
          onChanged: (value) {},
          controller: controller,
          validator: validator,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            prefixIcon: Icon(prefixIcon),
            hintText: fieldHint,
            hintStyle: theme.textTheme.bodyLarge!.merge(
              TextStyle(color: theme.disabledColor),
            ),
          ),
        ),
      ),
    );
  }
}
