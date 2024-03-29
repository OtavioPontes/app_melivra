import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/core/style/assets.dart';
import 'package:app_melivra/app/core/widgets/card_info_instituto_widget.dart';
import 'package:app_melivra/app/core/widgets/search_widget.dart';
import 'package:app_melivra/app/modules/institutos/presentation/bloc/institutos_bloc.dart';
import 'package:app_melivra/app/modules/institutos/presentation/controllers/institutos_controller.dart';
import 'package:app_melivra/app/modules/professores/presentation/bloc/global_grade_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/widgets/score_widget.dart';

class InstitutosPage extends StatelessWidget {
  InstitutosPage({Key? key}) : super(key: key);
  final InstitutosController controller = Modular.get<InstitutosController>();

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
            onRefresh: () async => controller.pipeline(),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                top: 32.scale,
                bottom: 40.scale,
              ),
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SearchWidget(onlyInstitutos: true),
                  Stack(
                    children: [
                      Positioned(
                        height: size.height * 0.85,
                        child: SvgPicture.asset(
                          AssetsMeLivra.waveHome,
                          width: size.width,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      BlocBuilder(
                        bloc: controller.bloc,
                        builder: (context, state) {
                          if (state is InstitutosEmptyState) {
                            return Padding(
                              padding: EdgeInsets.all(16.scale),
                              child: Center(
                                child: Text(
                                  'Não encontramos nada aqui 😥',
                                  style: theme.textTheme.titleLarge!.merge(
                                    TextStyle(
                                      color: theme.colorScheme.background,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                          if (state is InstitutosLoadingState) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: theme.colorScheme.background,
                              ),
                            );
                          }
                          if (state is InstitutosSuccessState) {
                            final list =
                                state.institutes.getRange(0, 3).toList();
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
                                                controller.response!.totalItems
                                                    .toString(),
                                                style: theme
                                                    .textTheme.headlineMedium!
                                                    .merge(
                                                  TextStyle(
                                                    color: theme.primaryColor,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 12.scale),
                                              const Text('Institutos'),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 16.scale),
                                    BlocBuilder(
                                      bloc: controller.globalGradeBloc,
                                      builder: (context, state) {
                                        return ConstrainedBox(
                                          constraints: BoxConstraints(
                                            minHeight: 100.scale,
                                            minWidth: 120.scale,
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
                                                  ScoreWidget(
                                                    score: (state
                                                            is GlobalGradeSuccessState)
                                                        ? state.grade.average
                                                        : null,
                                                  ),
                                                  SizedBox(
                                                    height: 12.scale,
                                                  ),
                                                  Text(
                                                    'Nota média global',
                                                    style: theme
                                                        .textTheme.bodySmall!
                                                        .merge(
                                                      TextStyle(
                                                        color: theme.colorScheme
                                                            .onPrimary,
                                                      ),
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(height: size.height * 0.08),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 32.scale,
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.account_balance,
                                                color: theme
                                                    .colorScheme.background,
                                              ),
                                              SizedBox(width: 16.scale),
                                              Text(
                                                'Institutos',
                                                style: theme
                                                    .textTheme.headlineSmall!
                                                    .merge(
                                                  TextStyle(
                                                    color: theme
                                                        .colorScheme.background,
                                                  ),
                                                ),
                                              ),
                                            ],
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
                                          return CardInfoInstituto(
                                            instituto: item,
                                          );
                                        },
                                        separatorBuilder: (context, index) =>
                                            SizedBox(height: 16.scale),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }
                          return Padding(
                            padding: EdgeInsets.all(16.scale),
                            child: Center(
                              child: Text(
                                'Não encontramos nada aqui 😥',
                                style: theme.textTheme.titleLarge!.merge(
                                  TextStyle(
                                    color: theme.colorScheme.background,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
