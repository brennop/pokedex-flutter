import 'dart:convert';
import 'dart:async';

import 'package:pokedex/services/api.dart';

class PokemonModel {
  final String name;
  final int number;
  final String imageURL;
  final String kind;
  final int weight;
  final int height;

  PokemonModel.fromJson(Map json)
      : name = json['name'],
        number = json["number"],
        imageURL = json["image_url"],
        kind = json["kind"],
        weight = json["weight"],
        height = json["height"];

  get readableName {
    return name[0].toUpperCase() + name.substring(1);
  }
}

/// controls a stream of pokemons
class PokemonsModel {
  late Stream<List<PokemonModel>> stream;
  bool hasMore = true;

  int _page = 1;
  bool _loading = false;
  final List<Map> _data = [];
  final StreamController<List<Map>> _controller = StreamController.broadcast();

  PokemonsModel() {
    stream = _controller.stream
        .map((data) => data.map(PokemonModel.fromJson).toList());

    loadMore();
  }

  Future<void> loadMore() {
    if (_loading || !hasMore) return Future.value();

    _loading = true;
    return API.getPokemons(page: _page).then((response) {
      var body = json.decode(response.body);
      List<Map> data = List<Map>.from(body["data"]);

      /// add raw data
      _data.addAll(data);

      /// update stream
      _controller.add(_data);

      hasMore = body["next_page"] != null;
      _page += 1;
      _loading = false;
    });
  }
}
