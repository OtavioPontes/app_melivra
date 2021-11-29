import 'package:flutter/foundation.dart';

// class ControlState extends Equatable {
//   @override
//   List<Object?> get props => [];

//   static ControlState get start => StartControlState();
//   static ControlState empty(String message) =>
//       EmptyControlState(message: message);
//   static ControlState get loading => LoadingControlState();
//   static ControlState get success => SuccessControlState();
//   static ControlState failure(String message) =>
//       FailureControlState(message: message);

//   bool get isStart => this is StartControlState;
//   bool get isEmpty => this is EmptyControlState;
//   bool get isLoading => this is LoadingControlState;
//   bool get isSuccess => this is SuccessControlState;
//   bool get isFailure => this is FailureControlState;
//   bool get isPermissionDenied => this is PermissionControlState;

//   bool get isNotStart => this is! StartControlState;
//   bool get isNotEmpty => this is! EmptyControlState;
//   bool get isNotLoading => this is! LoadingControlState;
//   bool get isNotSuccess => this is! SuccessControlState;
//   bool get isNotFailure => this is! FailureControlState;
//   bool get isNotPermission => this is! PermissionControlState;
// }

// class StartControlState extends ControlState {}

// class EmptyControlState extends ControlState {
//   final String message;

//   EmptyControlState({required this.message});

//   EmptyControlState copyWith({
//     String? message,
//   }) {
//     return EmptyControlState(
//       message: message ?? this.message,
//     );
//   }
// }

// class LoadingControlState extends ControlState {}

// class SuccessControlState extends ControlState {}

// class FailureControlState extends ControlState {
//   final String message;

//   FailureControlState({required this.message});

//   factory FailureControlState.fromFailure(IFailure failure) {
//     return FailureControlState(message: failure.message);
//   }

//   FailureControlState copyWith({
//     String? message,
//   }) {
//     return FailureControlState(
//       message: message ?? this.message,
//     );
//   }
// }

// class PermissionControlState extends ControlState {
//   final String message;

//   PermissionControlState({required this.message});

//   PermissionControlState copyWith({
//     String? message,
//   }) {
//     return PermissionControlState(
//       message: message ?? this.message,
//     );
//   }
// }

enum ControlState {
  start,
  empty,
  loading,
  sucess,
  failure,
}

extension ParseToString on ControlState {
  String toShortString() => describeEnum(this);

  bool get isStart => this == ControlState.start;
  bool get isEmpty => this == ControlState.empty;
  bool get isLoading => this == ControlState.loading;
  bool get isSucess => this == ControlState.sucess;
  bool get isFailure => this == ControlState.failure;
  bool get isNotStart => this != ControlState.start;
  bool get isNotEmpty => this != ControlState.empty;
  bool get isNotLoading => this != ControlState.loading;
  bool get isNotSucess => this != ControlState.sucess;
  bool get isNotFailure => this != ControlState.failure;
}
