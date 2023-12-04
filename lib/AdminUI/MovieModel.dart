

class Movie{

  String mImage,mID,mName,mType,mLink,mDesc;
  Movie(this.mImage,this.mID,this.mName,this.mType,this.mLink,this.mDesc);



  Map<String,dynamic> toJson()=>{
    "image":mImage,
    "movieID":mID,
    "movieName":mName,
    "genre":mType,
    "youTubeID":mLink,
    "description":mDesc,

  };
}


