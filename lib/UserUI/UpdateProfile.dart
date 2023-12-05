import 'package:cinemix/BottomNav.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

import 'package:cinemix/UserUI/ProfileTab.dart';

class UpdateProfile extends StatefulWidget {
  final String image,userKey,email, firstName, lastName, password;

  const UpdateProfile({
    Key? key,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.userKey,
    required this.image,

  }) : super(key: key);
  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {

  String? emailValidationResult;
  DatabaseReference userReference = FirebaseDatabase.instance.ref("User");
  TextEditingController fName=TextEditingController();
  TextEditingController lName=TextEditingController();
  TextEditingController email=TextEditingController();
  DatabaseReference mydb = FirebaseDatabase.instance.ref("User");
  late int flag=0;
  final _formkey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
    // Set initial values for the text controllers
    fName.text = widget.firstName;
    lName.text = widget.lastName;
    email.text = widget.email;

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(0, 23, 30, 1.0),
          //automaticallyImplyLeading: false,
          flexibleSpace: Container(
            alignment: Alignment.bottomCenter,
            child: Text(
              "Update Profile",
              style: TextStyle(
                fontSize: 30, // Set your desired font size
                color: Colors.white, // Set your desired text color
              ),
            ),
          ),
        ),
        backgroundColor: Color.fromRGBO(0, 23, 30, 1.0),
        body: Form(

            key: _formkey,
            child: Stack(
                children: [
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color(0xff02293f),
                        Color(0xff011118),
                      ]),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(top: 60.0, left: 22),

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 200.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                        color: Color(0xff021723),
                      ),
                      height: double.infinity,
                      width: double.infinity,
                      child:  Padding(
                        padding: const EdgeInsets.only(left: 18.0,right: 18),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(
                              controller: fName,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color(
                                        0xff4d4d4d)), // Set the default line color
                                  ),
                                  suffixIcon: Icon(Icons.check,color: Colors.grey,),
                                  label: Text('First Name',style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:Color(0xfff16a9b),
                                  ),)
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter your First Name";
                                }
                                if (!RegExp(r'^[a-zA-Z]+(?: [a-zA-Z]+)*$').hasMatch(value)) {
                                  return "Last Name should contain only letters";
                                }


                              },

                            ),

                            TextFormField(
                              controller: lName,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color(
                                        0xff4d4d4d)), // Set the default line color
                                  ),
                                  suffixIcon: Icon(Icons.check,color: Colors.grey,),
                                  label: Text('Last Name',style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:Color(0xfff16a9b),
                                  ),)
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter your Last Name";
                                }
                                if (!RegExp(r'^[a-zA-Z]+(?: [a-zA-Z]+)*$').hasMatch(value)) {
                                  return "Last Name should contain only letters";
                                }


                              },

                            ),
                            TextFormField(
                              controller: email,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(
                                      0xff4d4d4d)), // Set the default line color
                                ),
                                suffixIcon: Icon(Icons.check, color: Colors.grey),
                                label: Text(
                                  'Email',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:Color(0xfff16a9b),
                                  ),
                                ),
                              ),
                              validator: (value)  {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter your Email";
                                }
                                if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(value)) {
                                  return "Please enter a valid email address";
                                }

                                return emailValidationResult;


                              },
                            ),

                            const SizedBox(height: 70,),



                            GestureDetector(
                              onTap: ()  async {
                                if (_formkey.currentState!.validate()) {
                                  //DataSnapshot snapshot = await mydb.orderByChild("email").equalTo(email.text).once();


                                  mydb.onValue.listen((event) async {
                                    flag=0;
                                    for(final user in event.snapshot.children){
                                      Map<dynamic, dynamic> u1=
                                      user.value as Map<dynamic,dynamic>;
                                      if(u1['email'].toString().trim().compareTo(email.text.trim())==0 && widget.email!=email.text){
                                        flag=1;
                                        var globalUserKey=user.key as String;
                                        var globalEmail=email.text;
                                        break;
                                      }
                                    }
                                    if(flag==1){
                                      setState(() {
                                        emailValidationResult =
                                        "Email already exists. Please register with a different email";
                                      });

                                    }

                                    else{
                                      setState(() {
                                        emailValidationResult = null; // Reset the error message
                                      });
                                      userReference.child(widget.userKey).update({
                                        'email': email.text,
                                        'firstName':fName.text,
                                        'lastName':lName.text,
                                      }).then((_) {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(builder: (context) => BottomNav(
                                            email: email.text,
                                            firstName: fName.text,
                                            lastName: lName.text,
                                            password: widget.password,
                                            userKey: widget.userKey,
                                            image: widget.image,
                                           )),
                                        ); // Close the update page after updating
                                      }).catchError((error) {
                                        print('Error updating movie: $error');
                                      });
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Profile is updated!")));
                                      return;

                                    }

                                  });

                                }



                                else{

                                  setState(() {
                                    emailValidationResult = null; // Reset the error message
                                  });
                                }

                              },
                              child: Container(
                                height: 55,
                                width: 300,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xff9f0046),
                                      Color(0xffa3b4c0),
                                    ],
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Update Profile',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 150,),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,

                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ])
        ));
  }
}
