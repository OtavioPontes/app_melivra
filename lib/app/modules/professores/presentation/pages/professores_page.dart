import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/core/style/assets.dart';
import 'package:app_melivra/app/core/widgets/card_info_professor_widget.dart';
import 'package:app_melivra/app/modules/professores/presentation/controllers/professores_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/widgets/score_widget.dart';
import '../../../../core/widgets/search_widget.dart';
import '../bloc/professors_bloc.dart';

class ProfessoresPage extends StatelessWidget {
  ProfessoresPage({Key? key}) : super(key: key);
  final ProfessorsController controller = Modular.get<ProfessorsController>();

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SearchWidget(onlyProfessor: true),
                Stack(
                  children: [
                    Positioned(
                      height: size.height,
                      child: SvgPicture.asset(
                        AssetsMeLivra.waveHome,
                        width: size.width,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    BlocBuilder(
                      bloc: controller.bloc,
                      builder: (context, state) {
                        if (state is ProfessorsEmptyState) {
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
                        if (state is ProfessorsLoadingState) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: theme.backgroundColor,
                            ),
                          );
                        }
                        if (state is ProfessorsSuccessState) {
                          final list = state.professors.getRange(0, 3).toList();
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 32.scale),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                      minWidth: 100.scale,
                                      minHeight: 100.scale,
                                    ),
                                    child: Card(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 16.scale,
                                          vertical: 8.scale,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(height: 4.scale),
                                            Text(
                                              '10.451',
                                              style: theme.textTheme.headline4!
                                                  .merge(
                                                TextStyle(
                                                  color: theme.primaryColor,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 12.scale),
                                            const Text('Professores'),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 16.scale),
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                      minWidth: 100.scale,
                                      minHeight: 100.scale,
                                    ),
                                    child: Card(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 16.scale,
                                          vertical: 8.scale,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(height: 4.scale),
                                            const ScoreWidget(score: 79),
                                            SizedBox(height: 12.scale),
                                            Text(
                                              'Nota média global',
                                              style: theme.textTheme.caption!
                                                  .merge(
                                                TextStyle(
                                                  color: theme
                                                      .colorScheme.onPrimary,
                                                ),
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 40.scale),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 32.scale),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.school,
                                              color: theme.backgroundColor,
                                            ),
                                            SizedBox(width: 16.scale),
                                            Text(
                                              'Professores',
                                              style: theme.textTheme.headline5!
                                                  .merge(
                                                TextStyle(
                                                  color: theme.backgroundColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Icon(
                                          Icons.filter_list,
                                          color: theme.backgroundColor,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 32.scale),
                                    ListView.separated(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: list.length,
                                      itemBuilder: (context, index) {
                                        final item = list[index];
                                        return CardInfoProfessor(
                                          professor: item,
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          SizedBox(height: 16.scale),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
