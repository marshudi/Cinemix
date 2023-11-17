import 'package:uuid/uuid.dart';


class Movie{
  static int _lastUsedID = 14; // Starting from 15
  String mImage,mID,mName,mType,mLink,mDesc;
  Movie(this.mImage,this.mID,this.mName,this.mType,this.mLink,this.mDesc);


  // Factory constructor to generate a unique ID
  factory Movie.withGeneratedID(String image, String name, String type, String link, String desc) {
    _lastUsedID++;
    return Movie(
      image,
      'movie_${_lastUsedID.toString().padLeft(5, '0')}', // Generate a unique ID (e.g., movie_00015)
      name,
      type,
      link,
      desc,
    );
  }
  Map<String,dynamic> toJson()=>{
    "image":mImage,
    "movieID":mID,
    "movieName":mName,
    "genre":mType,
    "youTubeID":mLink,
    "description":mDesc,

  };
}


