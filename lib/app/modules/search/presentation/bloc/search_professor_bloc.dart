import 'package:bloc/bloc.dart';

import '../../../professores/domain/entities/professor_entity.dart';

class SearchProfessorsBloc extends Bloc {
  SearchProfessorsBloc() : super(SearchProfessorsEmptyState()) {
    on<SearchProfessorsLoadingEvent>(handleSearchProfessorsLoadingEvent);
    on<SearchProfessorsSuccessEvent>(handleSearchProfessorsSuccessEvent);
    on<SearchProfessorsFailureEvent>(handleSearchProfessorsFailureEvent);
    on<SearchProfessorsResetEvent>(handleSearchProfessorsResetEvent);
  }

  void handleSearchProfessorsLoadingEvent(
      SearchProfessorsLoadingEvent event, Emitter emit,) {
    emit(SearchProfessorsLoadingState());
  }

  void handleSearchProfessorsSuccessEvent(
      SearchProfessorsSuccessEvent event, Emitter emit,) {
    emit(
      SearchProfessorsSuccessState(
        professors: event.professors,
      ),
    );
  }

  void handleSearchProfessorsFailureEvent(
      SearchProfessorsFailureEvent event, Emitter emit,) {
    emit(SearchProfessorsFailureState(message: event.message));
  }

  void handleSearchProfessorsResetEvent(
      SearchProfessorsResetEvent event, Emitter emit,) {
    emit(SearchProfessorsEmptyState());
  }
}

abstract class SearchProfessorsState {}

class SearchProfessorsEmptyState extends SearchProfessorsState {}

class SearchProfessorsLoadingState extends SearchProfessorsState {}

class SearchProfessorsSuccessState extends SearchProfessorsState {
  final List<Professor> professors;

  SearchProfessorsSuccessState({
    required this.professors,
  });
}

class SearchProfessorsFailureState extends SearchProfessorsState {
  final String message;

  SearchProfessorsFailureState({required this.message});
}

abstract class SearchProfessorsEvent {}

class SearchProfessorsLoadingEvent extends SearchProfessorsEvent {}

class SearchProfessorsSuccessEvent extends SearchProfessorsEvent {
  final List<Professor> professors;

  SearchProfessorsSuccessEvent({
    required this.professors,
  });
}

class SearchProfessorsFailureEvent extends SearchProfessorsEvent {
  final String message;

  SearchProfessorsFailureEvent({required this.message});
}

class SearchProfessorsResetEvent extends SearchProfessorsEvent {}
