import 'package:flutter/material.dart';
import 'package:pokedex/models.dart';
import 'package:pokedex/widgets/widgets.dart';
import 'package:provider/provider.dart';

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
                    return GridView.builder(
                      padding: const EdgeInsets.all(12.0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context) =>
                                    PokemonInfo(pokemon: pokemon));
                          },
                        );
                      },
                    );
                  }
                },
              ),
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
    return Consumer<AuthModel>(
      builder: (context, auth, child) {
        return Row(
          children: [
            Expanded(child: Text("Todos")),
            IconButton(
                onPressed: () {
                  if (auth.user == null) {
                    Navigator.of(context).pushNamed("/login");
                  } else {
                    auth.user = null;
                  }
                },
                icon: Icon(
                    auth.user == null ? Icons.account_circle : Icons.logout))
          ],
        );
      },
    );
  }
}
