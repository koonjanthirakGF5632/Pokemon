// To parse this JSON data, do
//
//     final pokemonModel = pokemonModelFromJson(jsonString);

import 'dart:convert';

PokemonModel pokemonModelFromJson(String str) => PokemonModel.fromJson(json.decode(str));

String pokemonModelToJson(PokemonModel data) => json.encode(data.toJson());

class PokemonModel {
  PokemonModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int? count;
  String? next;
  dynamic previous;
  List<Result>? results;

  factory PokemonModel.fromJson(Map<String, dynamic> json) => PokemonModel(
    count: json["count"] == null ? null : json["count"],
    next: json["next"] == null ? null : json["next"],
    previous: json["previous"],
    results: json["results"] == null ? null : List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count == null ? null : count,
    "next": next == null ? null : next,
    "previous": previous,
    "results": results == null ? null : List<dynamic>.from(results!.map((x) => x.toJson())),
  };
}

class Result {
  Result({
    this.name,
    this.url,
  });

  String? name;
  String? url;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    name: json["name"] == null ? null : json["name"],
    url: json["url"] == null ? null : json["url"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "url": url == null ? null : url,
  };
}
