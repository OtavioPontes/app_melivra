import 'package:equatable/equatable.dart';

abstract class ControlState extends Equatable {
  @override
  List<Object?> get props => [];

  static ControlState get start => StartState();
  static ControlState empty([String? message]) => EmptyState(message: message);
  static ControlState get loading => LoadingState();
  static ControlState get success => SuccessState();
  static ControlState failure([String? message]) =>
      FailureState(message: message);

  bool get isStart => this is StartState;
  bool get isEmpty => this is EmptyState;
  bool get isLoading => this is LoadingState;
  bool get isSuccess => this is SuccessState;
  bool get isFailure => this is FailureState;
}

class StartState extends ControlState {}

class EmptyState extends ControlState {
  final String? message;

  EmptyState({this.message = 'Não encontramos nada aqui...'});
}

class LoadingState extends ControlState {}

class SuccessState extends ControlState {}

class FailureState extends ControlState {
  final String? message;

  FailureState({
    this.message = 'Ocorreu um erro 😥',
  });
}
