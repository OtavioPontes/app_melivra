import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/core/style/assets.dart';
import 'package:app_melivra/app/core/style/colors.dart';
import 'package:app_melivra/app/core/widgets/card_info_instituto_widget.dart';
import 'package:app_melivra/app/modules/home/presentation/bloc/top_institutos_bloc.dart';
import 'package:app_melivra/app/modules/home/presentation/controllers/home_controller.dart';
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
                Padding(
                  padding: EdgeInsets.only(left: 32.scale),
                  child: Text(
                    'Olá, ${controller.store.loggedUser?.name}',
                    style: theme.textTheme.headline4!.merge(
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
                                  color: theme.backgroundColor,
                                ),
                                SizedBox(width: 8.scale),
                                Text(
                                  'Mais Pesquisados',
                                  style: theme.textTheme.headline5!.merge(
                                    TextStyle(
                                      color: theme.backgroundColor,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 32.scale),
                          SizedBox(
                            height: 100.scale,
                            child: ListView.separated(
                              separatorBuilder: (context, index) =>
                                  SizedBox(width: 16.scale),
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: 3,
                              clipBehavior: Clip.none,
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  height: 100.scale,
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
                                          const ScoreWidget(score: 60),
                                          SizedBox(height: 12.scale),
                                          const Text('Professor 3'),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 40.scale),
                          InkWell(
                            onTap: () => Modular.to
                                .pushNamed(RankingInstitutosModule.routeName),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      style: theme.textTheme.headline5!.merge(
                                        TextStyle(
                                          color: theme.backgroundColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: theme.backgroundColor,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 32.scale),
                          BlocBuilder(
                            bloc: controller.bloc,
                            builder: (context, state) {
                              if (state.runtimeType ==
                                  TopInstitutosLoadingState) {
                                return CircularProgressIndicator(
                                  color: theme.backgroundColor,
                                );
                              }
                              if (state.runtimeType ==
                                  TopInstitutosEmptyState) {
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
                              if (state.runtimeType ==
                                  TopInstitutosSuccessState) {
                                final institutes =
                                    (state as TopInstitutosSuccessState)
                                        .rankInstitutes;
                                return ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
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
    );
  }
}
