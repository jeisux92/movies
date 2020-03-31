import 'package:flutter/material.dart';
import 'package:movies/src/models/movie.dart';
import 'package:movies/src/providers/movies_provider.dart';
import 'package:movies/src/search/search_delegate.dart';
import 'package:movies/src/widgets/card_swipper.dart';
import 'package:movies/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  final MoviesProvider _moviesProvider = MoviesProvider();

  @override
  Widget build(BuildContext context) {
    _moviesProvider.getPopulars();

    return Scaffold(
        appBar: AppBar(
          title: Text('Movies on cinenema!'),
          backgroundColor: Colors.indigoAccent,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: DataSearch(),
                );
              },
            )
          ],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: _swipperTarjets(context),
              ),
              Expanded(
                flex: 1,
                child: _footer(context),
              ),
            ],
          ),
        ));
  }

  Widget _swipperTarjets(context) {
    return Container(
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
    return Container(
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
          Expanded(
            child: StreamBuilder(
              stream: _moviesProvider.popularsStream,
              builder:
                  (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
                if (snapshot.hasData) {
                  return MovieHorizontal(
                    movies: snapshot.data,
                    nextPage: _moviesProvider.getPopulars,
                  );
                }
                return Center(child: CircularProgressIndicator(),);
              },
            ),
          ),
        ],
      ),
    );
  }
}
