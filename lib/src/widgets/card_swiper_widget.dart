import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movie_app_21_2_21/src/models/movies_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;

  CardSwiper({@required this.movies});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.70,
        itemHeight: _screenSize.height * 0.50,
        itemBuilder: (BuildContext context, int index) =>
            _createCard(context, movies[index]),
        itemCount: 3,
      ),
    );
  }

  Widget _createCard(BuildContext context, Movie movie) {
    movie.uniqueId = "${movie.id}-card";
    
    final card = ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: FadeInImage(
        image: NetworkImage(movie.getPosterImg()),
        placeholder: AssetImage('assets/img/no-image.jpg'),
        fit: BoxFit.cover,
      ),
    );

    return GestureDetector(
      child: card,
      onTap: () {
        Navigator.pushNamed(context, 'movieDetail', arguments: movie);
      },
    );
  }
}
