import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'routes.dart';
import 'theme.dart';
import 'models.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthModel(),
      child: MaterialApp(
        title: 'Pokedex',
        theme: theme,
        routes: routes,
      ),
    );
  }
}
