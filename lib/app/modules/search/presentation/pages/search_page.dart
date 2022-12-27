import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/core/style/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchPage extends StatelessWidget {
  final bool onlyProfessor;
  final bool onlyInstitutos;
  const SearchPage({
    Key? key,
    this.onlyProfessor = false,
    this.onlyInstitutos = false,
  }) : super(key: key);

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
                SizedBox(height: 24.scale),
                if (onlyInstitutos)
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
                        autofocus: true,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: GestureDetector(
                            onTap: Modular.to.pop,
                            child: const Icon(Icons.cancel),
                          ),
                          hintText: 'Pesquisar instituto',
                          hintStyle: theme.textTheme.bodyText1!.merge(
                            TextStyle(color: theme.disabledColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                if (onlyProfessor)
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
                        autofocus: true,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: GestureDetector(
                            onTap: Modular.to.pop,
                            child: const Icon(Icons.cancel),
                          ),
                          hintText: 'Pesquisar professor',
                          hintStyle: theme.textTheme.bodyText1!.merge(
                            TextStyle(color: theme.disabledColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                if (!onlyProfessor && !onlyInstitutos)
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
                        autofocus: true,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: GestureDetector(
                            onTap: Modular.to.pop,
                            child: const Icon(Icons.cancel),
                          ),
                          hintText: 'Professor ou instituto',
                          hintStyle: theme.textTheme.bodyText1!.merge(
                            TextStyle(color: theme.disabledColor),
                          ),
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
