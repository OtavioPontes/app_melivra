import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/modules/professores/domain/entities/professor_entity.dart';
import 'package:app_melivra/app/modules/professores_details/presentation/bloc/evaluate_professor_bloc.dart';
import 'package:app_melivra/app/modules/professores_details/presentation/controllers/evalute_professor_controller.dart';
import 'package:app_melivra/app/modules/professores_details/presentation/controllers/professor_details_controller.dart';
import 'package:app_melivra/app/modules/professores_details/presentation/pages/evaluate_professor_page.dart';
import 'package:app_melivra/app/modules/professores_details/presentation/widgets/steppers_menu_widget.dart';
import 'package:flutter/material.dart';
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
    final controller = Modular.get<EvaluateProfessorController>();
    final professorDetails = Modular.get<ProfessorDetailsController>();
    controller.setProfessor(professor);
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Dialog(
      elevation: 10,
      child: Container(
        height: size.height * 0.7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
        ),
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
                      style: theme.textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.scale),
                    SvgPicture.asset(
                      AssetsMeLivra.success,
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
                      onPressed: () {
                        professorDetails.pipeline();
                        Modular.to.pop();
                      },
                      child: Text(
                        'Ok',
                        style: theme.textTheme.titleLarge!.merge(
                          TextStyle(
                            color: theme.colorScheme.surface,
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
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16.scale),
                          child: Text(
                            state.message,
                            style: theme.textTheme.headlineMedium!.merge(
                              TextStyle(
                                color: theme.colorScheme.onPrimary,
                              ),
                            ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.visible,
                          ),
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
                            style: theme.textTheme.titleLarge!.merge(
                              TextStyle(
                                color: theme.colorScheme.surface,
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
                SizedBox(height: 24.scale),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.scale),
                  child: Text(
                    'Avalie ${professor.name.split(' ')[0]}',
                    style: theme.textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 16.scale),
                const EvaluateProfessorPage(),
                const SteppersMenu(),
              ],
            );
          },
        ),
      ),
    );
  }
}
