import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/models.dart';
import 'package:pokedex/services/api.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userNameController = TextEditingController();
  bool _loading = false;
  String? _error;

  void _onLogin() {
    if (_loading) return;

    var username = _userNameController.text;
    if (username == "") return;

    setState(() {
      _loading = true;
      _error = null;
    });

    API.getUser(username: username).then((response) {
      if (response.statusCode == 200) {
        var userData = json.decode(response.body);
        var user = UserModel.fromJSON(userData);
        Provider.of<AuthModel>(context, listen: false).user = user;
        Navigator.of(context).pushNamed("/");
      } else if (response.statusCode == 404) {
        _error = "Usuário não encontrado";
      } else {
        throw Exception('Failed to load user');
      }
    }).catchError((error) {
      setState(() {
        _error = "Ocorreu um erro. Tente novamente mais tarde";
      });
    }).whenComplete(() => setState(() => _loading = false));
  }

  @override
  void dispose() {
    _userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /** make screen scroll with keyboard */
      body: SingleChildScrollView(
        /** occupy the whole screen (because of ScrollView) */
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/login.png"),
                const SizedBox(height: 24.0),
                Text(
                  "Explore e descubra o maravilhoso mundo Pokémon",
                  style: Theme.of(context).textTheme.headline1,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12.0),
                Text(
                  "Temos que pegar!",
                  style: Theme.of(context).textTheme.subtitle1,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32.0),
                TextField(
                  onSubmitted: (value) => _onLogin(),
                  controller: _userNameController,
                  decoration: const InputDecoration(
                    hintText: "Nome do treinador",
                  ),
                ),
                _error == null
                    ? const SizedBox(height: 24.0)
                    : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          _error!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                Row(
                  /** this feels like a hack */
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _onLogin,
                        child: _loading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.0,
                              )
                            : const Text("Entrar"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),
                TextButton(
                  onPressed: () => Navigator.of(context).pushNamed("/register"),
                  child: const Text("Criar Conta"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
