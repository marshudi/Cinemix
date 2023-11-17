class User{
  String fName,lName,email,password;
  User(this.fName,this.lName,this.email,this.password);

  Map<String,dynamic> toJson()=>{
    "firstName":fName,
    "lastName":lName,
    "email":email,
    "password":password,

  };
}