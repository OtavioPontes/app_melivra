import 'package:app_melivra/app/core/widgets/score_tiny_widget.dart';
import 'package:flutter/material.dart';

import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/style/assets.dart';
import '../../../../core/widgets/score_big_widget.dart';

class InstitutoDetailsPage extends StatelessWidget {
  const InstitutoDetailsPage({Key? key}) : super(key: key);

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
                            'Escola de Engenharia Elétrica, Mecânica e da Computação',
                            style: theme.textTheme.headline5!.merge(
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
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 32.scale, horizontal: 16.scale),
                      child: Column(
                        children: [
                          const ScoreBigWidget(score: 95),
                          SizedBox(height: 32.scale),
                          GridView.count(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            childAspectRatio: 1.8,
                            crossAxisSpacing: 20,
                            padding: EdgeInsets.only(left: 32.scale),
                            children: const [
                              Center(
                                child: Text('Qualidade da Aula'),
                              ),
                              ScoreTinyWidget(score: 45),
                              Center(
                                child: Text('Qualidade da Aula'),
                              ),
                              ScoreTinyWidget(score: 85),
                              Center(
                                child: Text('Qualidade da Aula'),
                              ),
                              ScoreTinyWidget(score: 65),
                              Center(
                                child: Text('Qualidade da Aula'),
                              ),
                              ScoreTinyWidget(score: 100),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
