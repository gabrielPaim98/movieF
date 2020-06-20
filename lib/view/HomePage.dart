import 'package:flutter/material.dart';
import '../view_model/home_page_view_model.dart';
import '../components/movie_card.dart';
import '../model/movie.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MovieCard> movieCards = List();
  int page = 1;
  final scrollController = ScrollController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  Future<List<MovieCard>> _getMovies() async {
    final response = await Movie().fetchPopularMovies(page);
    setState(() {
      response.forEach((e) {
        movieCards.add(MovieCard(
            title: e.title,
            voteAverage: e.voteAverage,
            overview: e.overview,
            posterPath: e.posterPath));
      });
    });
    return movieCards;
  }

  Future<Null> _refresh() async{
    page = 1;
    movieCards.clear();
    await _getMovies();
  }

  @override
  void initState() {
    _getMovies();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        page++;
        _getMovies();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('movieF'),
        centerTitle: true,
      ),
      body: movieCards.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: _refresh,
              child: ListView.builder(
                controller: scrollController,
                itemCount: movieCards.length + 1,
                itemBuilder: (_context, index) {
                  if(index < movieCards.length){
                    return movieCards[index];
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(32),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  //return movieCards[index];
                },
              ),
            ),
    );
  }
}
