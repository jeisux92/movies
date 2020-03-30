import 'package:flutter/material.dart';
import 'package:movies/src/models/actor.dart';
import 'package:movies/src/models/movie.dart';
import 'package:movies/src/providers/movies_provider.dart';

class MovieDetail extends StatelessWidget {
  Size _size;
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;
    _size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _createAppBar(movie),
          SliverList(
            delegate: SliverChildListDelegate([
              _titlePoster(context, movie),
              _description(movie),
              _createCasting(movie)
            ]),
          )
        ],
      ),
    );
  }

  Widget _createAppBar(Movie movie) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.redAccent,
      expandedHeight: _size.height * 0.25,
      floating: true,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(movie.title,
            style: TextStyle(color: Colors.white, fontSize: 16.0)),
        background: FadeInImage(
          image: NetworkImage(movie.getBackgroundImg()),
          placeholder: AssetImage('assets/img/loading.gif'),
          fadeInDuration: Duration(milliseconds: 2),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _titlePoster(BuildContext context, Movie movie) {
    return Container(
        height: _size.height * 0.25,
        color: Colors.red,
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: movie.uId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(
                  movie.getPosterImg(),
                  height: _size.height * 0.25,
                ),
              ),
            ),
            SizedBox(width: 20.0),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    movie.title,
                    style: Theme.of(context).textTheme.title,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    movie.originalTitle,
                    style: Theme.of(context).textTheme.subhead,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.star_border,
                      ),
                      Text(movie.voteAverage.toString(),
                          style: Theme.of(context).textTheme.subhead)
                    ],
                  )
                ],
              ),
            ),
          ],
        ));
  }

  Widget _description(Movie movie) {
    return Container(
      color: Colors.green,
      height: _size.height * 0.25,
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _createCasting(Movie movie) {
    final movieProvider = MoviesProvider();
    return Container(
      height: _size.height * 0.25,
      color:Colors.blue,
      child: FutureBuilder(
        future: movieProvider.getCast(movie.id),
        builder: (BuildContext context, AsyncSnapshot<List<Actor>> snapshot) {
          if (snapshot.hasData) {
            return _createActorsPageView(snapshot.data);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _createActorsPageView(List<Actor> actors) {
    return PageView.builder(
      pageSnapping: false,
      controller: PageController(
        viewportFraction: 0.3,
        initialPage: 1,
      ),
      itemCount: actors.length,
      itemBuilder: (BuildContext context, int index) {
        return _actorCard(actors[index]);
      },
    );
  }

  Widget _actorCard(Actor actor) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(actor.getPhoto),
              placeholder: AssetImage('assets/img/no-image.jpg'),              
              fit: BoxFit.fill,
            ),
          ),
        ),
        Text(
          actor.name,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
