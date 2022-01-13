import 'package:http/http.dart' as http;

class API {
  static const baseURL = "pokedex20201.herokuapp.com";

  static Future getPokemons({int? page = 1}) {
    var url = Uri.https(baseURL, "pokemons", {"page": page.toString()});
    return http.get(url);
  }

  static Future getUser({required String username}) {
    var url = Uri.https(baseURL, "users/$username");
    return http.get(url);
  }
}
