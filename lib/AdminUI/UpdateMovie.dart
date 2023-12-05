import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

enum MovieGenre { Action, Comedy, Horror, Drama }

class UpdateMovie extends StatefulWidget {
  final String movieKey,movieID, movieImage, movieName, movieGenre, youID, movieDesc;

  const UpdateMovie({
    Key? key,
    // required this.movieKey,
    required this.movieID,
    required this.movieImage,
    required this.movieName,
    required this.movieGenre,
    required this.youID,
    required this.movieDesc,
    required this.movieKey,
  }) : super(key: key);

  @override
  _UpdateMovieState createState() => _UpdateMovieState();
}

class _UpdateMovieState extends State<UpdateMovie> {
  TextEditingController mName = TextEditingController();
  TextEditingController mDesc = TextEditingController();
  TextEditingController mImage = TextEditingController();
  TextEditingController mLink = TextEditingController();
  MovieGenre _selectedGenre = MovieGenre.Action; // Set a default genre
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  DatabaseReference movieReference = FirebaseDatabase.instance.ref("Movie");

  @override
  void initState() {
    super.initState();
    // Set initial values for the text controllers
    mName.text = widget.movieName;
    mDesc.text = widget.movieDesc;
    mImage.text = widget.movieImage;
    mLink.text = widget.youID;
    _selectedGenre = MovieGenre.values.firstWhere(
          (genre) => genre.toString() == 'MovieGenre.${widget.movieGenre}',
      orElse: () => MovieGenre.Action, // Set a default genre if not found
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 23, 30, 1.0),
        title: Text('Update Movie'),
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
                    return "Please Enter an Image URL";
                  }
                },
              ),
              SizedBox(height: 16.0),
              FormBuilderTextField(
                controller: mLink,
                name: 'YouTube ID',
                decoration: InputDecoration(labelText: 'YouTube ID'),
                validator: (value){
                  if (value == null || value.isEmpty) {
                    return "Please Enter The YouTube ID of the movie";
                  }
                },
              ),
              SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.saveAndValidate()) {
                    updateMovie();
                  }
                },
                child: Text('Update Movie'),
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

  void updateMovie() {

    print("######################################");
    //print("MOVIE : ID: ${}");
    print("######################################");
    // Check if _selectedGenre is not null before accessing its value


    // Update the movie details in the database
     movieReference.child(widget.movieKey).update({
      'movieName': mName.text,
      'description': mDesc.text,
      'genre': _selectedGenre.toString().split('.').last,
      'image': mImage.text,
      'movieID': widget.movieID,
      'youTubeID': mLink.text,
    }).then((_) {
      Navigator.pop(context); // Close the update page after updating
    }).catchError((error) {
      print('Error updating movie: $error');
    });
  }

}
