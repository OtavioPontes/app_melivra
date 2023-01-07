import 'package:app_melivra/app/core/style/assets.dart';
import 'package:app_melivra/app/core/style/colors.dart';
import 'package:app_melivra/app/modules/splash/presentation/bloc/splash_bloc.dart';
import 'package:app_melivra/app/modules/splash/presentation/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:app_melivra/app/core/extensions/screen_extension.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final SplashController controller = Modular.get<SplashController>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: theme.backgroundColor,
        systemNavigationBarColor: theme.colorScheme.primary,
      ),
      child: Scaffold(
        body: Stack(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 48.scale,
                ),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      AssetsMeLivra.logo,
                      width: 85.scale,
                      height: 85.scale,
                      fit: BoxFit.fitWidth,
                    ),
                    SizedBox(
                      height: 16.scale,
                    ),
                    Text(
                      'Me Livra',
                      style: theme.textTheme.headline2,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Column(
                children: [
                  SvgPicture.asset(
                    AssetsMeLivra.splash,
                    color: theme.primaryColor,
                    width: size.width,
                  ),
                ],
              ),
            ),
            Positioned(
              right: size.width * 0.2,
              bottom: size.height * 0.36,
              child: Image.asset(
                'assets/images/professor_splash.png',
                fit: BoxFit.fitHeight,
              ),
            ),
            Positioned(
              width: size.width,
              bottom: size.height * 0.05,
              child: BlocBuilder(
                bloc: controller.bloc,
                builder: (context, state) {
                  if (state is SplashLoadingState) {
                    return Column(
                      children: [
                        CircularProgressIndicator(
                          color: ColorsMeLivra().lightPurple,
                        ),
                        SizedBox(
                          height: 32.scale,
                        ),
                        Text(
                          'V ${controller.appVersion}',
                          style: theme.textTheme.headline6!.merge(
                            TextStyle(
                              color: theme.colorScheme.surface,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  if (state is SplashFailureState) {
                    return Column(
                      children: [
                        Text(
                          state.message,
                          style: theme.textTheme.bodyText1!.merge(
                            TextStyle(
                              color: theme.backgroundColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 32.scale,
                        ),
                        GestureDetector(
                          onTap: controller.pipeline,
                          child: Icon(
                            Icons.refresh,
                            color: theme.backgroundColor,
                          ),
                        )
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
