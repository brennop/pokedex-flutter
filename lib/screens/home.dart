import 'package:flutter/material.dart';
import 'package:pokedex/widgets/favorite_list.dart';
import 'package:pokedex/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: const [
              Header(),
              Expanded(
                child: TabBarView(children: [
                  PokemonList(),
                  FavoriteList(),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
