part of 'get_all_movie_bloc.dart';

abstract class GetAllMovieEvent extends Equatable {
  const GetAllMovieEvent();

  @override
  List<Object> get props => [];
}

class LoadApiMovies extends GetAllMovieEvent {
  final List<Result>? movies;

  const LoadApiMovies(this.movies);
}

class DeleteCreditsEvent extends GetAllMovieEvent {}
