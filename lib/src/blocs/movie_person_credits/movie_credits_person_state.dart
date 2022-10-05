part of 'movie_credits_person_bloc.dart';

class MovieCreditsPersonState extends Equatable {
  final List<Cast>? moviePersonCredits;

  const MovieCreditsPersonState({
    this.moviePersonCredits,
  });

  MovieCreditsPersonState copyWith({
    List<Cast>? moviePersonCredits,
  }) =>
      MovieCreditsPersonState(
        moviePersonCredits: moviePersonCredits ?? this.moviePersonCredits,
      );

  @override
  List<Object?> get props => [moviePersonCredits];

  @override
  String tostring() => '{moviePersonCredits: $moviePersonCredits}';
}

class MovieCreditsPersonInitial extends MovieCreditsPersonState {}
