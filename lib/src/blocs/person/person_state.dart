part of 'person_bloc.dart';

class PersonState extends Equatable {
  final People? people;
  const PersonState({
    this.people,
  });

  PersonState copyWith({
    People? people,
  }) =>
      PersonState(
        people: people ?? this.people,
      );

  @override
  List<Object?> get props => [people];
}

class PersonInitial extends PersonState {}
