import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/style/assets.dart';

import '../widgets/bottom_navigation_bar_widget.dart';

class BottomNavigationPage extends StatelessWidget {
  const BottomNavigationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: const RouterOutlet(),
      bottomNavigationBar: const BottomNavigationBarWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: 45.scale,
        height: 45.scale,
        padding: EdgeInsets.all(6.scale),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
          color: theme.colorScheme.surface,
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
}
