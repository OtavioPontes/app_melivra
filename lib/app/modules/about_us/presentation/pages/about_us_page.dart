import 'package:app_melivra/app/core/utils/appinfo.dart';
import 'package:app_melivra/app/modules/sobre_app/presentation/widgets/card_autores_widget.dart';
import 'package:app_melivra/app/modules/sobre_app/presentation/widgets/card_sugestoes_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/core/style/assets.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

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
            child: Stack(
              children: [
                Positioned(
                  left: 20.scale,
                  top: 10.scale,
                  child: GestureDetector(
                    onTap: Modular.to.pop,
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 40.scale,
                      color: theme.backgroundColor,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.developer_mode_rounded,
                            color: theme.backgroundColor,
                            size: 40.scale,
                          ),
                          SizedBox(height: 16.scale),
                          Text(
                            'Quem somos',
                            style: theme.textTheme.headline5!.merge(
                              TextStyle(
                                color: theme.backgroundColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top: 20.scale,
                          child: SvgPicture.asset(
                            AssetsMeLivra.waveHome,
                            width: size.width,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 80.scale,
                            horizontal: 40.scale,
                          ),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CircleAvatar(
                                    radius: 50,
                                    foregroundImage: NetworkImage(
                                      'https://avatars.githubusercontent.com/u/39846965?v=4',
                                    ),
                                  ),
                                  SizedBox(width: 32.scale),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Otávio Pontes',
                                          style:
                                              theme.textTheme.headline5!.merge(
                                            TextStyle(
                                              color: theme.backgroundColor,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8.scale),
                                        Text(
                                          'Desenvolvedor Mobile',
                                          style:
                                              theme.textTheme.bodyText2!.merge(
                                            TextStyle(
                                              color: theme.backgroundColor,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 16.scale),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            GestureDetector(
                                              onTap: () => launchUrl(
                                                Uri(
                                                  scheme: 'https',
                                                  host: 'github.com',
                                                  path: 'OtavioPontes',
                                                ),
                                                mode: LaunchMode
                                                    .externalApplication,
                                                webOnlyWindowName: '_blank',
                                              ),
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    theme.backgroundColor,
                                                child: SvgPicture.asset(
                                                  AssetsMeLivra.github,
                                                  height: 30.scale,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 16.scale),
                                            GestureDetector(
                                              onTap: () => launchUrl(
                                                Uri(
                                                  scheme: 'https',
                                                  host: 'linkedin.com',
                                                  path: 'in/otavio-pontes',
                                                ),
                                                mode: LaunchMode
                                                    .externalApplication,
                                                webOnlyWindowName: '_blank',
                                              ),
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    theme.backgroundColor,
                                                child: SvgPicture.asset(
                                                  AssetsMeLivra.linkedin,
                                                  fit: BoxFit.cover,
                                                  height: 40.scale,
                                                  color:
                                                      const Color(0xFF0077B5),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 80.scale),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Thiago de Mello',
                                          style:
                                              theme.textTheme.headline5!.merge(
                                            TextStyle(
                                              color: theme.backgroundColor,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8.scale),
                                        Text(
                                          'Desenvolvedor Backend',
                                          style:
                                              theme.textTheme.bodyText2!.merge(
                                            TextStyle(
                                              color: theme.backgroundColor,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 16.scale),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              onTap: () => launchUrl(
                                                Uri(
                                                  scheme: 'https',
                                                  host: 'github.com',
                                                  path: 'thiago-mello',
                                                ),
                                                mode: LaunchMode
                                                    .externalApplication,
                                                webOnlyWindowName: '_blank',
                                              ),
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    theme.backgroundColor,
                                                child: SvgPicture.asset(
                                                  AssetsMeLivra.github,
                                                  height: 30.scale,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 16.scale),
                                            GestureDetector(
                                              onTap: () => launchUrl(
                                                Uri(
                                                  scheme: 'https',
                                                  host: 'linkedin.com',
                                                  path: 'in/thiago-de-mello',
                                                ),
                                                mode: LaunchMode
                                                    .externalApplication,
                                                webOnlyWindowName: '_blank',
                                              ),
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    theme.backgroundColor,
                                                child: SvgPicture.asset(
                                                  AssetsMeLivra.linkedin,
                                                  fit: BoxFit.cover,
                                                  height: 40.scale,
                                                  color:
                                                      const Color(0xFF0077B5),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 32.scale),
                                  const CircleAvatar(
                                    radius: 50,
                                    foregroundImage: NetworkImage(
                                      'https://avatars.githubusercontent.com/u/36369156?v=4',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
