import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/core/style/assets.dart';
import 'package:app_melivra/app/core/style/colors.dart';
import 'package:app_melivra/app/core/widgets/card_info_instituto_widget.dart';
import 'package:app_melivra/app/modules/ranking_institutos/ranking_institutos_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/widgets/score_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
                    'Olá, [Usuário]',
                    style: theme.textTheme.headline4!.merge(
                      TextStyle(
                        color: theme.colorScheme.background,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 32.scale),
                Center(
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 8.scale,
                      top: 4.scale,
                      bottom: 4.scale,
                    ),
                    decoration: BoxDecoration(
                      color: theme.canvasColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    width: size.width * 0.85,
                    child: TextField(
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: 'Pesquisar professor ou instituto',
                        hintStyle: theme.textTheme.bodyText1!
                            .merge(TextStyle(color: theme.disabledColor)),
                      ),
                    ),
                  ),
                ),
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
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return const CardInfoInstituto();
                            },
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 16.scale),
                            itemCount: 3,
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
