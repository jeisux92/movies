import 'package:flutter/material.dart';
import 'package:movies/src/models/movie.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Movie> movies;
  final Function nextPage;

  MovieHorizontal({@required this.movies, @required this.nextPage});

  final PageController _pageController = PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        nextPage();
      }
    });

    return Container(
      height: _screenSize.height * 0.3,
      child: PageView.builder(
        pageSnapping: false,
        itemCount: movies.length,
        controller: _pageController,
        itemBuilder: (BuildContext context, int index) =>
            _card(context, movies[index]),
      ),
    );
  }

  List<Widget> _cards(BuildContext context) {
    return movies
        .map(
          (m) => Container(
            margin: EdgeInsets.only(right: 15.0),
            child: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: FadeInImage(
                      placeholder: AssetImage('assets/img/no-image.jpg'),
                      image: NetworkImage(m.getPosterImg()),
                      height: 160.0,
                      fadeInDuration: Duration(milliseconds: 200),
                      fit: BoxFit.cover),
                ),
                SizedBox(height: 5.0),
                Text(
                  m.title,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.caption,
                )
              ],
            ),
          ),
        )
        .toList();
  }

  Widget _card(BuildContext context, Movie movie) {
    return Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(movie.getPosterImg()),
                height: 160.0,
                fadeInDuration: Duration(milliseconds: 200),
                fit: BoxFit.cover),
          ),
          SizedBox(height: 5.0),
          Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );
  }
}
