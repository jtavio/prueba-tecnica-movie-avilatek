part of 'credits_movie_bloc.dart';

class CreditsMovieState extends Equatable {
  final List<Cast>? credits;

  const CreditsMovieState({
    this.credits,
  });

  CreditsMovieState copyWith({
    List<Cast>? credits,
  }) =>
      CreditsMovieState(
        credits: credits ?? this.credits,
      );

  @override
  List<Object?> get props => [credits];

  @override
  String tostring() => '{credits: $credits}';
}

class CreditsMovieInitial extends CreditsMovieState {}
