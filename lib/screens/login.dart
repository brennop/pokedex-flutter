import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userNameController = TextEditingController();

  void _onLogin() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(_userNameController.text)),
    );
  }

  @override
  void dispose() {
    _userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
            const SizedBox(height: 24.0),
            Row(
              /** this feels like a hack */
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _onLogin,
                    child: const Text("Entrar"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
