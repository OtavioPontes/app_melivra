// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inicio_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$InicioController on _InicioControllerBase, Store {
  final _$stateAtom = Atom(name: '_InicioControllerBase.state');

  @override
  ControlState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(ControlState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$failureMessageAtom =
      Atom(name: '_InicioControllerBase.failureMessage');

  @override
  String get failureMessage {
    _$failureMessageAtom.reportRead();
    return super.failureMessage;
  }

  @override
  set failureMessage(String value) {
    _$failureMessageAtom.reportWrite(value, super.failureMessage, () {
      super.failureMessage = value;
    });
  }

  final _$loadingMessageAtom =
      Atom(name: '_InicioControllerBase.loadingMessage');

  @override
  String get loadingMessage {
    _$loadingMessageAtom.reportRead();
    return super.loadingMessage;
  }

  @override
  set loadingMessage(String value) {
    _$loadingMessageAtom.reportWrite(value, super.loadingMessage, () {
      super.loadingMessage = value;
    });
  }

  final _$_InicioControllerBaseActionController =
      ActionController(name: '_InicioControllerBase');

  @override
  void _setLoadingMessage({required String value}) {
    final _$actionInfo = _$_InicioControllerBaseActionController.startAction(
        name: '_InicioControllerBase._setLoadingMessage');
    try {
      return super._setLoadingMessage(value: value);
    } finally {
      _$_InicioControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _setStateFailure({required String failureMessage}) {
    final _$actionInfo = _$_InicioControllerBaseActionController.startAction(
        name: '_InicioControllerBase._setStateFailure');
    try {
      return super._setStateFailure(failureMessage: failureMessage);
    } finally {
      _$_InicioControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state},
failureMessage: ${failureMessage},
loadingMessage: ${loadingMessage}
    ''';
  }
}
