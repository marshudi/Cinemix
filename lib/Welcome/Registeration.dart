import 'dart:ffi';

import 'package:cinemix/Welcome/UserModelClass.dart';
import 'package:flutter/material.dart';
import 'package:cinemix/Welcome/Login.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class Registeration extends StatefulWidget {
  const Registeration({super.key});

  @override
  State<Registeration> createState() => _RegisterationState();
}

class _RegisterationState extends State<Registeration> {

  final _formkey = GlobalKey<FormState>();
  TextEditingController fName=TextEditingController();
  TextEditingController lName=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  TextEditingController cPassword=TextEditingController();
  // TextEditingController bdate=TextEditingController();
  DatabaseReference mydb = FirebaseDatabase.instance.ref("User");

  bool checkvalue = true;


  late int flag=0;

  String? emailValidationResult;
  bool isPasswordVisible = false;


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Form(
        key: _formkey,
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xff31050e),
                  Color(0xff0a043a),
                ]),
              ),
              child: const Padding(
                padding: EdgeInsets.only(top: 60.0, left: 22),
                child: Text(
                  'Create Your\nAccount',
                  style: TextStyle(
                      fontSize: 30,
                      color: Color(0xffffffff),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 200.0),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                  color: Color(0xffffffff),
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
                        decoration: InputDecoration(
                            suffixIcon: Icon(Icons.check,color: Colors.grey,),
                            label: Text('Fisrt Name',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:Color(0xff9f0046),
                            ),)
                        ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter your First Name";
                            }
                            if (!RegExp(r'^[a-zA-Z]+(?: [a-zA-Z]+)*$').hasMatch(value)) {
                              return "First Name should contain only letters";
                              
                            }  
                          }

                      ),
                      TextFormField(
                         controller: lName,
                         decoration: InputDecoration(
                            suffixIcon: Icon(Icons.check,color: Colors.grey,),
                            label: Text('Last Name',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:Color(0xff9f0046),
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
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.check, color: Colors.grey),
                          label: Text(
                            'Email',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff9f0046),
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

                       TextFormField(
                           controller: password,
                           obscureText: !isPasswordVisible,
                           decoration: InputDecoration(
                               suffixIcon: IconButton(
                                 icon: Icon(
                                   isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                   color: Colors.grey,
                                 ),
                                 onPressed: () {
                                   setState(() {
                                     isPasswordVisible = !isPasswordVisible;
                                   });
                                 },
                               ),
                            label: Text('Password',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:Color(0xff9f0046),
                            ),)
                        ),
                           validator: (value) {
                             if (value == null || value.isEmpty) {
                               return "Please Enter your Password";
                             }
                             if (value.length<=7) {
                               return "Your password should be greater than 7";
                             }
                           }
                      ),
                      TextFormField(
                        controller: cPassword,
                          obscureText: !isPasswordVisible,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isPasswordVisible = !isPasswordVisible;
                                  });
                                },
                              ),
                            label: Text('Confirm Password',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:Color(0xff9f0046),
                            ),)
                        ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please confirm your password";
                            }
                            if (value != password.text) {
                              return "Please renter your password";
                            }
                          }

                      ),

                      CheckboxListTile(
                        title: Text("Agree to Terms and conditions"),

                        value: checkvalue,
                        onChanged: (val) {
                          setState(() {
                            checkvalue = val!;
                            if (checkvalue) {


                            } else {

                            }
                          });
                        },

                        activeColor: Color.fromARGB(255, 240, 60, 136) , // Set the active color to red
                        checkColor: Colors.white, // Set the check color to white
                        controlAffinity: ListTileControlAffinity.leading,

                      ),

                      const SizedBox(height: 10,),
                      const SizedBox(height: 70,),

                      GestureDetector(
                        onTap: ()  async {
                        if (_formkey.currentState!.validate() && checkvalue) {
                          //DataSnapshot snapshot = await mydb.orderByChild("email").equalTo(email.text).once();


                          mydb.onValue.listen((event) async {
                            flag=0;
                            for(final user in event.snapshot.children){
                              Map<dynamic, dynamic> u1=
                              user.value as Map<dynamic,dynamic>;
                              if(u1['email'].toString().trim().compareTo(email.text.trim())==0){
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
                              User newUser=User(
                                  fName.text,
                                  lName.text,
                                  email.text,
                                  //gender, //no need to conver the gender to text is already converted
                                  password.text);

                              await mydb.push().set(newUser.toJson());

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => Login()),
                              );
                              return;

                            }

                          });

                        }



                        else{
                          //mydb.push().set("'username' : $uname");
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("You have agree to terms and condition"),
                          ));
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
                                Color(0xff024570),
                              ]
                          ),
                        ),
                        child: const Center(child: Text('SIGN UP',style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,

                        ),),),
                      )),


                      const SizedBox(height: 80,),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Do you have an account?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                // Navigate to the SignupPage when "Sign up" is clicked.
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                              },
                              child: Text(
                                "Sign in",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ]))
    );
  }
}