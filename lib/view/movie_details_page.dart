import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movief/consts/colors.dart';
import '../model/movie_details.dart';
import 'package:transparent_image/transparent_image.dart';

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

  void getDetail() async {
    var response;
    response = await MovieDetail().fetchMovieDetails(widget.id);
    setState(() {
      movie = response;
    });
  }

  @override
  void initState() {
    getDetail();
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
                        CustomDivider(),
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
                              '${movie.runtime > 60 ? '${movie.runtime/60.round()} h ${movie.runtime-60} m' : '${movie.runtime} m' }',
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
                        CustomDivider(),
                        // Genres
                        Placeholder(),
                        CustomDivider(),
                        // Trailer
                        Placeholder(),
                        CustomDivider(),
                        // Similar Movies
                        Placeholder()
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

class CustomDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.003,
        ),
        Divider(
          thickness: 2,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.003,
        ),
      ],
    );
  }
}
