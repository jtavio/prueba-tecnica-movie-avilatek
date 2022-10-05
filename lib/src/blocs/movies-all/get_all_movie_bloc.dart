import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pruebamovieavilatek/src/api/http_services.dart';
import 'package:pruebamovieavilatek/src/models/movie_credits.dart';
import 'package:pruebamovieavilatek/src/models/movie_popular.dart';

part 'get_all_movie_event.dart';
part 'get_all_movie_state.dart';

class GetAllMovieBloc extends Bloc<GetAllMovieEvent, GetAllMovieState> {
  HttpServices httpServices;
  GetAllMovieBloc({required this.httpServices})
      : super(const GetAllMovieState()) {
    on<LoadApiMovies>(
      (event, emit) => emit(state.copyWith(movies: event.movies)),
    );
    // on<DeleteCreditsEvent>((event, emit) => emit(const GetAllMovieState()));
  }

  Future<List<Result>?> getPopularMovie() async {
    final resLastest = await httpServices.getLastestMovie();
    if (resLastest != null) {
      add(LoadApiMovies(resLastest));
    }
  }
}
