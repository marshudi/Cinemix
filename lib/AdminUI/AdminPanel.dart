import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:cinemix/AdminUI/MovieModel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

enum MovieGenre { Action, Comedy, Horror, Drama }

class AdminPanel extends StatefulWidget {
  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  DatabaseReference mydb = FirebaseDatabase.instance.ref("Movie");
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  MovieGenre _selectedGenre = MovieGenre.Action;
  TextEditingController mName = TextEditingController();
  TextEditingController mDesc = TextEditingController();
  TextEditingController mImage = TextEditingController();
  TextEditingController mLink = TextEditingController();

  Query movieQuery = FirebaseDatabase.instance.ref().child("Movie");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 23, 30, 1.0),
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          alignment: Alignment.bottomCenter,
          child: Text(
            "Admin Panel",
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
            ),
          ),
        ),
      ),
      backgroundColor: Color.fromRGBO(191, 206, 206, 1.0),
      body: Padding(

        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              FormBuilderTextField(
                controller: mName,
                name: 'movieName',
                decoration: InputDecoration(labelText: 'Movie Name'),
                validator: (value){
                  if (value == null || value.isEmpty) {
                    return "Please Enter Movie Name";
                  }
                },
              ),
              SizedBox(height: 16.0),
              FormBuilderDropdown(
                name: 'genre',
                initialValue: _selectedGenre,
                decoration: InputDecoration(labelText: 'Genre'),
                items: MovieGenre.values
                    .map(
                      (genre) => DropdownMenuItem(
                    value: genre,
                    child: Text(genre.toString().split('.').last),
                  ),
                )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedGenre = value as MovieGenre;
                  });
                },
              ),
              SizedBox(height: 16.0),
              FormBuilderTextField(
                controller: mDesc,
                name: 'description',
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value){
                  if (value == null || value.isEmpty) {
                    return "Please Enter Movie Description";
                  }
                },
              ),
              SizedBox(height: 16.0),
              FormBuilderTextField(
                controller: mImage,
                name: 'Image Link',
                decoration: InputDecoration(labelText: 'Image Link'),
                validator: (value){
                  if (value == null || value.isEmpty) {
                    return "Please Enter Image URL";
                  }
                  // if (!RegExp(r'^https?:\/\/.*\.(png|jpg|jpeg|gif|bmp)$',
                  //   caseSensitive: false).hasMatch(value)) {
                  //   return 'Enter a valid image URL';
                  // }
                },
              ),
              SizedBox(height: 16.0),
              FormBuilderTextField(
                controller: mLink,
                name: 'YouTube ID',
                decoration: InputDecoration(labelText: 'YouTube ID'),
                validator: (value){
                  if (value == null || value.isEmpty) {
                    return "Please Enter YouTube ID";
                  }
                },
              ),

              SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.saveAndValidate() ?? false) {
                    int newMovieID = await getNewMovieID();

                    print('The new movie ID $newMovieID');
                    print('Selected Genre ${_selectedGenre.toString().split('.').last}');

                    Movie newMovie = Movie(
                      mImage.text,
                      newMovieID.toString(),
                      mName.text,
                      _selectedGenre.toString().split('.').last,
                      mLink.text,
                      mDesc.text,
                    );

                    // Push the new movie to the end of the list
                    mydb.push().set(newMovie.toJson());

                    // Clear text controllers
                    mName.clear();
                    mDesc.clear();
                    mImage.clear();
                    mLink.clear();

                    // Show a SnackBar
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Movie Added Successfully!"),
                      ),
                    );
                  }
                },
                child: Text('Add'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 48.0),
                  backgroundColor: Color.fromRGBO(0, 96, 129, 1.0), // Set your desired button background color
                  onPrimary: Colors.white, // Set the text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0), // Set the border radius
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16.0), // Set vertical padding
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Future<int> getNewMovieID() async {
    var snapshot = await movieQuery.limitToLast(1).once();
    var lastMovie = snapshot.snapshot.value as Map<Object?, Object?>?;

    int lastMovieID = 0;
    if (lastMovie != null) {
      var movieIDValue = lastMovie.values.first;
      if (movieIDValue is Map<Object?, Object?>) {
        var movieID = movieIDValue['movieID'];
        if (movieID is int) {
          lastMovieID = movieID;
        } else if (movieID is String) {
          lastMovieID = int.tryParse(movieID) ?? 0;
        }
      }
    }

    return lastMovieID + 1;
  }
}
