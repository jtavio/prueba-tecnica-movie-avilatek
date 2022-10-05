part of 'person_bloc.dart';

abstract class PersonEvent extends Equatable {
  const PersonEvent();

  @override
  List<Object> get props => [];
}

class LoadPersonEvent extends PersonEvent {
  final People people;

  const LoadPersonEvent(this.people);
}
