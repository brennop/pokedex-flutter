import 'package:http/http.dart' as http;

const baseURL = "pokedex20201.herokuapp.com";

class API {
  static Future getPokemons({int? page = 1}) {
    var url = Uri.https(baseURL, "pokemons", {"page": page.toString()});
    return http.get(url);
  }
}
