import 'package:flutter/material.dart';
import 'package:pokedex/models.dart';
import 'package:pokedex/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PokemonsModel pokemons = PokemonsModel();
  final scrollController = ScrollController();

  _onScroll() {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      pokemons.loadMore();
    }
  }

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
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Header(),
            Expanded(
              child: StreamBuilder<List<PokemonModel>>(
                  stream: pokemons.stream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        controller: scrollController,
                        itemCount: snapshot.data!.length + 1,
                        itemBuilder: (context, index) {
                          if (index < snapshot.data!.length) {
                            return PokemonCard(pokemon: snapshot.data![index]);
                          } else if (pokemons.hasMore) {
                            /// hack: this is not sure if it's loading
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
                            return Container();
                          }
                        },
                      );
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text("Todos")),
        IconButton(onPressed: () {}, icon: const Icon(Icons.logout))
      ],
    );
  }
}
