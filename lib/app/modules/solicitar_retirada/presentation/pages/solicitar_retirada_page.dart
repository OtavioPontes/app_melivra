import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/modules/search/presentation/bloc/search_professor_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/style/assets.dart';
import '../../../../core/widgets/card_info_professor_widget.dart';
import '../controllers/solicitar_retirada_controller.dart';

class SolicitarRetiradaPage extends StatefulWidget {
  const SolicitarRetiradaPage({Key? key}) : super(key: key);

  @override
  State<SolicitarRetiradaPage> createState() => _SolicitarRetiradaPageState();
}

class _SolicitarRetiradaPageState extends State<SolicitarRetiradaPage> {
  final SolicitarRetiradaController controller =
      Modular.get<SolicitarRetiradaController>();

  bool hasProfessor = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
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
                      color: theme.backgroundColor,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.cancel,
                            color: theme.backgroundColor,
                            size: 40.scale,
                          ),
                          SizedBox(height: 16.scale),
                          Text(
                            'Solicitar Retirada',
                            style: theme.textTheme.headline5!.merge(
                              TextStyle(
                                color: theme.backgroundColor,
                              ),
                            ),
                          ),
                        ],
                      ),
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
                          padding: EdgeInsets.symmetric(
                            horizontal: 40.scale,
                            vertical: 24.scale,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 48.scale),
                              Text(
                                'Fale um pouco do motivo que o levou a solicitar a retirada, por favor:',
                                style: theme.textTheme.headline5!.merge(
                                  TextStyle(
                                    color: theme.backgroundColor,
                                  ),
                                ),
                              ),
                              SizedBox(height: 32.scale),
                              Center(
                                child: Container(
                                  padding: EdgeInsets.all(16.scale),
                                  decoration: BoxDecoration(
                                    color: theme.canvasColor,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  width: size.width * 0.85,
                                  child: TextField(
                                    controller:
                                        controller.descriptionController,
                                    minLines: 2,
                                    maxLines: 2,
                                    textAlignVertical: TextAlignVertical.top,
                                    decoration: InputDecoration(
                                      hintText: 'Descreva o motivo da retirada',
                                      hintStyle:
                                          theme.textTheme.bodyText1!.merge(
                                        TextStyle(color: theme.disabledColor),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 32.scale),
                              Text(
                                'Escolha o Professor',
                                style: theme.textTheme.headline5!.merge(
                                  TextStyle(
                                    color: theme.backgroundColor,
                                  ),
                                ),
                              ),
                              SizedBox(height: 16.scale),
                              Center(
                                child: Container(
                                  padding: EdgeInsets.only(
                                    left: 8.scale,
                                    top: 4.scale,
                                    bottom: 4.scale,
                                  ),
                                  decoration: BoxDecoration(
                                    color: theme.canvasColor,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  width: size.width * 0.85,
                                  child: TextField(
                                    controller: controller.searchController,
                                    onChanged: (value) {
                                      if (value.length > 1) {
                                        controller.resetLists();
                                        controller.getProfessores();
                                      }
                                    },
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(Icons.search),
                                      hintText: 'Pesquisar professor',
                                      hintStyle:
                                          theme.textTheme.bodyText1!.merge(
                                        TextStyle(color: theme.disabledColor),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 32.scale),
                              BlocBuilder(
                                bloc: controller.searchProfessorsBloc,
                                builder: (context, state) {
                                  if (state is SearchProfessorsLoadingState) {
                                    return CircularProgressIndicator(
                                      color: theme.backgroundColor,
                                    );
                                  }
                                  if (state is SearchProfessorsEmptyState) {
                                    return const SizedBox.shrink();
                                  }
                                  if (state is SearchProfessorsSuccessState) {
                                    final professors = state.professors;
                                    return ListView.separated(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            controller.selectedProfessor =
                                                professors[index];
                                            controller.dispose();
                                            setState(() {
                                              hasProfessor = true;
                                            });
                                          },
                                          child: AbsorbPointer(
                                            child: CardInfoProfessor(
                                              professor: professors[index],
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          SizedBox(height: 16.scale),
                                      itemCount: professors.length,
                                    );
                                  }
                                  return const SizedBox.shrink();
                                },
                              ),
                              if (controller.selectedProfessor != null)
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        AbsorbPointer(
                                          child: CardInfoProfessor(
                                            isTiny: true,
                                            professor:
                                                controller.selectedProfessor!,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 16.scale,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            controller.selectedProfessor = null;
                                            setState(() {});
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color: theme.errorColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 32.scale),
                                    Center(
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            // Change your radius here
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          fixedSize: Size(140.scale, 50.scale),
                                          backgroundColor:
                                              theme.backgroundColor,
                                        ),
                                        onPressed: () async {
                                          if (controller.descriptionController
                                              .text.isEmpty) {
                                            await Fluttertoast.showToast(
                                              msg:
                                                  "Por favor, descreva o motivo de retirada",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.redAccent,
                                              textColor: Colors.white,
                                              fontSize: 16.0,
                                            );
                                          } else {
                                            await controller
                                                .sendExclusionRequest();
                                            setState(() {});
                                          }
                                        },
                                        child: Text(
                                          'Enviar',
                                          style:
                                              theme.textTheme.headline6!.merge(
                                            TextStyle(
                                              color: theme.primaryColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        )
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
