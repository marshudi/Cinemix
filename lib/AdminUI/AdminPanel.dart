import 'dart:io'; // Import for File class
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cinemix/AdminUI/MovieModel.dart';

enum MovieGenre { Action, Comedy, Horror, Drama }

class AdminPanel extends StatefulWidget {
  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  String _imagePath = '';
  MovieGenre _selectedGenre = MovieGenre.Action;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'movieName',
                decoration: InputDecoration(labelText: 'Movie Name'),
                validator: (value){},
              ),
              SizedBox(height: 16.0),
              FormBuilderDropdown(
                name: 'genre',
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
              GestureDetector(
                onTap: () async {
                  final imagePicker = ImagePicker();
                  final pickedFile = await imagePicker.pickImage(
                    source: ImageSource.gallery,
                  );

                  if (pickedFile != null) {
                    setState(() {
                      _imagePath = pickedFile.path;
                    });
                  }
                },
                child: Container(
                  height: 150,
                  width: double.infinity,
                  color: Colors.grey,
                  child: _imagePath.isEmpty
                      ? Icon(Icons.add_a_photo, size: 50, color: Colors.white)
                      : Image.file(
                    // Display the selected image
                    File(_imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              FormBuilderTextField(
                name: 'description',
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value){},
              ),
              SizedBox(height: 16.0),
              FormBuilderTextField(
                name: 'movieID', // Add the movieID field
                decoration: InputDecoration(labelText: 'Movie ID'),
                validator: (value){},
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.saveAndValidate() ?? false) {
                    final formData = _formKey.currentState?.value as Map<String, dynamic>;
                    final movie = Movie(
                      formData['image'] ?? '',
                      formData['movieID'] ?? '',
                      formData['movieName'] ?? '',
                      _selectedGenre.toString().split('.').last,
                      formData['youTubeID'] ?? '',
                      formData['description'] ?? '',
                    );

                    // Now you can use the 'movie' object as needed.
                    // You may want to save it to a database or perform any other operations.
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
