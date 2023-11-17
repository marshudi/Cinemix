import 'package:cinemix/Welcome//Registeration.dart';
import 'package:flutter/material.dart';
import 'package:cinemix/UserUI//HomeTab.dart';
import 'package:cinemix/BottomNav.dart';
import 'package:cinemix/BottomNavAdmin.dart';



import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  DatabaseReference mydb = FirebaseDatabase.instance.ref("User");
  late int flag=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  'Hello\nSign in!',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
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
                  color: Colors.white,
                ),
                height: double.infinity,
                width: double.infinity,
                child:  Padding(
                  padding: const EdgeInsets.only(left: 18.0,right: 18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       TextFormField(
                         controller: email,
                        decoration: InputDecoration(
                            suffixIcon: Icon(Icons.check,color: Colors.grey,),
                            label: Text('Email',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:Color(0xff9f0046),
                            ),)
                        ),
                        validator: (value){
                            if (value == null || value.isEmpty) {
                              return "Please Enter your Email";
                            }

                            } ,
                      ),


                      TextFormField(
                        controller: password,
                        decoration: InputDecoration(
                            suffixIcon: Icon(Icons.visibility_off,color: Colors.grey,),
                            label: Text('Password',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:Color(0xff9f0046),
                            ),)
                        ),
                            validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter your password";
                                }


                                },


                        ),
                      const SizedBox(height: 20,),
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Text('Forgot Password?',style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize:  17,
                          color: Color(0xff049f9f),
                        ),),
                      ),
                      const SizedBox(height: 70,),



                      GestureDetector(
                        onTap: () async {
                          if (_formkey.currentState!.validate()) {
                            //DataSnapshot snapshot = await mydb.orderByChild("email").equalTo(email.text).once();
                            mydb.onValue.listen((event) {
                              flag=0;
                              for(final user in event.snapshot.children){
                                Map<dynamic, dynamic> u1=
                                    user.value as Map<dynamic,dynamic>;
                                if(u1['email'].toString().trim().compareTo(email.text.trim())==0 &&
                                    u1['password'].toString().trim().compareTo(password.text.trim())==0){
                                  flag=1;
                                  var globalUserKey=user.key as String;
                                  var globalEmail=email.text;
                                  break;
                                }
                              }
                              if(flag==1){
                                
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //   SnackBar(content: Text("Logged in"))
                                // );

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BottomNav()),
                                );
                              }
                              if("admin@cinemix.com"==email.text && "admin123"==password.text){
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //     SnackBar(content: Text("admin login"))
                                // );
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BottomNavAdmin()),
                                );
                              }
                              else{
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Login Failed, please check your email and password!"))
                                );
                              }
                            });

                            
                          }

                          else{

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
                          child: const Center(child: Text('SIGN IN',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white
                          ),),),
                      ),
                          ),
                      const SizedBox(height: 150,),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                            "Don't have an account?",
                                style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                  ),
                                ),
                            InkWell(
                              onTap: () {
                                  // Navigate to the SignupPage when "Sign up" is clicked.
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Registeration()));
                                },
                            child: Text(
                              "Sign up",
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
    ])
        ));
  }
}