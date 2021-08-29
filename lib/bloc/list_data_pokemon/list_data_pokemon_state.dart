part of 'list_data_pokemon_bloc.dart';

@immutable
abstract class ListDataPokemonState {}

class InitialListDataPokemonState extends ListDataPokemonState {
}

class LoadingState extends ListDataPokemonState{

}

class LoadedState extends ListDataPokemonState{

}

class ErorState extends ListDataPokemonState{

}