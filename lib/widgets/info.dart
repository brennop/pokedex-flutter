import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pokedex/models.dart';
import 'package:pokedex/services/api.dart';
import 'package:pokedex/theme.dart';
import 'package:provider/provider.dart';

class PokemonInfo extends StatelessWidget {
  const PokemonInfo({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  final PokemonModel pokemon;

  static showBottomSheet(BuildContext context, PokemonModel _pokemon) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => PokemonInfo(pokemon: _pokemon));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer<AuthModel>(builder: (context, auth, child) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              color: theme.primaryColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        pokemon.readableName,
                        style: theme.textTheme.headline2,
                      ),
                      buildIconButton(auth),
                    ],
                  ),
                  Text("#${pokemon.number}", style: theme.textTheme.headline4),
                ],
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 216.0,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        height: 96.0,
                        decoration: BoxDecoration(color: theme.primaryColor),
                      ),
                      Image.network(
                        pokemon.imageURL,
                        scale: 0.5,
                        filterQuality: FilterQuality.none,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Altura",
                          style: theme.textTheme.infoLabel,
                        ),
                        Text(
                          pokemon.height.toString(),
                          style: theme.textTheme.infoValue,
                        )
                      ],
                    ),
                    const SizedBox(width: 48.0),
                    Column(
                      children: [
                        Text(
                          "Peso",
                          style: theme.textTheme.infoLabel,
                        ),
                        Text(
                          pokemon.weight.toString(),
                          style: theme.textTheme.infoValue,
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 48.0)
              ],
            ),
          )
        ],
      );
    });
  }

  Widget buildIconButton(AuthModel auth) {
    if (auth.user == null) return Container();

    var favorite = auth.user!.favorites.any((p) => p.name == pokemon.name);

    _onPressed() {
      var fn = favorite ? API.removePokemon : API.addPokemon;

      fn(username: auth.user!.username, pokemon: pokemon.name).then((response) {
        var userData = json.decode(response.body);
        auth.user = UserModel.fromJSON(userData);
      });
    }

    return IconButton(
      onPressed: _onPressed,
      icon: Icon(
        favorite ? Icons.favorite : Icons.favorite_border,
        color: Colors.white,
        size: 32.0,
      ),
    );
  }
}
