import 'package:cinemix/AdminUI/UpdateMovie.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MoviePage extends StatefulWidget {
  final String movieKey,movieImage, movieID, movieName, movieGenre, youID, movieDesc;

  const MoviePage({
    Key? key,
    required this.movieImage,
    required this.movieID,
    required this.movieName,
    required this.movieGenre,
    required this.youID,
    required this.movieDesc,
    required this.movieKey,
  }) : super(key: key);

  @override
  _MoviePageState createState() => _MoviePageState();
}
class _MoviePageState extends State<MoviePage> {

  DatabaseReference reference = FirebaseDatabase.instance.ref().child('Movie');
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
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'update') {
                // Implement update movie logic
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                    builder: (context) => UpdateMovie(
                        movieID: widget.movieID,
                        movieImage: widget.movieImage,
                        movieName: widget.movieName,
                        movieGenre: widget.movieGenre,
                        youID: widget.youID,
                        movieDesc: widget.movieDesc,
                        movieKey: widget.movieKey
                    )));
              } else if (value == 'delete') {
                // Implement delete movie logic
                displayMyAlertDialog(context);
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'update',
                child: Text('Update Movie'),
              ),
              const PopupMenuItem<String>(
                value: 'delete',
                child: Text(
                  'Delete Movie',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ],
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

  void displayMyAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: Color.fromRGBO(0, 64, 86, 1.0),
          title: Text(
            "Delete Confirmation",
            style: TextStyle(color: Color.fromRGBO(231, 68, 68, 1.0)),
          ),
          content: Text(
            "Movie Name: ${widget.movieName}\n\nAre you sure you want to delete this Movie?",
            style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1.0)),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Implement delete movie logic
                deleteMovieFromFirebase();
                Navigator.pop(context);
                Navigator.pop(dialogContext);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
              child: Text('Delete Movie'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteMovieFromFirebase() async {
    // Reference to the Movie in the database
   // DatabaseReference movieReference = FirebaseDatabase.instance.ref('Movie').child(widget.movieID);
   //
    print("#####################################################");
    print("printing ID: ${widget.movieKey}");
    print("#####################################################");
    // print('Deleting Movie: ${widget.movieID}');
    // Remove the Movie from the database
    try {
      // Remove the Movie from the database
      await reference.child(widget.movieKey).remove();
      print('Movie deleted successfully: ${reference.child(widget.movieKey).remove()}');
    } catch (error) {
      print('Error deleting movie: $error');
    }
  }






}

