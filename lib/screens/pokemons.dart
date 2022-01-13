import 'package:flutter/material.dart';
import 'package:pokedex/models.dart';
import 'package:pokedex/widgets/widgets.dart';

class PokemonList extends StatefulWidget {
  const PokemonList({
    Key? key,
  }) : super(key: key);

  @override
  State<PokemonList> createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList>
    with AutomaticKeepAliveClientMixin<PokemonList> {
  PokemonsModel pokemons = PokemonsModel();
  final scrollController = ScrollController();

  _onScroll() {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      pokemons.loadMore();
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<List<PokemonModel>>(
      stream: pokemons.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return GridView.builder(
            padding: const EdgeInsets.all(12.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 12.0,
              childAspectRatio: 4 / 3,
            ),
            controller: scrollController,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var pokemon = snapshot.data![index];
              return PokemonCard(
                pokemon: pokemon,
                onPress: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) => PokemonInfo(pokemon: pokemon));
                },
              );
            },
          );
        }
      },
    );
  }
}
