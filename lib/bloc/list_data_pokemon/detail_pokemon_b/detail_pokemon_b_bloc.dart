import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'detail_pokemon_b_event.dart';

part 'detail_pokemon_b_state.dart';

class DetailPokemonBBloc
    extends Bloc<DetailPokemonBEvent, DetailPokemonBState> {
  DetailPokemonBBloc() : super(InitialDetailPokemonBState());

  @override
  Stream<DetailPokemonBState> mapEventToState(
      DetailPokemonBEvent event) async* {
    // TODO: Add your event logic
  }
}
