import 'package:flutter/material.dart';
import 'package:movies/src/models/movie.dart';
import 'package:movies/src/providers/movies_provider.dart';

class DataSearch extends SearchDelegate {
  String selection = '';
  final MoviesProvider moviesProvider = MoviesProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    // Iconos de acciones
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    // Icono a la izquierda
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    // Crear los resultados a mostrar
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Text(selection),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    if (query.isEmpty) {
      return Container();
    }
    return FutureBuilder(
      future: moviesProvider.searchMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData) {
          final movies = snapshot.data;
          return ListView(
            children: movies
                .map(
                  (m) => ListTile(
                    leading: FadeInImage(
                      image: NetworkImage(
                        m.getPosterImg(),
                      ),
                      placeholder: AssetImage('assets/img/no-image.jpg'),
                      width: 50.0,
                      fit: BoxFit.contain,
                    ),
                    title: Text(m.title.toString()),
                    subtitle: Text(m.originalTitle),
                    onTap: () {
                      close(context, null);
                      m.uId = '';
                      Navigator.pushNamed(context, 'detail', arguments: m);
                    },
                  ),
                )
                .toList(),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     // TODO: implement buildSuggestions
//     // Sugerencias que aparecen cuando la persona escribe

//     final suggestedList = (query.isEmpty)
//         ? recentMovies
//         : movies
//             .where((p) => p.toLowerCase().contains(query.toLowerCase()))
//             .toList();

//     return ListView.builder(
//       itemCount: suggestedList.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           leading: Icon(Icons.movie),
//           title: Text(suggestedList[index]),
//           onTap: () {
//             selection = suggestedList[index];
//             showResults(context);
//           },
//         );
//       },
//     );
//   }
}
