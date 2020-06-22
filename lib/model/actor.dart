// To parse this JSON data, do
//
//     final actor = actorFromJson(jsonString);

import 'dart:convert';
import 'package:http/http.dart' as http;

Actor actorFromJson(String str) => Actor.fromJson(json.decode(str));

String actorToJson(Actor data) => json.encode(data.toJson());

class Actor {
  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Future<List<Actor>> fetchActors(int id) async {
    var body;
    List<Actor> actors;

    await http
        .get(
        'https://api.themoviedb.org/3/movie/$id/credits?api_key=92617104f2646d905240d1f828861df6')
        .then((value) => body = jsonDecode(value.body)['cast']);

    actors = List<Actor>.from(body.map((actor) => Actor.fromJson(actor))).toList();

    return actors;
  }

  factory Actor.fromJson(Map<String, dynamic> json) => Actor(
    castId: json["cast_id"],
    character: json["character"],
    creditId: json["credit_id"],
    gender: json["gender"],
    id: json["id"],
    name: json["name"],
    order: json["order"],
    profilePath: json["profile_path"],
  );

  Map<String, dynamic> toJson() => {
    "cast_id": castId,
    "character": character,
    "credit_id": creditId,
    "gender": gender,
    "id": id,
    "name": name,
    "order": order,
    "profile_path": profilePath,
  };
}
