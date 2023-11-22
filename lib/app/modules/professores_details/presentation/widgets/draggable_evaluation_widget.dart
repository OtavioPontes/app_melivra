import 'dart:math';

import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/modules/professores_details/presentation/controllers/professor_details_controller.dart';
import 'package:app_melivra/app/modules/professores_details/presentation/widgets/others_evaluation_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/style/assets.dart';
import '../bloc/professor_grades_bloc.dart';
import '../pages/professores_details_page.dart';
import 'my_evaluation_widget.dart';

class DraggableEvaluation extends StatefulWidget {
  const DraggableEvaluation({
    Key? key,
  }) : super(key: key);

  @override
  State<DraggableEvaluation> createState() => _DraggableEvaluationState();
}

class _DraggableEvaluationState extends State<DraggableEvaluation> {
  final controller = Modular.get<ProfessorDetailsController>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return DraggableScrollableSheet(
      controller: controller.scrollableController,
      maxChildSize: 0.9,
      initialChildSize: 0.15,
      minChildSize: 0.1,
      builder: (context, scrollController) {
        controller.scrollableController?.addListener(
          () {
            if (scrollController.position.viewportDimension >
                size.height * 0.17) {
              controller.setShowButton(showButton: false);
            } else {
              controller.setShowButton(showButton: true);
            }
          },
        );
        return Material(
          elevation: 10,
          color: theme.primaryColor,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.scale),
          ),
          child: CustomScrollView(
            physics: const ClampingScrollPhysics(),
            controller: scrollController,
            slivers: [
              SliverPersistentHeader(
                delegate: BadgeBottomSheet(),
                pinned: true,
              ),
              SliverToBoxAdapter(
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.primaryColor,
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        child: Transform.rotate(
                          angle: -pi,
                          child: SvgPicture.asset(
                            AssetsMeLivra.waveChat,
                            colorFilter: ColorFilter.mode(
                              theme.cardColor,
                              BlendMode.srcATop,
                            ),
                            width: size.width,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(height: 16.scale),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 24.scale,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Icon(
                                    Icons.chat,
                                    color: theme.colorScheme.onPrimary,
                                    size: 25,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Avaliações e Comentários',
                                    textAlign: TextAlign.center,
                                    textScaleFactor: 1,
                                    style: theme.textTheme.headlineSmall,
                                  ),
                                ),
                                const Expanded(child: SizedBox()),
                              ],
                            ),
                          ),
                          SizedBox(height: 32.scale),
                          const MyEvaluation(),
                          BlocBuilder(
                            bloc: controller.gradesBloc,
                            builder: (context, state) {
                              if (state is ProfessorGradesBadWordState) {
                                return Padding(
                                  padding: EdgeInsets.all(8.scale),
                                  child: Text(
                                    'Não é permitido fazer comentários de natureza desrespeitosa ⛔',
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.titleLarge!.merge(
                                      TextStyle(
                                        color: theme.colorScheme.background,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                          SizedBox(height: 16.scale),
                          BlocBuilder(
                            bloc: controller.gradesBloc,
                            builder: (context, state) {
                              if (state is ProfessorGradesFailureState) {
                                return Padding(
                                  padding: EdgeInsets.all(16.scale),
                                  child: Center(
                                    child: Text(
                                      state.message,
                                      textAlign: TextAlign.center,
                                      style: theme.textTheme.titleLarge!.merge(
                                        TextStyle(
                                          color: theme.colorScheme.background,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                              if (state is ProfessorGradesLoadingState) {
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
                              if (state is ProfessorGradesEmptyState) {
                                return Padding(
                                  padding: EdgeInsets.all(40.scale),
                                  child: Text(
                                    'Ainda não há comentários, seja o primeiro a comentar 😎',
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      color: theme.colorScheme.background,
                                    ),
                                  ),
                                );
                              }
                              if (state is ProfessorGradesSuccessState) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListView.separated(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: state.grades.length,
                                      itemBuilder: (context, index) {
                                        final item = state.grades[index];
                                        if (item.description.isEmpty) {
                                          return const SizedBox.shrink();
                                        }
                                        return Center(
                                          child:
                                              OthersEvaluation(response: item),
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                        height: 16.scale,
                                      ),
                                    ),
                                    SizedBox(height: 32.scale),
                                  ],
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
