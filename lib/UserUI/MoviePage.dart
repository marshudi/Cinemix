import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MoviePage extends StatefulWidget {
  final String movieImage, movieID, movieName, movieGenre, youID, movieDesc;

  const MoviePage({
    Key? key,
    required this.movieImage,
    required this.movieID,
    required this.movieName,
    required this.movieGenre,
    required this.youID,
    required this.movieDesc,
  }) : super(key: key);

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.youID,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 23, 30, 1.0),
        title: Text(widget.movieName),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Color.fromRGBO(0, 23, 30, 1.0),
      body: Column(

        children: [
          Container(
            height: 300.0,
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.purpleAccent,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.movieName,
                  style: TextStyle(
                    color: Color.fromRGBO(240, 60, 136, 1.0),
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  widget.movieDesc,
                  style: TextStyle(
                    color: Color.fromRGBO(243, 121, 173, 1.0),
                    fontSize: 25.0,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Genre: ${widget.movieGenre}',
                  style: TextStyle(
                    color: Color.fromRGBO(255, 173, 208, 0.5),
                    fontSize: 20.0,

                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
