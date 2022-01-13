import 'package:flutter/material.dart';
import 'package:pokedex/models.dart';
import 'package:pokedex/widgets/widgets.dart';
import 'package:provider/provider.dart';

class FavoriteList extends StatefulWidget {
  const FavoriteList({Key? key}) : super(key: key);

  @override
  State<FavoriteList> createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthModel>(builder: (context, auth, child) {
      if (auth.user == null) {
        return Center(
          child: ElevatedButton(
            onPressed: () => Navigator.of(context).pushNamed("/login"),
            child: const Text("Login"),
          ),
        );
      } else {
        var favorites = auth.user!.favorites;
        return ListView.separated(
            itemCount: favorites.length,
            padding: const EdgeInsets.all(24.0),
            separatorBuilder: (context, index) => const SizedBox(height: 12.0),
            itemBuilder: (context, index) {
              var pokemon = favorites[index];
              return Favorite(pokemon: pokemon);
            });
      }
    });
  }
}
