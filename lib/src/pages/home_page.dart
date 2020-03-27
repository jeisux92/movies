import 'package:flutter/material.dart';
import 'package:movies/src/models/movie.dart';
import 'package:movies/src/providers/movies_provider.dart';
import 'package:movies/src/widgets/card_swipper.dart';
import 'package:movies/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  final MoviesProvider _moviesProvider = MoviesProvider();

  @override
  Widget build(BuildContext context) {
    _moviesProvider.getPopulars();
    final _screenSize = MediaQuery.of(context).size;
    print(_screenSize.width);

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
              _swipperTarjets(context),
              _footer(context),
            ],
          ),
        ));
  }

  Widget _swipperTarjets(context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
        height: _screenSize.height * 0.5,
        child: FutureBuilder(
          future: _moviesProvider.getOnCinemas(),
          builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
            if (snapshot.hasData) {
              return CardSwipper(movies: snapshot.data);
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }

  Widget _footer(context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              'Populares',
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          StreamBuilder(
            stream: _moviesProvider.popularsStream,
            builder:
                (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontal(
                  movies: snapshot.data,
                  nextPage: _moviesProvider.getPopulars,
                );
              }
              return Container(
                  height: _screenSize.height * 0.3,
                  child: Center(child: CircularProgressIndicator()));
            },
          ),
        ],
      ),
    );
  }
}
