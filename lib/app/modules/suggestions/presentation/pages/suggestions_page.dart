import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/core/style/assets.dart';
import 'package:app_melivra/app/modules/suggestions/presentation/controllers/suggestions_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SuggestionsPage extends StatefulWidget {
  const SuggestionsPage({Key? key}) : super(key: key);

  @override
  State<SuggestionsPage> createState() => _SuggestionsPageState();
}

class _SuggestionsPageState extends State<SuggestionsPage> {
  bool isPreenchido = false;

  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<SuggestionsController>();
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
                            Icons.rocket_launch,
                            color: theme.colorScheme.background,
                            size: 40.scale,
                          ),
                          SizedBox(height: 16.scale),
                          Text(
                            'Sugestões',
                            style: theme.textTheme.headlineSmall!.merge(
                              TextStyle(
                                color: theme.colorScheme.background,
                              ),
                            ),
                          ),
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
                            horizontal: 40.scale,
                            vertical: 24.scale,
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 48.scale),
                              Text(
                                'Mande suas sugestões e/ou críticas do app no campo abaixo:',
                                style: theme.textTheme.headlineSmall!.merge(
                                  TextStyle(
                                    color: theme.colorScheme.background,
                                  ),
                                ),
                              ),
                              SizedBox(height: 32.scale),
                              Center(
                                child: Container(
                                  padding: EdgeInsets.all(16.scale),
                                  decoration: BoxDecoration(
                                    color: theme.canvasColor,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  width: size.width * 0.85,
                                  child: TextField(
                                    onChanged: (value) {
                                      setState(
                                        () {
                                          if (value.isNotEmpty) {
                                            isPreenchido = true;
                                          } else {
                                            isPreenchido = false;
                                          }
                                        },
                                      );
                                    },
                                    controller: controller.suggestionController,
                                    minLines: 3,
                                    maxLines: 3,
                                    textAlignVertical: TextAlignVertical.top,
                                    decoration: InputDecoration(
                                      hintText:
                                          'Coloque sua sugestão e/ou crítica aqui...',
                                      hintStyle:
                                          theme.textTheme.bodyLarge!.merge(
                                        TextStyle(color: theme.disabledColor),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 64.scale),
                              if (isPreenchido)
                                Center(
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        // Change your radius here
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      fixedSize: Size(140.scale, 50.scale),
                                      backgroundColor:
                                          theme.colorScheme.background,
                                    ),
                                    onPressed: () async {
                                      await controller.sendSuggestion();
                                      setState(() {
                                        isPreenchido = false;
                                      });
                                    },
                                    child: Text(
                                      'Enviar',
                                      style: theme.textTheme.titleLarge!.merge(
                                        TextStyle(
                                          color: theme.primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
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
