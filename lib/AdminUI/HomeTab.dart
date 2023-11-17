import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:cinemix/AdminUI//Movie.dart';





class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  DatabaseReference mydb = FirebaseDatabase.instance.ref().child("Movie");
  Query movieQuery = FirebaseDatabase.instance.ref().child("Movie");
  String selectedGenre = "All";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(2, 41, 63, 1.0),
      body: Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: ListView(
          children: <Widget>[
            // Genre Chips
            Container(
              height: 40.0,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  buildGenreChip("All"),
                  buildGenreChip("Action"),
                  //buildGenreChip("Adventure"),
                  buildGenreChip("Comedy"),
                  buildGenreChip("Horror"),
                  buildGenreChip("Drama"),
                ],
              ),
            ),
            SizedBox(height: 12.0,),

            // Top Trends Section
            buildMovieSection("Top Trends", movieQuery.orderByChild('timestamp').limitToLast(5)),

            SizedBox(height: 0.0,),

            // Action Section
            buildMovieSectionAll("All", movieQuery.orderByChild('timestamp')),
            buildMovieSectionAction("Action", movieQuery.orderByChild('timestamp')),
            //buildMovieSectionAdventure("Adventure", movieQuery.orderByChild('timestamp')),
            buildMovieSectionComedy("Comedy", movieQuery.orderByChild('timestamp')),
            buildMovieSectionHorror("Horror", movieQuery.orderByChild('timestamp')),
            buildMovieSectionDrama("Drama", movieQuery.orderByChild('timestamp')),

          ],
        ),
      ),
    );
  }

  Widget buildGenreChip(String genre) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedGenre = genre;
          });
        },
        child: Chip(
          label: Text(genre, style: TextStyle(color: Colors.white)),
          backgroundColor: genre == selectedGenre
              ? Color.fromRGBO(4, 159, 159, 1.0)
              : Colors.blueGrey,
          padding: EdgeInsets.only(left: 12.0, right: 12.0),
        ),
      ),
    );
  }

  Widget buildMovieSection(String sectionTitle, Query sectionQuery) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                sectionTitle,
                style: TextStyle(
                    color: Color.fromRGBO(240, 60, 136, 1.0),
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0,),

        Container(
          width: double.infinity,
          height: 230.0,
          child: FirebaseAnimatedList(
            scrollDirection: Axis.horizontal,
            query: sectionQuery,
            itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
              Map movie = snapshot.value as Map;
              // Check if the item's genre matches the selected genre before displaying it
              if (selectedGenre == "All" || movie['genre'] == selectedGenre) {
                return MovieCard(movie: movie);
              } else {
                return Container(); // Return an empty container if the genre doesn't match
              }
            },
          ),
        ),
        SizedBox(height: 22.0,),

      ],
    );
  }


  Widget buildMovieSectionAll(String sectionTitle, Query sectionQuery) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                sectionTitle,
                style: TextStyle(
                    color: Color.fromRGBO(240, 60, 136, 1.0),
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0,),

        Container(
          width: double.infinity,
          height: 230.0,
          child: FirebaseAnimatedList(
            scrollDirection: Axis.horizontal,
            query: sectionQuery,
            itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
              Map movie = snapshot.value as Map;
              if (selectedGenre == "All" || movie['genre'] == selectedGenre) {
                return MovieCard(movie: movie);
              } else {
                return Container(); // Return an empty container if the genre doesn't match
              }
              // Always display action movies in the "Action" section
              return MovieCard(movie: movie);
            },
          ),
        ),
        SizedBox(height: 22.0,),
      ],
    );
  }




  Widget buildMovieSectionAction(String sectionTitle, Query sectionQuery) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                sectionTitle,
                style: TextStyle(
                    color: Color.fromRGBO(240, 60, 136, 1.0),
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0,),

        Container(
          width: double.infinity,
          height: 230.0,
          child: FirebaseAnimatedList(
            scrollDirection: Axis.horizontal,
            query: sectionQuery,
            itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
              Map movie = snapshot.value as Map;
              if (selectedGenre == "All" && movie['genre'] == "Action" ||  selectedGenre == "Action" && movie['genre'] == "Action") {
                return MovieCard(movie: movie);
              } else {
                return Container(); // Return an empty container if the genre doesn't match
              }
              // Always display action movies in the "Action" section
              return MovieCard(movie: movie);
            },
          ),
        ),
        SizedBox(height: 22.0,),
      ],
    );
  }



  Widget buildMovieSectionComedy(String sectionTitle, Query sectionQuery) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                sectionTitle,
                style: TextStyle(
                    color: Color.fromRGBO(240, 60, 136, 1.0),
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0,),

        Container(
          width: double.infinity,
          height: 230.0,
          child: FirebaseAnimatedList(
            scrollDirection: Axis.horizontal,
            query: sectionQuery,
            itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
              Map movie = snapshot.value as Map;
              if (selectedGenre == "All" && movie['genre'] == "Comedy" ||  selectedGenre == "Comedy" && movie['genre'] == "Comedy") {
                return MovieCard(movie: movie);
              } else {
                return Container(); // Return an empty container if the genre doesn't match
              }
              // Always display action movies in the "Action" section
              return MovieCard(movie: movie);
            },
          ),
        ),
        SizedBox(height: 22.0,),
      ],
    );
  }


  Widget buildMovieSectionHorror(String sectionTitle, Query sectionQuery) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                sectionTitle,
                style: TextStyle(
                    color: Color.fromRGBO(240, 60, 136, 1.0),
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0,),

        Container(
          width: double.infinity,
          height: 230.0,
          child: FirebaseAnimatedList(
            scrollDirection: Axis.horizontal,
            query: sectionQuery,
            itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
              Map movie = snapshot.value as Map;
              if (selectedGenre == "All" && movie['genre'] == "Horror" ||  selectedGenre == "Horror" && movie['genre'] == "Horror") {
                return MovieCard(movie: movie);
              } else {
                return Container(); // Return an empty container if the genre doesn't match
              }
              // Always display action movies in the "Action" section
              return MovieCard(movie: movie);
            },
          ),
        ),
        SizedBox(height: 22.0,),
      ],
    );
  }

  Widget buildMovieSectionDrama(String sectionTitle, Query sectionQuery) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                sectionTitle,
                style: TextStyle(
                    color: Color.fromRGBO(240, 60, 136, 1.0),
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0,),

        Container(
          width: double.infinity,
          height: 230.0,
          child: FirebaseAnimatedList(
            scrollDirection: Axis.horizontal,
            query: sectionQuery,
            itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
              Map movie = snapshot.value as Map;
              if (selectedGenre == "All" && movie['genre'] == "Drama" ||  selectedGenre == "Drama" && movie['genre'] == "Drama") {
                return MovieCard(movie: movie);
              } else {
                return Container(); // Return an empty container if the genre doesn't match
              }
              // Always display action movies in the "Action" section
              return MovieCard(movie: movie);
            },
          ),
        ),
        SizedBox(height: 22.0,),
      ],
    );
  }



  Widget MovieCard({required Map movie}) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Movie(
          movieImage: movie["image"],
          movieID: movie["movieID"],
          movieName: movie["movieName"],
          movieGenre: movie["genre"],
          youID: movie["youTubeID"],
          movieDesc: movie["description"],
        )));
      },
      child: Column(
        children: <Widget>[
          Card(
            elevation: 0.0,
            child: Image.network(movie["image"], fit: BoxFit.fill, width: 130.0, height: 160.0,),
          ),
          SizedBox(height: 5.0,),
          Text(
            movie["movieName"],
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 10.0
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 5.0),
        ],
      ),
    );
  }
}
