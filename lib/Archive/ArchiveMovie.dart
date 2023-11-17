import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class Movie extends StatefulWidget {

  final String movieImage,movieID,movieName,movieGenre,youID,movieDesc;

  const Movie({super.key,
    required this.movieImage,
    required this.movieID,
    required this.movieName,
    required this.movieGenre,
    required this.youID,
    required this.movieDesc});

  @override
  _MovieState createState() => _MovieState();
}

class _MovieState extends State<Movie> {
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
      // appBar: AppBar(
      //   title: Text('YouTube Player'),
      // ),
      body: Center(
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.blueAccent,
        ),

      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
