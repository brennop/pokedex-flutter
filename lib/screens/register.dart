import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/models.dart';
import 'package:pokedex/services/api.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _userNameController = TextEditingController();
  bool _loading = false;
  String? _error;

  void _onRegister() {
    if (_loading) return;

    var username = _userNameController.text;
    if (username == "") return;

    setState(() {
      _loading = true;
      _error = null;
    });

    API.createUser(username: username).then((response) {
      if (response.statusCode == 201) {
        var userData = json.decode(response.body);
        var user = UserModel(userData["username"], []);
        Provider.of<AuthModel>(context, listen: false).user = user;
        Navigator.of(context).pushNamedAndRemoveUntil("/", (_) => false);
      } else {
        throw Exception('Failed to create user');
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
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(children: const [BackButton(color: Colors.red)]),
                Image.asset("assets/images/register.png"),
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
                  onSubmitted: (value) => _onRegister(),
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
                        onPressed: _onRegister,
                        child: _loading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.0,
                              )
                            : const Text("Criar Conta"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
