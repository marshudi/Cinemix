class User{
  String image,fName,lName,email,password;
  User(this.image,this.fName,this.lName,this.email,this.password);

  Map<String,dynamic> toJson()=>{
    "image":image,
    "firstName":fName,
    "lastName":lName,
    "email":email,
    "password":password,


  };
}