import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/network/network_info.dart';

class BottomNavigationController {
  final PageController pageController = PageController();
  final NetworkInfo _networkInfo = Modular.get<NetworkInfo>();

  int currentIndex = 0;

  void setCurrentIndex(int index) => currentIndex = index;

  void animatedToIndex(int index) {
    pageController.jumpToPage(
      index,
    );
  }

  Stream get isConnected => _networkInfo.streamIsConnected;
}
