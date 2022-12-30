import 'package:app_melivra/app/modules/professores_details/presentation/bloc/evaluate_professor_bloc.dart';
import 'package:app_melivra/app/modules/professores_details/presentation/controllers/evalute_professor_controller.dart';
import 'package:flutter/material.dart';

import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/modules/professores/domain/entities/professor_entity.dart';
import 'package:app_melivra/app/modules/professores_details/presentation/pages/evaluate_professor_page.dart';
import 'package:app_melivra/app/modules/professores_details/presentation/widgets/steppers_menu_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/style/assets.dart';

class EvaluateProfessorDialog extends StatelessWidget {
  final Professor professor;
  const EvaluateProfessorDialog({
    Key? key,
    required this.professor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EvaluateProfessorController controller =
        Modular.get<EvaluateProfessorController>();
    controller.setProfessor(professor);
    final Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);
    return Stack(
      children: [
        Dialog(
          elevation: 10,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            ),
            width: size.width * 0.9,
            height: size.height * 0.7,
            child: BlocBuilder(
                bloc: controller.bloc,
                builder: (context, state) {
                  if (state is EvaluateProfessorSuccessState) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.scale,
                        vertical: 40.scale,
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Avaliação feita com sucesso',
                            style: theme.textTheme.headline4,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 16.scale),
                          SvgPicture.asset(
                            AssetsMeLivra.success,
                          ),
                          SizedBox(height: 16.scale),
                          TextButton(
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                // Change your radius here
                                borderRadius: BorderRadius.circular(12),
                              ),
                              fixedSize: Size(80.scale, 40.scale),
                              backgroundColor: theme.primaryColor,
                            ),
                            onPressed: Modular.to.pop,
                            child: Text(
                              'Ok',
                              style: theme.textTheme.headline6!.merge(
                                TextStyle(
                                  color: theme.backgroundColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  if (state is EvaluateProfessorFailureState) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.scale,
                        vertical: 40.scale,
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 120.scale,
                            child: Opacity(
                              opacity: 0.3,
                              child: SvgPicture.asset(
                                AssetsMeLivra.failure,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                state.message,
                                style:
                                    theme.textTheme.headline4!.merge(TextStyle(
                                  color: theme.colorScheme.onPrimary,
                                )),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.visible,
                              ),
                              const Spacer(),
                              TextButton(
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    // Change your radius here
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  fixedSize: Size(80.scale, 40.scale),
                                  backgroundColor: theme.primaryColor,
                                ),
                                onPressed: Modular.to.pop,
                                child: Text(
                                  'Ok',
                                  style: theme.textTheme.headline6!.merge(
                                    TextStyle(
                                      color: theme.backgroundColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }
                  if (state is EvaluateProfessorLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Column(
                    children: [
                      SizedBox(height: 48.scale),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32.scale),
                        child: Text(
                          'Avalie ${professor.name.split(' ')[0]}',
                          style: theme.textTheme.headline5,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: 8.scale),
                      const EvaluateProfessorPage(),
                      const SteppersMenu(),
                    ],
                  );
                }),
          ),
        ),
        Positioned.fill(
          top: size.height * 0.05,
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: 80.scale,
              height: 80.scale,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  100,
                ),
                color: theme.backgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.onPrimary.withOpacity(0.2),
                    offset: const Offset(-1, 2),
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Icon(
                Icons.thumb_up,
                size: 50,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
