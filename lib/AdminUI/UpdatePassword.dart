import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:crypto/crypto.dart';

import 'package:cinemix/AdminUI/ProfileTab.dart';
import 'package:cinemix/BottomNavAdmin.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class UpdatePassword extends StatefulWidget {
  final String image,userKey,email, firstName, lastName, password;

  const UpdatePassword({
    Key? key,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.userKey,
    required this.image,

  }) : super(key: key);
  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {


  String _hashPassword(String password) {
    final List<int> bytes = utf8.encode(password);
    final Digest digest = sha256.convert(Uint8List.fromList(bytes));
    return digest.toString();
  }
  DatabaseReference userReference = FirebaseDatabase.instance.ref("User");
  TextEditingController oldPassword=TextEditingController();
  TextEditingController newPassword=TextEditingController();
  TextEditingController cPassword=TextEditingController();
  // DatabaseReference mydb = FirebaseDatabase.instance.ref("User");

  // List<Map<dynamic, dynamic>> users1 = [];

  late int flag=0;
  bool isPasswordVisible = false;

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(0, 23, 30, 1.0),
          //automaticallyImplyLeading: false,
          flexibleSpace: Container(
            alignment: Alignment.bottomCenter,
            child: Text(
              "Update Password",
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
                              controller: oldPassword,
                              obscureText: !isPasswordVisible,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color(
                                        0xff4d4d4d)), // Set the default line color
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue), // Set the focused line color
                                  ),
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
                                  label: Text('Old Password',style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:Color(0xfff16a9b),
                                  ),)
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter your Old password";
                                }
                                if (_hashPassword(value) !=widget.password) {
                                  return "Enter your valid Old password";
                                }



                              },


                            ),
                            TextFormField(
                              controller: newPassword,
                              obscureText: !isPasswordVisible,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color(
                                        0xff4d4d4d)), // Set the default line color
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue), // Set the focused line color
                                  ),
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
                                  label: Text('New Password',style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:Color(0xfff16a9b),


                                  ),

                                  )
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter your new password";
                                }
                                if (value.length<=7) {
                                  return "Your password should be greater than 7";
                                }



                              },


                            ),

                            TextFormField(
                              controller: cPassword,
                              obscureText: !isPasswordVisible,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color(
                                        0xff4d4d4d)), // Set the default line color
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue), // Set the focused line color
                                  ),
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
                                    color:Color(0xfff16a9b),
                                  ),)
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Confirm your password";
                                }
                                if (value != newPassword.text) {
                                  return "confirm password must match your new password";
                                }


                              },


                            ),

                            const SizedBox(height: 70,),



                            GestureDetector(
                              onTap: () async {
                                if (_formkey.currentState!.validate()) {
                                    if(_hashPassword(oldPassword.text)==widget.password){
                                      userReference.child(widget.userKey).update({
                                        'password': _hashPassword(newPassword.text),
                                      }).then((_) {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(builder: (context) => BottomNavAdmin(                    email: widget.email,
                                            firstName: widget.firstName,
                                            lastName: widget.lastName,
                                            password: _hashPassword(newPassword.text),
                                            userKey: widget.userKey,
                                            image: widget.image,
                                         )),
                                        ); // Close the update page after updating
                                      }).catchError((error) {
                                        print('Error updating movie: $error');
                                      });
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password is updated!")));
                                    }

                                }},
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
                                    'Update Password',
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
