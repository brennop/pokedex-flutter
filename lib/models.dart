import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pokedex/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

const kinds = {
  "normal": Color(0xffA8A77A),
  "fire": Color(0xfffb6c6c),
  "water": Color(0xff75bcfd),
  "electric": Color(0xffF7D02C),
  "grass": Color(0xff42c7a7),
  "ice": Color(0xff96D9D6),
  "fighting": Color(0xffC22E28),
  "poison": Color(0xffA33EA1),
  "ground": Color(0xffE2BF65),
  "flying": Color(0xffA98FF3),
  "psychic": Color(0xffF95587),
  "bug": Color(0xffA6B91A),
  "rock": Color(0xffB6A136),
  "ghost": Color(0xff735797),
  "dragon": Color(0xff6F35FC),
  "dark": Color(0xff705746),
  "steel": Color(0xffB7B7CE),
  "fairy": Color(0xffD685AD),
};

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

  get colors {
    return kind.split(";").map((k) => kinds[k]!).toList();
  }

  List<String> get kindList {
    return kind.split(";").map((k) {
      return k[0].toUpperCase() + k.substring(1);
    }).toList();
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

class UserModel {
  final String username;
  final List<PokemonModel> favorites;

  UserModel(this.username, this.favorites);

  UserModel.fromJSON(Map json)
      : username = json["user"]["username"],
        favorites = List<Map>.from(json["pokemons"])
            .map(PokemonModel.fromJson)
            .toList();
}

class AuthModel extends ChangeNotifier {
  UserModel? _user;

  AuthModel() {
    SharedPreferences.getInstance().then((prefs) {
      var username = prefs.getString("username");
      if (username != null) {
        API.getUser(username: username).then((response) {
          var userData = json.decode(response.body);
          user = UserModel.fromJSON(userData);
        });
      }
    });
  }

  UserModel? get user => _user;

  set user(UserModel? user) {
    _user = user;
    notifyListeners();
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("username", user?.username ?? "");
    });
  }

  Future addFavorite(name) {
    return API
        .addPokemon(username: user!.username, pokemon: name)
        .then((response) {
      var userData = json.decode(response.body);
      user = UserModel.fromJSON(userData);
    });
  }

  Future removeFavorite(name) {
    return API
        .removePokemon(username: user!.username, pokemon: name)
        .then((response) {
      var userData = json.decode(response.body);
      user = UserModel.fromJSON(userData);
    });
  }
}
