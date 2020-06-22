import 'package:flutter/material.dart';
import '../components/movie_card.dart';
import '../model/movie.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  List<MovieCard> popMovieCards = List();
  List<MovieCard> playMovieCards = List();
  List<MovieCard> upMovieCards = List();
  int page = 1;
  final scrollController = ScrollController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey2 =
      GlobalKey<RefreshIndicatorState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey3 =
      GlobalKey<RefreshIndicatorState>();
  TabController _tabController;

  Future<List<MovieCard>> _getMovies() async {
    var response;
    switch (_tabController.index) {
      case 0:
        {
          response = await Movie().fetchPopularMovies(page);
          setState(() {
            response.forEach((e) {
              popMovieCards.add(MovieCard(
                title: e.title,
                voteAverage: e.voteAverage,
                overview: e.overview,
                posterPath: e.posterPath,
                movieId: e.id,
              ));
            });
          });
          return popMovieCards;
        }
        break;

      case 1:
        {
          response = await Movie().fetchPlayingMovies(page);
          setState(() {
            response.forEach((e) {
              playMovieCards.add(MovieCard(
                title: e.title,
                voteAverage: e.voteAverage,
                overview: e.overview,
                posterPath: e.posterPath,
                movieId: e.id,
              ));
            });
          });
          return playMovieCards;
        }
        break;

      case 2:
        {
          response = await Movie().fetchUpcomingMovies(page);
          setState(() {
            response.forEach((e) {
              upMovieCards.add(MovieCard(
                title: e.title,
                voteAverage: e.voteAverage,
                overview: e.overview,
                posterPath: e.posterPath,
                movieId: e.id,
              ));
            });
          });
          return upMovieCards;
        }
        break;

      default:
        {
          response = await Movie().fetchPopularMovies(page);
          setState(() {
            response.forEach((e) {
              popMovieCards.add(MovieCard(
                  title: e.title,
                  voteAverage: e.voteAverage,
                  overview: e.overview,
                  posterPath: e.posterPath));
            });
          });
          return popMovieCards;
        }
        break;
    }
  }

  Future<Null> _refresh() async {
    page = 1;
    popMovieCards.clear();
    playMovieCards.clear();
    upMovieCards.clear();
    await _getMovies();
  }

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      _refresh();
    });

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
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('movieF'),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'Popular',
              ),
              Tab(
                text: 'Now Playing',
              ),
              Tab(
                text: 'Upcoming',
              )
            ],
            controller: _tabController,
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            // Popular Movies
            popMovieCards.length == 0
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    key: _refreshIndicatorKey,
                    onRefresh: _refresh,
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: popMovieCards.length + 1,
                      itemBuilder: (_context, index) {
                        if (index < popMovieCards.length) {
                          return popMovieCards[index];
                        } else {
                          return Padding(
                            padding: const EdgeInsets.all(32),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                      },
                    ),
                  ),
            // Now Playing Movies
            playMovieCards.length == 0
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    key: _refreshIndicatorKey2,
                    onRefresh: _refresh,
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: playMovieCards.length + 1,
                      itemBuilder: (_context, index) {
                        if (index < playMovieCards.length) {
                          return playMovieCards[index];
                        } else {
                          return Padding(
                            padding: const EdgeInsets.all(32),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                      },
                    ),
                  ),
            // Upcoming Movies
            upMovieCards.length == 0
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    key: _refreshIndicatorKey3,
                    onRefresh: _refresh,
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: upMovieCards.length + 1,
                      itemBuilder: (_context, index) {
                        if (index < upMovieCards.length) {
                          return upMovieCards[index];
                        } else {
                          return Padding(
                            padding: const EdgeInsets.all(32),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
