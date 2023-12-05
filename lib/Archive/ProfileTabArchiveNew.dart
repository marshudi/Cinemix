import 'package:cinemix/AdminUI/UpdatePassword.dart';
import 'package:flutter/material.dart';

import '../Welcome/Welcome.dart';

class ProfileTab extends StatefulWidget {
  final String image,userKey,email, firstName, lastName, password;

  const ProfileTab({
    Key? key,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.userKey,
    required this.image,

  }) : super(key: key);


  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(0, 23, 30, 1.0),
          //automaticallyImplyLeading: false,
          flexibleSpace: Container(
            alignment: Alignment.bottomCenter,
            child: Text(
              "Profile",
              style: TextStyle(
                fontSize: 30, // Set your desired font size
                color: Colors.white, // Set your desired text color
              ),
            ),
          ),
        ),
        backgroundColor: Color.fromRGBO(0, 23, 30, 1.0),
        body: Center(



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
                    child: Padding(
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


                            const SizedBox(height: 70,),




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
