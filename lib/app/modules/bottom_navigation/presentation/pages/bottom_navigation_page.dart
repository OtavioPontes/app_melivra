import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/modules/professores/professores_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/style/assets.dart';
import '../../../home/home_module.dart';

import '../../../institutos/institutos_module.dart';
import '../../../perfil/perfil_module.dart';
import '../controller/bottom_navigation_controller.dart';
import '../widgets/bottom_navigation_bar_widget.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({Key? key}) : super(key: key);

  @override
  _BottomNavigationPageState createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage>
    with AutomaticKeepAliveClientMixin {
  final controller = Modular.get<BottomNavigationController>();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    super.build(context);

    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        onPageChanged: controller.setCurrentIndex,
        children: [
          HomeModule.provider,
          ProfessoresModule.provider,
          InstitutosModule.provider,
          PerfilModule.provider,
        ],
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: 45.scale,
        height: 45.scale,
        padding: EdgeInsets.all(6.scale),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 1),
            )
          ],
          color: theme.backgroundColor,
          borderRadius: BorderRadius.circular(
            100,
          ),
        ),
        child: SvgPicture.asset(
          AssetsMeLivra.logo,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
