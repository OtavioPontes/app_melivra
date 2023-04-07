import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/core/style/assets.dart';
import 'package:app_melivra/app/core/style/colors.dart';
import 'package:app_melivra/app/core/widgets/card_info_instituto_widget.dart';
import 'package:app_melivra/app/modules/home/presentation/bloc/top_institutos_bloc.dart';
import 'package:app_melivra/app/modules/home/presentation/bloc/ultimos_pesquisados_bloc.dart';
import 'package:app_melivra/app/modules/home/presentation/controllers/home_controller.dart';
import 'package:app_melivra/app/modules/professores_details/professores_details_module.dart';
import 'package:app_melivra/app/modules/ranking_institutos/ranking_institutos_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/widgets/score_widget.dart';
import '../../../../core/widgets/search_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final HomeController controller = Modular.get<HomeController>();
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
          child: RefreshIndicator(
            onRefresh: controller.pipeline,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                top: 32.scale,
                bottom: 40.scale,
              ),
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 32.scale),
                    child: Text(
                      'Olá, ${controller.store.loggedUser?.name}',
                      style: theme.textTheme.headlineMedium!.merge(
                        TextStyle(
                          color: theme.colorScheme.background,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 32.scale),
                  const SearchWidget(),
                  SizedBox(height: 24.scale),
                  Stack(
                    children: [
                      SvgPicture.asset(
                        AssetsMeLivra.waveHome,
                        width: size.width,
                        fit: BoxFit.fitWidth,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32.scale),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: 40.scale,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.search,
                                    color: theme.colorScheme.background,
                                  ),
                                  SizedBox(width: 8.scale),
                                  Text(
                                    'Últimos Pesquisados',
                                    style: theme.textTheme.headlineSmall!.merge(
                                      TextStyle(
                                        color: theme.colorScheme.background,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 32.scale),
                            BlocBuilder(
                              bloc: controller.ultimosPesquisadosBloc,
                              builder: (context, state) {
                                if (state is UltimosPesquisadosLoadingState) {
                                  return Padding(
                                    padding: EdgeInsets.all(8.scale),
                                    child: CircularProgressIndicator(
                                      color: theme.colorScheme.background,
                                    ),
                                  );
                                }
                                if (state is UltimosPesquisadosEmptyState) {
                                  return Card(
                                    child: Padding(
                                      padding: EdgeInsets.all(16.scale),
                                      child: Center(
                                        child: Text(
                                          'Você ainda não pesquisou professor 😥',
                                          style:
                                              theme.textTheme.titleLarge!.merge(
                                            TextStyle(
                                              color: theme.primaryColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                if (state is UltimosPesquisadosSuccessState) {
                                  return SizedBox(
                                    height: 120.scale,
                                    child: ListView.separated(
                                      separatorBuilder: (context, index) =>
                                          SizedBox(width: 16.scale),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: state.professors.length,
                                      clipBehavior: Clip.none,
                                      itemBuilder: (context, index) {
                                        final item = state.professors[index];
                                        return GestureDetector(
                                          onTap: () => Modular.to.pushNamed(
                                            ProfessoresDetailsModule.routeName,
                                            arguments: {
                                              'id': state.professors[index].id
                                            },
                                          ),
                                          child: SizedBox(
                                            width: 150.scale,
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
                                                    ScoreWidget(
                                                      score: item.grades
                                                              ?.average ??
                                                          item.averageGrade,
                                                    ),
                                                    SizedBox(height: 16.scale),
                                                    Flexible(
                                                      child: Text(
                                                        state.professors[index]
                                                            .name,
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                            SizedBox(height: 40.scale),
                            InkWell(
                              onTap: () => Modular.to
                                  .pushNamed(RankingInstitutosModule.routeName),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: ColorsMeLivra().yellow,
                                      ),
                                      SizedBox(width: 8.scale),
                                      Text(
                                        'Top Institutos',
                                        style: theme.textTheme.headlineSmall!
                                            .merge(
                                          TextStyle(
                                            color: theme.colorScheme.background,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: theme.colorScheme.background,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 32.scale),
                            BlocBuilder(
                              bloc: controller.topInstitutosBloc,
                              builder: (context, state) {
                                if (state is TopInstitutosLoadingState) {
                                  return CircularProgressIndicator(
                                    color: theme.colorScheme.background,
                                  );
                                }
                                if (state is TopInstitutosEmptyState) {
                                  return Padding(
                                    padding: EdgeInsets.all(16.scale),
                                    child: Center(
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
                                  );
                                }
                                if (state is TopInstitutosSuccessState) {
                                  final institutes = state.rankInstitutes;
                                  return ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return CardInfoInstituto(
                                        instituto: institutes[index],
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        SizedBox(height: 16.scale),
                                    itemCount: institutes.length,
                                  );
                                }
                                return const SizedBox.shrink();
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
