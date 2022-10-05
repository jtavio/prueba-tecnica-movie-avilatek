import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pruebamovieavilatek/src/api/http_services.dart';
import 'package:pruebamovieavilatek/src/models/movie_credits_person.dart';

part 'movie_credits_person_event.dart';
part 'movie_credits_person_state.dart';

class MovieCreditsPersonBloc
    extends Bloc<MovieCreditsPersonEvent, MovieCreditsPersonState> {
  HttpServices httpServices;
  MovieCreditsPersonBloc({required this.httpServices})
      : super(const MovieCreditsPersonState()) {
    on<LoadApiMoviesPersonCreditsEvent>(
      (event, emit) =>
          emit(state.copyWith(moviePersonCredits: event.moviesPersonCredits)),
    );
    on<DeleteMoviesPersonCreditsEvent>(
      (event, emit) => emit(const MovieCreditsPersonState()),
    );
  }

  Future getMovieCreditsPersonId(int personId) async {
    final resCreditsId = await httpServices.getMovieCreditsPerson(personId);

    add(LoadApiMoviesPersonCreditsEvent(resCreditsId));
  }
}
