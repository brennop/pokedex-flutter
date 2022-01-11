import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pokedex/services/api.dart';
import 'package:pokedex/services/pokemons.dart';
import 'package:pokedex/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var pokemons = <Pokemon>[];
  var page = 1;

  _getPokemons() {
    API.getPokemons(page: page).then((response) {
      setState(() {
        Iterable list = json.decode(response.body)["data"];
        pokemons = list.map((pokemon) => Pokemon.fromJson(pokemon)).toList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getPokemons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Header(),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: pokemons.length,
                itemBuilder: (context, index) {
                  final data = pokemons[index];
                  return PokemonCard(pokemon: data);
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
    return Row(
      children: [
        Expanded(child: Text("Todos")),
        IconButton(onPressed: () {}, icon: const Icon(Icons.logout))
      ],
    );
  }
}
