import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:movie_app_21_2_21/src/providers/movies_providers.dart';
import 'package:movie_app_21_2_21/src/search/search_delegate.dart';
import 'package:movie_app_21_2_21/src/widgets/card_swiper_widget.dart';
import 'package:movie_app_21_2_21/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  final movieProvider = MovieProvider();

  @override
  Widget build(BuildContext context) {
    movieProvider.getPopular();
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies'),
        centerTitle: false,
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {
            showSearch(context: context, delegate: DataSearch());
          }),
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperCards(),
            _footer(context),
          ],
        ),
      ),
    );
  }
 
  Widget _swiperCards() {
    return FutureBuilder(
      future: movieProvider.getNowPLaying(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(movies: snapshot.data);
        } else {
          return Container(
            height: 400.0,
            child: Center(
              child: SpinKitCubeGrid(
                color: Colors.indigoAccent,
                size: 50.0,
              ),
            ),
          );
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return StreamBuilder(
      stream: movieProvider.popularStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Popular',
                      style: Theme.of(context).textTheme.subtitle1,
                    )),
                SizedBox(
                  height: 5.0,
                ),
                MovieHorizontal(
                  movies: snapshot.data,
                  nextPage: movieProvider.getPopular,
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
