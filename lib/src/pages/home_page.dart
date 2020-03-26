import 'package:flutter/material.dart';
import 'package:movies/src/models/movie.dart';
import 'package:movies/src/providers/movies_provider.dart';
import 'package:movies/src/widgets/card_swipper.dart';

class HomePage extends StatelessWidget {
  final MoviesProvider moviesProvider = MoviesProvider();

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
          child: Column(
            children: <Widget>[
              _swipperTarjets(),
            ],
          ),
        ));
  }

  Widget _swipperTarjets() {
    return FutureBuilder(
      future: moviesProvider.getOnCinemas(),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData) {
          return CardSwipper(movies: snapshot.data);
        }
        return Container(
          height: 400.0,
          child: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
