import 'package:flutter/material.dart';
import 'package:movies/src/widgets/card_swipper.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('movies on cinenema!'),
          backgroundColor: Colors.indigoAccent,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            )
          ],
        ),
        body: Container(
          color: Colors.red,
          child: Column(
            children: <Widget>[
              _swipperTarjets(),
            ],
          ),
        ));
  }

  Widget _swipperTarjets() {
    return CardSwipper(
      movies: [1, 2, 3, 4, 5],
    );
  }
}
