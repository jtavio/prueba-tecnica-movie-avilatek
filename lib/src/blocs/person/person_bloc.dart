import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pruebamovieavilatek/src/api/http_services.dart';
import 'package:pruebamovieavilatek/src/models/person.dart';

part 'person_event.dart';
part 'person_state.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  HttpServices httpServices;
  PersonBloc({required this.httpServices}) : super(const PersonState()) {
    on<LoadPersonEvent>(
      (event, emit) => emit(state.copyWith(people: event.people)),
    );
  }

  Future<People?> getPersonBio(int id) async {
    final resDataPerson = await httpServices.getPeopleBio(id);
    add(LoadPersonEvent(resDataPerson!));
  }
}
