import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/modules/ranking_institutos/presentation/bloc/ranking_bloc.dart';
import 'package:app_melivra/app/modules/ranking_institutos/presentation/controllers/ranking_controller.dart';
import 'package:app_melivra/app/modules/ranking_institutos/presentation/widgets/ranking_navigation_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/style/assets.dart';
import '../../../../core/widgets/score_widget.dart';
import '../../../institutos/domain/entities/instituto_entity.dart';

class RankingPage extends StatelessWidget {
  RankingPage({Key? key}) : super(key: key);
  final RankController controller = Modular.get<RankController>();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 32.scale),
        child: Stack(
          children: [
            SvgPicture.asset(
              AssetsMeLivra.waveHome,
              width: size.width,
              fit: BoxFit.fitWidth,
            ),
            Padding(
              padding: EdgeInsets.only(top: 32.scale),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 24.scale),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onPressed: Modular.to.pop,
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 40.scale,
                            color: theme.backgroundColor,
                          ),
                        ),
                        SizedBox(width: 16.scale),
                        Flexible(
                          child: Text(
                            'Ranking dos Institutos',
                            style: theme.textTheme.headline4!.merge(
                              TextStyle(
                                color: theme.backgroundColor,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 40.scale),
                  Card(
                    margin: EdgeInsets.symmetric(horizontal: 32.scale),
                    child: Column(
                      children: [
                        BlocBuilder(
                          bloc: controller.bloc,
                          builder: (context, state) {
                            if (state is RankingEmptyState) {
                              return Padding(
                                padding: EdgeInsets.all(16.scale),
                                child: Center(
                                  child: Text(
                                    'Não encontramos nada aqui 😥',
                                    style: theme.textTheme.headline6!.merge(
                                      TextStyle(
                                        color: theme.backgroundColor,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                            if (state is RankingLoadingState) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (state is RankingSuccessState) {
                              final list = state.rankInstitutes;
                              return Column(
                                children: [
                                  ListView.separated(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 24.scale),
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: list.length,
                                    itemBuilder: (context, index) {
                                      final Instituto item = list[index];
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 24.scale,
                                          vertical: 8.scale,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    controller.page > 1
                                                        ? "${(index + 1) + controller.config!.itemsPerPage * (controller.page - 1)}º"
                                                        : "${(index + 1)}º",
                                                    style: theme
                                                        .textTheme.headline6!
                                                        .merge(
                                                      TextStyle(
                                                        color:
                                                            theme.primaryColor,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 24.scale),
                                                  Flexible(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          item.initials!,
                                                          style: theme.textTheme
                                                              .headline6!
                                                              .merge(
                                                            TextStyle(
                                                              color: theme
                                                                  .primaryColor,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            height: 2.scale),
                                                        Text(
                                                          item.name,
                                                          style: theme.textTheme
                                                              .caption,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            ScoreWidget(
                                              score: item.averageGrade,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        SizedBox(height: 16.scale),
                                  ),
                                  SizedBox(height: 8.scale),
                                  RankingMenu(controller: controller),
                                  SizedBox(height: 16.scale),
                                ],
                              );
                            }
                            return Padding(
                              padding: EdgeInsets.all(16.scale),
                              child: Center(
                                child: Text(
                                  'Não encontramos nada aqui 😥',
                                  style: theme.textTheme.headline6!.merge(
                                    TextStyle(
                                      color: theme.backgroundColor,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              right: 2.scale,
              top: size.height * 0.13,
              child: SvgPicture.asset(
                AssetsMeLivra.trophy,
                height: 85.scale,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
