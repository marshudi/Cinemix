import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:cinemix/AdminUI/MoviePage.dart';

class SearchTab extends StatefulWidget {

  const SearchTab({Key? key}) : super(key: key);

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final TextEditingController _searchController = TextEditingController();
  DatabaseReference movieRef = FirebaseDatabase.instance.ref().child("Movie");
  Query movieQuery = FirebaseDatabase.instance.ref().child("Movie");
  late Query filteredQuery;
  // List<Map> movies = [];
  @override
  void initState() {
    super.initState();
    filteredQuery = movieQuery; // Initialize with the original query
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 23, 30, 1.0),
        title: TextField(
          controller: _searchController,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(color: Colors.white70),
          ),
          onChanged: (value) {
            setState(() {
              // search functionality i have tried using the search by anything using contains method but didnt work there is an issue in it
              //  it needed more time to be fixed!
              // Update the filteredQuery based on the search text
              filteredQuery = movieQuery.orderByChild('movieName').startAt(value).endAt(value + '\uf8ff');
              //filteredQuery = _movies.where((movie)=>movie.movieName.toLowerCase);
            });
          },
        ),
      ),
      backgroundColor: Color.fromRGBO(2, 41, 63, 1.0),
      body: SingleChildScrollView(
        child: buildMovieSectionAll("Search Results", filteredQuery),
      ),
    );
  }

  Widget buildMovieSectionAll(String sectionTitle, Query sectionQuery) {
    return SingleChildScrollView(
      child: Column(
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
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.0),
          Container(
            height: 640.0,
            child: StreamBuilder(
              stream: sectionQuery.onValue,
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Add a loading delay of 2 seconds
                  Future.delayed(Duration(seconds: 2), () {
                    if (!snapshot.hasData) {
                      // Display a CircularProgressIndicator while loading
                      return Center(child: CircularProgressIndicator());

                    }
                  });
                }
                //the delay circle animation rounding dosnet work!!

                if (snapshot.hasData) {
                  Map<dynamic, dynamic>? values = (snapshot.data?.snapshot?.value as Map?) ?? {};
                  List<Map> movies = [];


                  values.forEach((key, value) {
                    value['key'] = key;
                    movies.add(value);
                  });

                  if (movies.isEmpty) {
                    // Display a "Not Found" message
                    return Center(child: Text("No results found.",
                      style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                    ),));
                  }

                  // Use ListView.builder to create a grid-like layout with two columns
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical, // Change to vertical
                    itemCount: (movies.length / 2).ceil(),
                    itemBuilder: (BuildContext context, int rowIndex) {
                      int startIndex = rowIndex * 2;

                      return Row(
                        children: List.generate(2, (index) {
                          int movieIndex = startIndex + index;

                          if (movieIndex < movies.length) {
                            Map movie = movies[movieIndex];

                            return Expanded(
                              child: MovieCard(movie: movie),
                            );
                          } else {
                            return SizedBox.shrink();
                          }
                        }),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          SizedBox(height: 22.0),
        ],
      ),
    );
  }

  Widget MovieCard({required Map movie}) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MoviePage(
              movieImage: movie["image"],
              movieID: movie["movieID"],
              movieName: movie["movieName"],
              movieGenre: movie["genre"],
              youID: movie["youTubeID"],
              movieDesc: movie["description"],
              movieKey:movie['key'],
            ),
          ),
        );
      },
      child: Column(
        children: <Widget>[
          Card(
            elevation: 0.0,
            child: Image.network(
              movie["image"],
              fit: BoxFit.fill,
              width: 130.0,
              height: 160.0,
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            movie["movieName"],
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 10.0,
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 5.0),
        ],
      ),
    );
  }
}
