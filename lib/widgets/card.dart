import 'package:flutter/material.dart';
import 'package:pokedex/models.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard({Key? key, required this.pokemon}) : super(key: key);

  final PokemonModel pokemon;

  get name {
    return pokemon.name[0].toUpperCase() + pokemon.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade900.withOpacity(0.10),
            spreadRadius: 1.0,
            blurRadius: 2.5,
            offset: const Offset(0.0, 1.0),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: Theme.of(context).textTheme.headline3),
            Text('#${pokemon.number}', style: Theme.of(context).textTheme.subtitle2),
            Flexible(child: Center(child: Image.network(pokemon.imageURL))),
          ],
        ),
      ),
    );
  }
}
