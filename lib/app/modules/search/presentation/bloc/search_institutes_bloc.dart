import 'package:app_melivra/app/modules/institutos/domain/entities/instituto_entity.dart';
import 'package:bloc/bloc.dart';

class SearchInstitutesBloc extends Bloc {
  SearchInstitutesBloc() : super(SearchInstitutesEmptyState()) {
    on<SearchInstitutesLoadingEvent>(handleSearchInstitutesLoadingEvent);
    on<SearchInstitutesSuccessEvent>(handleSearchInstitutesSuccessEvent);
    on<SearchInstitutesFailureEvent>(handleSearchInstitutesFailureEvent);
    on<SearchInstitutesResetEvent>(handleSearchInstitutesResetEvent);
  }

  void handleSearchInstitutesLoadingEvent(
      SearchInstitutesLoadingEvent event, Emitter emit) {
    emit(SearchInstitutesLoadingState());
  }

  void handleSearchInstitutesSuccessEvent(
      SearchInstitutesSuccessEvent event, Emitter emit) {
    emit(
      SearchInstitutesSuccessState(
        institutes: event.institutes,
      ),
    );
  }

  void handleSearchInstitutesFailureEvent(
      SearchInstitutesFailureEvent event, Emitter emit) {
    emit(SearchInstitutesFailureState(message: event.message));
  }

  void handleSearchInstitutesResetEvent(
      SearchInstitutesResetEvent event, Emitter emit) {
    emit(SearchInstitutesEmptyState());
  }
}

abstract class SearchInstitutesState {}

class SearchInstitutesEmptyState extends SearchInstitutesState {}

class SearchInstitutesLoadingState extends SearchInstitutesState {}

class SearchInstitutesSuccessState extends SearchInstitutesState {
  final List<Instituto> institutes;
  SearchInstitutesSuccessState({
    required this.institutes,
  });
}

class SearchInstitutesFailureState extends SearchInstitutesState {
  final String message;

  SearchInstitutesFailureState({required this.message});
}

abstract class SearchInstitutesEvent {}

class SearchInstitutesLoadingEvent extends SearchInstitutesEvent {}

class SearchInstitutesSuccessEvent extends SearchInstitutesEvent {
  final List<Instituto> institutes;
  SearchInstitutesSuccessEvent({
    required this.institutes,
  });
}

class SearchInstitutesFailureEvent extends SearchInstitutesEvent {
  final String message;

  SearchInstitutesFailureEvent({required this.message});
}

class SearchInstitutesResetEvent extends SearchInstitutesEvent {}
