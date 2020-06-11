import 'package:flutter/material.dart';
import '../consts/colors.dart';
import '../model/movie.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var movieCards = <MovieCard>[];

  Future<List<MovieCard>> _getMovies() async {
    movieCards.clear();
    await Movie.fetchPopularMovies().then(
            (value) => value.forEach((e) {
              print(e.toJson());
              movieCards.add(MovieCard(title: e.title, voteAverage: e.voteAverage, overview: 'des'));
            })
    );
    return movieCards;
  }

  @override
  void initState() {
    _getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('movieF'),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(onPressed: () async{
          Movie.fetchPopularMovies().then((value) => print(value[0].toJson()));
        }),
        body: SingleChildScrollView(
          child: FutureBuilder<List<MovieCard>>(
              future: _getMovies(),
              builder: (context, snapshot) {
                return Column(children: movieCards,
                );
              }),
        )
      // MovieCard(title: 'Titulo', overview: 'Descricao', voteAverage: 7,),
    );
  }
}

class MovieCard extends StatelessWidget {
  const MovieCard({
    @required this.title,
    @required this.voteAverage,
    @required this.overview,
  });

  final String title;
  final int voteAverage;
  final String overview;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      height: MediaQuery
          .of(context)
          .size
          .height * 0.3,
      width: double.infinity,
      decoration: BoxDecoration(
        color: KWhite,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: KGold,
              borderRadius: BorderRadius.circular(12),
            ),
            width: MediaQuery
                .of(context)
                .size
                .height * 0.2,
            height: double.infinity,
          ),
          Column(
            children: <Widget>[
              Text(title,
                  style: TextStyle(
                      color: KDark, fontSize: 22, fontWeight: FontWeight.bold)),
              Text(overview,
                  style: TextStyle(
                    color: KDark,
                    fontSize: 17,
                  )),
              Text(voteAverage.toString(),
                  style: TextStyle(
                    color: KDark,
                    fontSize: 17,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
