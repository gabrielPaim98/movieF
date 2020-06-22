import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../consts/colors.dart';
import '../consts/db.dart';
import 'package:transparent_image/transparent_image.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    @required this.title,
    @required this.voteAverage,
    @required this.overview,
    @required this.posterPath,
  });

  final String title;
  final String voteAverage;
  final String overview;
  final String posterPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height * 0.3,
      width: double.infinity,
      decoration: BoxDecoration(
        color: KWhite,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(12)),
            child: Stack(
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: 'https://image.tmdb.org/t/p/w500/$posterPath',
                  fit: BoxFit.fitWidth,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.53,
                    child: Text(title,
                        style: TextStyle(
                            color: KDark,
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.005,
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.53,
                    child: Text(
                      overview,
                      style: TextStyle(
                        color: KDark,
                        fontSize: 17,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.005,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.star,
                        color: KGold,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                      Text(voteAverage,
                          style: TextStyle(
                            color: KDark,
                            fontSize: 17,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
