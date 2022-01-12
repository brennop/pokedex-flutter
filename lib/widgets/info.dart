import 'package:flutter/material.dart';
import 'package:pokedex/models.dart';

class PokemonInfo extends StatelessWidget {
  const PokemonInfo({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  final PokemonModel pokemon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                    const Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                      size: 32.0,
                    ),
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
  }
}