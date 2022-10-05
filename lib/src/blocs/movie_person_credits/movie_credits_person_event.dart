part of 'movie_credits_person_bloc.dart';

abstract class MovieCreditsPersonEvent extends Equatable {
  const MovieCreditsPersonEvent();

  @override
  List<Object> get props => [];
}

class LoadApiMoviesPersonCreditsEvent extends MovieCreditsPersonEvent {
  final List<Cast>? moviesPersonCredits;

  const LoadApiMoviesPersonCreditsEvent(this.moviesPersonCredits);
}

class DeleteMoviesPersonCreditsEvent extends MovieCreditsPersonEvent {}
