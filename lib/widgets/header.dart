import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pokedex/models.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthModel>(
      builder: (context, auth, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TabBar(
                        labelPadding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 4.0,
                        ),
                        isScrollable: true,
                        indicator: BoxDecoration(),
                        labelColor: Colors.red,
                        labelStyle: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                        unselectedLabelColor: Colors.grey,
                        tabs: [
                          Tab(text: "Todos"),
                          Tab(text: "Favoritos"),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        if (auth.user == null) {
                          Navigator.of(context).pushNamed("/login");
                        } else {
                          auth.user = null;
                        }
                      },
                      icon: Icon(auth.user == null
                          ? Icons.account_circle
                          : Icons.logout))
                ],
              ),
              const Divider(
                color: Colors.black38,
                height: 1,
              ),
            ],
          ),
        );
      },
    );
  }
}
