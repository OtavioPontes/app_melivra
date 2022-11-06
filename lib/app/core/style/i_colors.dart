import 'package:flutter/material.dart';

abstract class IColors {
  final MaterialColor black;
  final Color white;

  final Color green;

  final Color red;

  final Color yellow;

  final Color purple;
  final Color lightPurple;

  final Color grey;
  final Color blueGrey;

  IColors(
    this.green,
    this.black,
    this.white,
    this.blueGrey,
    this.lightPurple,
    this.red,
    this.yellow,
    this.purple,
    this.grey,
  );
}
