import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:movie_app_21_2_21/src/models/movies_model.dart';
import 'package:movie_app_21_2_21/src/providers/movies_providers.dart';

class DataSearch extends SearchDelegate {
  final movies = [
    'SpiderMan',
    'Batman',
    'Robin For ever',
  ];
  final recentMovies = [
    'CaptainAmerica',
    'Bob esponja',
  ];
  String selection;
  final movieProvider = new MovieProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    // appBar actions
    return <Widget>[
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = "",
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Left Icon
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Builder of results
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
    if (query.isEmpty) {
      return Container();
    }
    return FutureBuilder(
      future: movieProvider.searchMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData) {
          final movies = snapshot.data;
          return ListView(
            children: movies.map((movie){
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(movie.getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  width: 50.0,
                  fit: BoxFit.contain,
                ),
                title: Text(movie.title),
                subtitle: Text(movie.originalTitle),
                onTap: (){ 
                  close(context, null);
                  movie.uniqueId = "";
                  Navigator.pushNamed(context, 'movieDetail', arguments: movie);
                },
              );
            }).toList(),
          );
        } else {
          return Center(
            child: SpinKitCubeGrid(
              color: Colors.indigoAccent,
              size: 50.0,
            ),
          );
        }
      },
    );
  }
}
