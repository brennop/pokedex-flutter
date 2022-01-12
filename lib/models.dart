import 'dart:convert';
import 'dart:async';

import 'package:pokedex/services/api.dart';

class PokemonModel {
  final String name;
  final int number;
  final String imageURL;
  final String kind;

  PokemonModel(this.name, this.number, this.imageURL, this.kind);

  PokemonModel.fromJson(Map json)
      : name = json['name'],
        number = json["number"],
        imageURL = json["image_url"],
        kind = json["kind"];
}

/// controls a stream of pokemons
class PokemonsModel {
  late Stream<List<PokemonModel>> stream;
  bool hasMore = true;

  int _page = 1;
  bool loading = false;
  final List<Map> _data = [];
  final StreamController<List<Map>> _controller = StreamController.broadcast();

  PokemonsModel() {
    stream = _controller.stream
        .map((data) => data.map(PokemonModel.fromJson).toList());

    loadMore();
  }

  Future<void> loadMore() {
    if (loading || !hasMore) return Future.value();

    loading = true;
    return API.getPokemons(page: _page).then((response) {
      var body = json.decode(response.body);
      List<Map> data = List<Map>.from(body["data"]);

      /// add raw data
      _data.addAll(data);

      /// update stream
      _controller.add(_data);

      hasMore = body["next_page"] != null;
      _page += 1;
      loading = false;
    });
  }
}
