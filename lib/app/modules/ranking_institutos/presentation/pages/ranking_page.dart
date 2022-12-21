import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/style/assets.dart';
import '../../../../core/widgets/score_widget.dart';

class RankingPage extends StatelessWidget {
  const RankingPage({Key? key}) : super(key: key);

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
                        ListView.separated(
                          padding: EdgeInsets.symmetric(vertical: 24.scale),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 24.scale,
                                vertical: 8.scale,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${index + 1}º",
                                    style: theme.textTheme.headline6!.merge(
                                      TextStyle(
                                        color: theme.primaryColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 24.scale),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'EMC',
                                          style:
                                              theme.textTheme.headline6!.merge(
                                            TextStyle(
                                              color: theme.primaryColor,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 2.scale),
                                        Text(
                                          'Escola de Engenharia Elétrica, Mecânica e da Computação',
                                          style: theme.textTheme.caption,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 16.scale),
                                  const ScoreWidget(score: 90),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 16.scale),
                          itemCount: 5,
                        ),
                        SizedBox(height: 8.scale),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: const Icon(
                                Icons.arrow_back_ios,
                              ),
                            ),
                            SizedBox(width: 16.scale),
                            CircleAvatar(
                              backgroundColor: theme.primaryColor,
                              radius: 13,
                              child: const Text('1'),
                            ),
                            CircleAvatar(
                              backgroundColor: theme.cardColor,
                              radius: 13,
                              child: Text(
                                '2',
                                style: theme.textTheme.bodyText2!.merge(
                                  TextStyle(
                                    color: theme.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                              child: Text(
                                '...',
                                style: theme.textTheme.bodyText2!.merge(
                                  TextStyle(
                                    color: theme.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: theme.cardColor,
                              radius: 13,
                              child: Text(
                                '19',
                                style: theme.textTheme.bodyText2!.merge(
                                  TextStyle(
                                    color: theme.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: theme.cardColor,
                              radius: 13,
                              child: Text(
                                '20',
                                style: theme.textTheme.bodyText2!.merge(
                                  TextStyle(
                                    color: theme.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 16.scale),
                            GestureDetector(
                              onTap: () {},
                              child: const Icon(
                                Icons.arrow_forward_ios,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.scale),
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
