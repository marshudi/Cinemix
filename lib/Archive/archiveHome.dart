import 'package:cinemix/UserUI/Movie.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  DatabaseReference mydb = FirebaseDatabase.instance.ref().child("Movie");
  Query movieQuery = FirebaseDatabase.instance.ref().child("Movie");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(2, 41, 63, 1.0),
      // appBar: AppBar(
      //   title: const Text(''),
      // ),
      body:Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: ListView(
          children: <Widget>[




            Container(
              height: 40.0,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Chip(
                      label: Text("All",style: TextStyle(color: Colors.white)),
                      backgroundColor: Color.fromRGBO(4, 159, 159, 1.0),
                      padding: EdgeInsets.only(left: 12.0, right: 12.0),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Chip(
                      label: Text("Action",style: TextStyle(color: Colors.white),),
                      backgroundColor: Colors.blueGrey,
                      padding: EdgeInsets.only(left: 12.0, right: 12.0),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Chip(
                      label: Text("Adventure",style: TextStyle(color: Colors.white)),
                      backgroundColor: Colors.blueGrey,
                      padding: EdgeInsets.only(left: 12.0, right: 12.0),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Chip(
                      label: Text("Comedy",style: TextStyle(color: Colors.white)),
                      backgroundColor: Colors.blueGrey,
                      padding: EdgeInsets.only(left: 12.0, right: 12.0),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.0,),



            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    "Top Trends",
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
              width:double.infinity,
              height: 230.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:12.0),
                    child: FirebaseAnimatedList(
                      query: movieQuery.orderByChild('timestamp').limitToLast(5),
                      itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                        Map movie = snapshot.value as Map;
                        return MovieCard(movie: movie);
                      },
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal:12.0),
                  //   child: MovieCard("Avengers", "8.5/10","assets/Movies/joker11.jpg"),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal:12.0),
                  //   child: MovieCard("Terminator", "8.5/10","assets/Movies/joker11.jpg"),
                  // ),
                ],
              ),
            ),
            SizedBox(height: 25.0,),



            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    "Action",
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
              width:double.infinity,
              height: 230.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:12.0),
                    child: FirebaseAnimatedList(
                      query: movieQuery,
                      itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                        Map movie = snapshot.value as Map;

                        // Check if the item's genre is "Action" before displaying it
                        if (movie['genre'] == 'Action') {
                          return MovieCard(movie: movie);
                        } else {
                          // Return an empty container if the genre is not "Action"
                          return Container();
                        }
                      },
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal:12.0),
                  //   child: MovieCard("Interstellar", "9.5/10","assets/Movies/joker11.jpg"),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal:12.0),
                  //   child: MovieCard("Terminator", "8.5/10","assets/Movies/joker11.jpg"),
                  // ),
                  SizedBox(height: 22.0,)
                ],
              ),
            ),
          ],
        ),


      ),
    );
  }

  Widget MovieCard({required Map movie}){
    return InkWell(
      onTap: (){
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
            child:Image.asset(movie["image"],fit: BoxFit.fill,width: 130.0,height: 160.0,),
          ),
          SizedBox(height: 5.0,),
          Text(movie["movieName"],
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 26.0
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(height:5.0),
          // Text(rate,style: TextStyle(
          //     color: Colors.white,
          //     fontSize: 18.0
          // ),),
        ],
      ),
    );
  }
}
