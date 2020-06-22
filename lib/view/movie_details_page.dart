import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/movie.dart';
import '../consts/colors.dart';
import '../model/movie_details.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:http/http.dart' as http;
import '../model/actor.dart';

class MovieDetailsPage extends StatefulWidget {
  MovieDetailsPage({
    @required this.id,
    @required this.title,
  });

  final int id;
  final String title;

  @override
  _MovieDetailsPageState createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  MovieDetail movie;
  YoutubePlayerController _ytController;
  List<Actor> actors = List<Actor>();
  List<Movie> similarMovies = List<Movie>();

  void getDetail() async {
    var response;
    response = await MovieDetail().fetchMovieDetails(widget.id);
    setState(() {
      movie = response;
    });
  }

  void getTrailer() async {
    var response;

    await http
        .get(
            'https://api.themoviedb.org/3/movie/${widget.id}/videos?api_key=92617104f2646d905240d1f828861df6&language=en-US')
        .then((value) => response = jsonDecode(value.body)['results']);

    setState(() {
      _ytController = YoutubePlayerController(
        initialVideoId: response[0]['key'],
        flags: YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      );
    });
  }

  void getActors() async {
    var response;
    response = await Actor().fetchActors(widget.id);
    setState(() {
      actors = response;
    });
  }

  void getSimilarMovies() async {
    var response;
    response = await Movie().fetchSimilarMovies(widget.id);
    setState(() {
      similarMovies = response;
    });
  }

  @override
  void initState() {
    getDetail();
    getTrailer();
    getActors();
    getSimilarMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 400.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(widget.title),
                background: movie == null
                    ? SizedBox(
                        width: double.infinity,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Stack(
                        children: <Widget>[
                          Center(
                            child: CircularProgressIndicator(),
                          ),
                          FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image:
                                'https://image.tmdb.org/t/p/original${movie.posterPath}',
                            fit: BoxFit.fitWidth,
                            width: double.infinity,
                          ),
                        ],
                      ),
              ),
            ),
          ];
        },
        body: Scaffold(
          body: movie == null
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Overview
                        RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            text: 'Overview: ',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                              TextSpan(
                                text: movie.overview,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),

                        // Release Date, Runtime and Vote Average
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              '${movie.releaseDate.month.toString().length == 2 ? movie.releaseDate.month : '0${movie.releaseDate.month}'}/${movie.releaseDate.day}/${movie.releaseDate.year}',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${Duration(minutes: movie.runtime).inHours} h ${movie.runtime - (Duration(minutes: movie.runtime).inHours * 60)} m',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.star,
                                  color: KGold,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.01,
                                ),
                                Text(
                                  '${movie.voteAverage}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),

                        // Genres
                        Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: movie.genres.length,
                                itemBuilder: (_context, index) {
                                  return Container(
                                    margin: EdgeInsets.all(8),
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: KDark,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          width: 1,
                                          color: KWhite,
                                        )),
                                    child: Center(
                                        child: Text(
                                      movie.genres[index].name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    )),
                                  );
                                })),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),

                        // Trailer
                        Text(
                          'Trailer',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        _ytController == null
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : YoutubePlayer(
                                controller: _ytController,
                                width: double.infinity,
                                bottomActions: <Widget>[],
                              ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),

                        // Actors
                        Text(
                          'Actors',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        actors.length == 0
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Container(
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 7,
                                    itemBuilder: (_context, index) {
                                      return Container(
                                        margin: EdgeInsets.all(8),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.all(
                                                      Radius.circular(12)),
                                              child: Stack(
                                                children: <Widget>[
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.35,
                                                    child: Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    ),
                                                  ),
                                                  FadeInImage.memoryNetwork(
                                                    placeholder:
                                                        kTransparentImage,
                                                    image:
                                                        'https://image.tmdb.org/t/p/w500/${actors[index].profilePath}',
                                                    fit: BoxFit.fitWidth,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.32,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context).size.height * 0.02,
                                            ),
                                            Text(
                                              actors[index].name,
                                              style:
                                                  TextStyle(color: KWhite, fontSize: 18),
                                            )
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),

                        // Similar Movies
                        Text(
                          'Similar Movies',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        similarMovies.length == 0
                            ? Center(
                          child: CircularProgressIndicator(),
                        )
                            : Container(
                          width: double.infinity,
                          height:
                          MediaQuery.of(context).size.height * 0.4,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 7,
                              itemBuilder: (_context, index) {
                                return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => MovieDetailsPage(
                                                id: similarMovies[index].id,
                                                title: similarMovies[index].title,
                                              )));
                                    },
                                  child: Container(
                                    margin: EdgeInsets.all(8),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        ClipRRect(
                                          borderRadius:
                                          BorderRadius.all(
                                              Radius.circular(12)),
                                          child: Stack(
                                            children: <Widget>[
                                              SizedBox(
                                                width:
                                                MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.35,
                                                child: Center(
                                                  child:
                                                  CircularProgressIndicator(),
                                                ),
                                              ),
                                              FadeInImage.memoryNetwork(
                                                placeholder:
                                                kTransparentImage,
                                                image:
                                                'https://image.tmdb.org/t/p/w500/${similarMovies[index].posterPath}',
                                                fit: BoxFit.fitWidth,
                                                height:
                                                MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.32,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context).size.height * 0.02,
                                        ),
                                        Text(
                                          similarMovies[index].title,
                                          style:
                                          TextStyle(color: KWhite, fontSize: 18),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
