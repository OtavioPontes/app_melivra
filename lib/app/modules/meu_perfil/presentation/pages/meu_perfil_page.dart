import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/core/style/assets.dart';
import 'package:app_melivra/app/modules/inicio/inicio_module.dart';
import 'package:app_melivra/app/modules/meu_perfil/presentation/bloc/meu_perfil_bloc.dart';
import 'package:app_melivra/app/modules/perfil/presentation/controllers/perfil_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../controllers/meu_perfil_controller.dart';
import '../widgets/delete_perfil_dialog.dart';

class MeuPerfilPage extends StatelessWidget {
  MeuPerfilPage({Key? key}) : super(key: key);
  final PerfilController controller = Modular.get<PerfilController>();
  final MeuPerfilController meuPerfilController =
      Modular.get<MeuPerfilController>();
  final bloc = Modular.get<MeuPerfilBloc>();

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
                      color: theme.colorScheme.surface,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocConsumer(
                      listener: (context, state) async {
                        if (state is MeuPerfilDeleteState) {
                          Modular.to.navigate(InicioModule.routeName);
                          await Fluttertoast.showToast(
                            msg: "Perfil deletado com sucesso ✅",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.greenAccent,
                            textColor: Colors.black,
                            fontSize: 12,
                          );
                          await meuPerfilController.store.clearUser();
                        }
                      },
                      bloc: bloc,
                      builder: (context, state) {
                        return Center(
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 40.scale,
                                backgroundColor: theme.colorScheme.surface,
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
                                padding:
                                    EdgeInsets.symmetric(horizontal: 32.scale),
                                child: Text(
                                  controller.user.name,
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.headlineSmall!.merge(
                                    TextStyle(
                                      color: theme.colorScheme.surface,
                                    ),
                                  ),
                                ),
                              ),
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
                              SizedBox(height: size.height * 0.12),
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
                                    backgroundColor: theme.colorScheme.surface,
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
                              SizedBox(height: 40.scale),
                              Center(
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: const BorderSide(
                                        color: Colors.red,
                                      ),
                                    ),
                                    fixedSize: Size(160.scale, 40.scale),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) =>
                                          const DeletePerfilDialog(),
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      SizedBox(width: 8.scale),
                                      Text(
                                        'Deletar a Conta',
                                        style:
                                            theme.textTheme.titleSmall!.merge(
                                          TextStyle(
                                            color: theme.colorScheme.surface,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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
          right: 8.scale,
        ),
        decoration: BoxDecoration(
          color: theme.canvasColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
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
