part of 'get_all_movie_bloc.dart';

class GetAllMovieState extends Equatable {
  final List<Result>? movies;
  final Map<String, dynamic>? error;
  const GetAllMovieState({
    this.movies,
    this.error,
  });

  GetAllMovieState copyWith({
    List<Result>? movies,
    Map<String, dynamic>? error,
  }) =>
      GetAllMovieState(
        movies: movies ?? this.movies,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props => [movies, error];

  @override
  String tostring() => '{movies: $movies, nameAuthor: $error, error: $error}';
}

class GetAllMovieInitial extends GetAllMovieState {}
