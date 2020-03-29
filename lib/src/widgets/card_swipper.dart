import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movies/src/models/movie.dart';

class CardSwipper extends StatelessWidget {
  final List<Movie> movies;

  CardSwipper({@required this.movies});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        itemWidth: _screenSize.width * 0.6,
        itemHeight: _screenSize.height * 0.5,
        layout: SwiperLayout.STACK,
        itemCount: movies.length,
        itemBuilder: (BuildContext context, int index) {
          movies[index].uId = "${movies[index].id}-card";
          return Hero(
            tag: movies[index].uId,
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'detail',
                  arguments: movies[index]),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: FadeInImage(
                    image: NetworkImage(
                      movies[index].getPosterImg(),
                    ),
                    placeholder: AssetImage('assets/img/loading.gif'),
                    fit: BoxFit.fill,
                  )),
            ),
          );
        },
      ),
    );
  }
}
