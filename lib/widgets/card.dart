import 'package:flutter/cupertino.dart';
import 'package:pokedex/services/pokemons.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard(
      {Key? key,
      required this.pokemon})
      : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(pokemon.name),
          Text('#${pokemon.number}'),
          Image.network(pokemon.imageURL),
          Text(pokemon.kind)
        ],
      ),
    );
  }
}
