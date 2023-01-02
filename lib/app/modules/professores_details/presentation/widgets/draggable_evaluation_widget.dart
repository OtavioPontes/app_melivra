import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/modules/professores_details/presentation/controllers/professor_details_controller.dart';
import 'package:app_melivra/app/modules/professores_details/presentation/widgets/others_evaluation_widget.dart';

import '../../../../core/style/assets.dart';
import '../bloc/professor_grades_bloc.dart';
import '../pages/professores_details_page.dart';
import 'my_evaluation_widget.dart';

class DraggableEvaluation extends StatefulWidget {
  final ProfessorDetailsController controller;
  const DraggableEvaluation({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<DraggableEvaluation> createState() => _DraggableEvaluationState();
}

class _DraggableEvaluationState extends State<DraggableEvaluation> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    return DraggableScrollableSheet(
      controller: widget.controller.scrollableController,
      maxChildSize: 0.9,
      initialChildSize: 0.15,
      minChildSize: 0.1,
      builder: (context, scrollController) {
        widget.controller.scrollableController?.addListener(
          () {
            if (scrollController.position.viewportDimension >
                size.height * 0.17) {
              widget.controller.setShowButton(false);
            } else {
              widget.controller.setShowButton(true);
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
                            color: theme.cardColor,
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
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.chat,
                                  color: theme.colorScheme.onPrimary,
                                ),
                                SizedBox(width: 32.scale),
                                Flexible(
                                  child: Text(
                                    'Avaliações e Comentários',
                                    style: theme.textTheme.headline5!,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 32.scale),
                          BlocBuilder(
                            bloc: widget.controller.gradesBloc,
                            builder: (context, state) {
                              if (state is ProfessorGradesEmptyState ||
                                  state is ProfessorGradesFailureState) {
                                return Center(
                                  child: Text(
                                    'Não encontramos nada aqui 😥',
                                    style: theme.textTheme.headline6!.merge(
                                      TextStyle(
                                        color: theme.primaryColor,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              if (state is ProfessorGradesLoadingState) {
                                return Column(
                                  mainAxisSize: MainAxisSize.max,
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
                                          color: theme.backgroundColor,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 64.scale),
                                    Center(
                                      child: CircularProgressIndicator(
                                          color: theme.backgroundColor),
                                    ),
                                  ],
                                );
                              }
                              if (state is ProfessorGradesSuccessState) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const MyEvaluation(),
                                    SizedBox(height: 32.scale),
                                    ListView.separated(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: state.grades.length,
                                      itemBuilder: (context, index) {
                                        final item = state.grades[index];
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
