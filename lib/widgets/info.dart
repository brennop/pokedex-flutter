import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pokedex/models.dart';
import 'package:pokedex/services/api.dart';
import 'package:provider/provider.dart';

class PokemonInfo extends StatelessWidget {
  const PokemonInfo({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  final PokemonModel pokemon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer<AuthModel>(builder: (context, auth, child) {
      return Column(
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
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 192.0,
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
                          const Text("Altura"),
                          Text(pokemon.height.toString())
                        ],
                      ),
                      const SizedBox(width: 24.0),
                      Column(
                        children: [
                          const Text("Peso"),
                          Text(pokemon.weight.toString())
                        ],
                      ),
                    ],
                  )
                ],
              ),
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
