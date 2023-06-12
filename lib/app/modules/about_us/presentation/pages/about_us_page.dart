import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/core/style/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

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
                      color: theme.colorScheme.background,
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
                            color: theme.colorScheme.background,
                            size: 40.scale,
                          ),
                          SizedBox(height: 16.scale),
                          Text(
                            'Quem somos',
                            style: theme.textTheme.headlineSmall!.merge(
                              TextStyle(
                                color: theme.colorScheme.background,
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
                                  Column(
                                    children: [
                                      const CircleAvatar(
                                        radius: 50,
                                        foregroundImage: NetworkImage(
                                          'https://avatars.githubusercontent.com/u/39846965?v=4',
                                        ),
                                      ),
                                      SizedBox(height: 8.scale),
                                      Row(
                                        children: [
                                          Text(
                                            '#Flutter',
                                            style: theme.textTheme.bodySmall!
                                                .merge(
                                              TextStyle(
                                                color: theme
                                                    .colorScheme.background,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 4.scale,
                                          ),
                                          Text(
                                            '#Figma',
                                            style: theme.textTheme.bodySmall!
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
                                  SizedBox(width: 32.scale),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Otávio Pontes',
                                          style: theme.textTheme.headlineSmall!
                                              .merge(
                                            TextStyle(
                                              color:
                                                  theme.colorScheme.background,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8.scale),
                                        Text(
                                          'Desenvolvedor Mobile',
                                          style:
                                              theme.textTheme.bodyMedium!.merge(
                                            TextStyle(
                                              color:
                                                  theme.colorScheme.background,
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
                                                backgroundColor: theme
                                                    .colorScheme.background,
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
                                                backgroundColor: theme
                                                    .colorScheme.background,
                                                child: SvgPicture.asset(
                                                  AssetsMeLivra.linkedin,
                                                  fit: BoxFit.cover,
                                                  height: 40.scale,
                                                  color:
                                                      const Color(0xFF0077B5),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 16.scale),
                                            Flexible(
                                              child: GestureDetector(
                                                onTap: () => launchUrl(
                                                  Uri(
                                                    scheme: 'https',
                                                    host: 'otaviopontes.com',
                                                  ),
                                                  mode: LaunchMode
                                                      .externalApplication,
                                                  webOnlyWindowName: '_blank',
                                                ),
                                                child: Icon(
                                                  Icons.language,
                                                  size: 40,
                                                  color: theme
                                                      .colorScheme.background,
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
                                          style: theme.textTheme.headlineSmall!
                                              .merge(
                                            TextStyle(
                                              color:
                                                  theme.colorScheme.background,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8.scale),
                                        Text(
                                          'Desenvolvedor Backend',
                                          style:
                                              theme.textTheme.bodyMedium!.merge(
                                            TextStyle(
                                              color:
                                                  theme.colorScheme.background,
                                            ),
                                          ),
                                        ),
                                        // SizedBox(height: 16.scale),
                                        // Row(
                                        //   children: [
                                        //     GestureDetector(
                                        //       onTap: () => launchUrl(
                                        //         Uri(
                                        //           scheme: 'https',
                                        //           host: 'github.com',
                                        //           path: 'thiago-mello',
                                        //         ),
                                        //         mode: LaunchMode
                                        //             .externalApplication,
                                        //         webOnlyWindowName: '_blank',
                                        //       ),
                                        //       child: CircleAvatar(
                                        //         backgroundColor: theme
                                        //             .colorScheme.background,
                                        //         child: SvgPicture.asset(
                                        //           AssetsMeLivra.github,
                                        //           height: 30.scale,
                                        //         ),
                                        //       ),
                                        //     ),
                                        //     SizedBox(width: 16.scale),
                                        //     GestureDetector(
                                        //       onTap: () => launchUrl(
                                        //         Uri(
                                        //           scheme: 'https',
                                        //           host: 'linkedin.com',
                                        //           path: 'in/thiago-de-mello',
                                        //         ),
                                        //         mode: LaunchMode
                                        //             .externalApplication,
                                        //         webOnlyWindowName: '_blank',
                                        //       ),
                                        //       child: CircleAvatar(
                                        //         backgroundColor: theme
                                        //             .colorScheme.background,
                                        //         child: SvgPicture.asset(
                                        //           AssetsMeLivra.linkedin,
                                        //           fit: BoxFit.cover,
                                        //           height: 40.scale,
                                        //           color:
                                        //               const Color(0xFF0077B5),
                                        //         ),
                                        //       ),
                                        //     ),
                                        //   ],
                                        // )
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 32.scale),
                                  Column(
                                    children: [
                                      const CircleAvatar(
                                        radius: 50,
                                        foregroundImage: NetworkImage(
                                          'https://avatars.githubusercontent.com/u/36369156?v=4',
                                        ),
                                      ),
                                      SizedBox(height: 8.scale),
                                      Row(
                                        children: [
                                          Text(
                                            '#Go',
                                            style: theme.textTheme.bodySmall!
                                                .merge(
                                              TextStyle(
                                                color: theme
                                                    .colorScheme.background,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 4.scale,
                                          ),
                                          Text(
                                            '#Docker',
                                            style: theme.textTheme.bodySmall!
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
