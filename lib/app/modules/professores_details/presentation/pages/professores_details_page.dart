import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/core/style/colors.dart';
import 'package:app_melivra/app/modules/professores_details/presentation/bloc/show_button_bloc.dart';
import 'package:app_melivra/app/modules/professores_details/presentation/controllers/evalute_professor_controller.dart';
import 'package:app_melivra/app/modules/professores_details/presentation/controllers/professor_details_controller.dart';
import 'package:app_melivra/app/modules/professores_details/presentation/widgets/draggable_evaluation_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/style/assets.dart';
import '../../../../core/widgets/score_big_widget.dart';
import '../../../../core/widgets/score_tiny_widget.dart';
import '../bloc/professor_details_bloc.dart';
import '../widgets/evaluate_professor_dialog_widget.dart';

class ProfessoresDetailsPage extends StatefulWidget {
  const ProfessoresDetailsPage({Key? key}) : super(key: key);

  @override
  State<ProfessoresDetailsPage> createState() => _ProfessoresDetailsPageState();
}

class _ProfessoresDetailsPageState extends State<ProfessoresDetailsPage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<ProfessorDetailsController>();
    final evaluateController = Modular.get<EvaluateProfessorController>();
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: theme.primaryColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: BlocBuilder(
        bloc: controller.bloc,
        builder: (context, state) {
          if (state is ProfessorDetailsSuccessState) {
            return BlocBuilder(
              bloc: controller.showButtonBloc,
              builder: (context, showState) {
                if (showState is ShowEvaluationButtonSuccessState) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: TextButton(
                      onPressed: () async {
                        await showDialog(
                          context: context,
                          builder: (context) {
                            return EvaluateProfessorDialog(
                              professor: state.professor,
                            );
                          },
                        );
                        evaluateController.dispose();
                      },
                      style: TextButton.styleFrom(
                        fixedSize: Size(70.scale, 70.scale),
                        backgroundColor: ColorsMeLivra().lightPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            50,
                          ),
                        ),
                      ),
                      child: const Icon(
                        Icons.thumb_up,
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: controller.pipeline,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(
                top: 32.scale,
                bottom: 80.scale,
              ),
              child: Stack(
                children: [
                  SvgPicture.asset(
                    AssetsMeLivra.waveHome,
                    width: size.width,
                    fit: BoxFit.fitWidth,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 40.scale,
                      bottom: 80.scale,
                    ),
                    child: Column(
                      children: [
                        BlocBuilder(
                          bloc: controller.bloc,
                          builder: (context, state) {
                            if (state is ProfessorDetailsEmptyState) {
                              return Padding(
                                padding: EdgeInsets.all(16.scale),
                                child: Column(
                                  children: [
                                    IconButton(
                                      highlightColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      onPressed: Modular.to.pop,
                                      icon: Icon(
                                        Icons.arrow_back_ios,
                                        size: 40.scale,
                                        color: theme.colorScheme.background,
                                      ),
                                    ),
                                    SizedBox(height: 64.scale),
                                    Center(
                                      child: Text(
                                        'Não encontramos nada aqui 😥',
                                        style:
                                            theme.textTheme.titleLarge!.merge(
                                          TextStyle(
                                            color: theme.colorScheme.background,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            if (state is ProfessorDetailsLoadingState) {
                              return Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: IconButton(
                                      highlightColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      onPressed: Modular.to.pop,
                                      icon: Icon(
                                        Icons.arrow_back_ios,
                                        size: 40.scale,
                                        color: theme.colorScheme.background,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 64.scale),
                                  Center(
                                    child: CircularProgressIndicator(
                                      color: theme.colorScheme.background,
                                    ),
                                  ),
                                ],
                              );
                            }
                            if (state is ProfessorDetailsSuccessState) {
                              final professor = state.professor;
                              return Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16.scale,
                                    ),
                                    child: Row(
                                      children: [
                                        IconButton(
                                          highlightColor: Colors.transparent,
                                          splashColor: Colors.transparent,
                                          onPressed: Modular.to.pop,
                                          icon: Icon(
                                            Icons.arrow_back_ios,
                                            size: 40.scale,
                                            color: theme.colorScheme.background,
                                          ),
                                        ),
                                        SizedBox(width: 16.scale),
                                        Flexible(
                                          child: Column(
                                            children: [
                                              Text(
                                                professor.name,
                                                textAlign: TextAlign.center,
                                                style: theme
                                                    .textTheme.headlineMedium!
                                                    .merge(
                                                  TextStyle(
                                                    color: theme
                                                        .colorScheme.background,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 16.scale),
                                              Text(
                                                professor.instituto.name,
                                                textAlign: TextAlign.center,
                                                style: theme
                                                    .textTheme.bodyMedium!
                                                    .merge(
                                                  TextStyle(
                                                    color: theme
                                                        .colorScheme.background,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 64.scale),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 40.scale),
                                  Card(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 32.scale,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 32.scale,
                                        horizontal: 16.scale,
                                      ),
                                      child: Column(
                                        children: [
                                          ScoreBigWidget(
                                            score: professor.averageGrade ??
                                                professor.grades?.average,
                                          ),
                                          SizedBox(height: 24.scale),
                                          BlocBuilder(
                                            bloc: controller.gradesBloc,
                                            builder: (context, state) {
                                              return Text(
                                                "${controller.gradesCount} avaliações",
                                                style: theme
                                                    .textTheme.labelSmall!
                                                    .merge(
                                                  TextStyle(
                                                    color: theme.disabledColor,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                          SizedBox(height: 16.scale),
                                          GridView.count(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 20,
                                            childAspectRatio: 2,
                                            padding:
                                                EdgeInsets.only(left: 32.scale),
                                            children: [
                                              const Center(
                                                child: Text(
                                                  'Organização do Quadro',
                                                ),
                                              ),
                                              ScoreTinyWidget(
                                                score: professor
                                                    .grades?.boardOrganization,
                                              ),
                                              const Center(
                                                child: Text(
                                                  'Clareza na Explicação',
                                                ),
                                              ),
                                              ScoreTinyWidget(
                                                score: professor
                                                    .grades?.clearExplanation,
                                              ),
                                              const Center(
                                                child: Text(
                                                  'Avaliação Coerente',
                                                ),
                                              ),
                                              ScoreTinyWidget(
                                                score: professor
                                                    .grades?.coherentEvaluation,
                                              ),
                                              const Center(
                                                child: Text(
                                                  'Tratamento Respeitoso',
                                                ),
                                              ),
                                              ScoreTinyWidget(
                                                score: professor.grades
                                                    ?.respectfulTreatment,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const DraggableEvaluation(),
        ],
      ),
    );
  }
}

class BadgeBottomSheet extends SliverPersistentHeaderDelegate {
  final double height;
  BadgeBottomSheet({
    this.height = 50,
  });
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final theme = Theme.of(context);
    return Material(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(20),
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxHeight: 8, maxWidth: 70),
          decoration: BoxDecoration(
            color: theme.primaryColor,
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}
