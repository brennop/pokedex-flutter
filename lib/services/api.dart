import 'dart:convert';

import 'package:http/http.dart' as http;

class API {
  static const baseURL = "pokedex20201.herokuapp.com";

  static Future getPokemons({int? page = 1}) {
    var url = Uri.https(baseURL, "pokemons", {"page": page.toString()});
    return http.get(url);
  }

  static Future<http.Response> getUser({required String username}) {
    var url = Uri.https(baseURL, "users/$username");
    return http.get(url);
  }

  static Future<http.Response> createUser({required String username}) {
    var url = Uri.https(baseURL, "users");
    var body = jsonEncode({"username": username});
    return http
        .post(url, body: body, headers: {"Content-Type": "application/json"});
  }

  static Future addPokemon(
      {required String username, required String pokemon}) {
    var url = Uri.https(baseURL, "users/$username/starred/$pokemon");
    return http.post(url);
  }

  static Future removePokemon(
      {required String username, required String pokemon}) {
    var url = Uri.https(baseURL, "users/$username/starred/$pokemon");
    return http.delete(url);
  }
}
