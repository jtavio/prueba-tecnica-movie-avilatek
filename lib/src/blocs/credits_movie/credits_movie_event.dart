part of 'credits_movie_bloc.dart';

abstract class CreditsMovieEvent extends Equatable {
  const CreditsMovieEvent();

  @override
  List<Object> get props => [];
}

class LoadCreditsMovieEvent extends CreditsMovieEvent {
  final List<Cast>? credits;

  const LoadCreditsMovieEvent(this.credits);
}
