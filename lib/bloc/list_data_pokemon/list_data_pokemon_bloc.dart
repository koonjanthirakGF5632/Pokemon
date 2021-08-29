import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:janthirak_mobile_dev/Api/PokemonList_api.dart';
import 'package:janthirak_mobile_dev/Model/Pokemon_model.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as Http;

part 'list_data_pokemon_event.dart';

part 'list_data_pokemon_state.dart';

class ListDataPokemonBloc extends Bloc<ListDataPokemonEvent, ListDataPokemonState> {
  ListDataPokemonBloc() : super(InitialListDataPokemonState());
  PokemonModel? dataModel;

  @override
  Stream<ListDataPokemonState> mapEventToState(
      ListDataPokemonEvent event) async* {
    try{
      if(event is IntitialPokemonEvent){  //เช็คว่า event ที่ถูกส่งมาเป็น event อะไร
        yield LoadingState();
        await getdataPokemon();
        yield LoadedState();
      }
    }catch(e){
      yield ErorState();
    }

  }

  getdataPokemon() async{
    var res = await ListPokemon_api.getListPokemon();
    dataModel = PokemonModel.fromJson(res);
  }

}

