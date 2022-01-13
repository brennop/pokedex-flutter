import 'package:flutter/material.dart';
import 'package:pokedex/models.dart';
import 'package:pokedex/widgets/widgets.dart';
import 'package:provider/provider.dart';

class Favorite extends StatelessWidget {
  const Favorite({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  final PokemonModel pokemon;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Consumer<AuthModel>(builder: (context, auth, child) {
      return InkWell(
        onTap: () => PokemonInfo.showBottomSheet(context, pokemon),
        child: Container(
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
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Center(child: Image.network(pokemon.imageURL)),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(pokemon.readableName, style: textTheme.headline3),
                      Text('#${pokemon.number}', style: textTheme.subtitle2),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => auth.removeFavorite(pokemon.name),
                  color: Colors.black54,
                  icon: const Icon(Icons.delete),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
