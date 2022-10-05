import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pruebamovieavilatek/src/api/http_services.dart';
import 'package:pruebamovieavilatek/src/models/movie_credits.dart';

part 'credits_movie_event.dart';
part 'credits_movie_state.dart';

class CreditsMovieBloc extends Bloc<CreditsMovieEvent, CreditsMovieState> {
  HttpServices httpServices;
  CreditsMovieBloc({required this.httpServices})
      : super(const CreditsMovieState()) {
    on<LoadCreditsMovieEvent>(
        (event, emit) => emit(state.copyWith(credits: event.credits)));
  }

  Future<List<Cast>?> getMovieCreditsId(int movieId) async {
    final resCreditsId = await httpServices.getMovieCredits(movieId);

    add(LoadCreditsMovieEvent(resCreditsId));
  }
}
