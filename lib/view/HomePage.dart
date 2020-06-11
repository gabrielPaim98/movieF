import 'package:flutter/material.dart';
import '../components/movie_card.dart';
import '../model/movie.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var movieCards = <MovieCard>[];

  Future<List<MovieCard>> _getMovies() async {
    movieCards.clear();
    await Movie().fetchPopularMovies().then((value) => value.forEach((e) {
          movieCards.add(MovieCard(
              title: e.title, voteAverage: e.voteAverage, overview: e.overview, posterPath: e.posterPath,));
        }));
    return movieCards;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('movieF'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: FutureBuilder<List<MovieCard>>(
              future: _getMovies(),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? Column(
                        children: movieCards,
                      )
                    : Center(
                        heightFactor: MediaQuery.of(context).size.height * 0.01,
                        child: CircularProgressIndicator(),
                      );
              }),
        ));
  }
}
