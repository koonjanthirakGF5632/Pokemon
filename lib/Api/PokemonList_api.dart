import 'dart:convert';
import 'package:http/http.dart' as Http;

class ListPokemon_api {
  ListPokemon_api();

  static Future<dynamic> getListPokemon() async{
    try{
      String url = 'https://pokeapi.co/api/v2/pokemon/';
      Http.Response respons = await Http.get(Uri.parse(url));
      if (respons.statusCode == 200) {
        return json.decode(respons.body);
      }
      else{
        print('api error');
      }
    }
    catch(e){
    }
  }
}