import 'package:flutter/material.dart';

import '../Welcome/Welcome.dart';

class ProfileTab extends StatefulWidget {
  final String email, firstName, lastName, password;
  const ProfileTab({
    Key? key,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
  }) : super(key: key);


  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(2, 41, 63, 1.0),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 23, 30, 1.0),
        automaticallyImplyLeading: false,
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 80,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "${widget.firstName} ${widget.lastName}",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                widget.email,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 40),

              // ElevatedButton(
              //
              //   onPressed: () {
              //     // Add functionality for editing profile
              //   },
              //   child: Text("Edit Profile"),
              //   style: ElevatedButton.styleFrom(
              //     minimumSize: Size(double.infinity, 48.0),
              //     backgroundColor: Color.fromRGBO(0, 96, 129, 1.0), // Set your desired button background color
              //     onPrimary: Colors.white, // Set the text color
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(8.0), // Set the border radius
              //     ),
              //     padding: EdgeInsets.symmetric(vertical: 16.0), // Set vertical padding
              //   ),
              // ),
              // SizedBox(height: 20),

              ElevatedButton(

                onPressed: () {
                  // Add functionality for editing profile
                },
                child: Text("Change Password"),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 48.0),
                  backgroundColor: Color.fromRGBO(185, 100, 0, 1.0), // Set your desired button background color
                  onPrimary: Colors.white, // Set the text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0), // Set the border radius
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16.0), // Set vertical padding
                ),
              ),
              SizedBox(height: 100),
              ElevatedButton(
                onPressed: () {
                  // Add functionality for signing out
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Welcome()
                      )
                  );
                },
                child: Text("Sign Out"),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(100.0, 10.0),
                  backgroundColor: Color.fromRGBO(199, 36, 36, 1.0), // Set your desired button background color
                  onPrimary: Colors.white, // Set the text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0), // Set the border radius
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16.0), // Set vertical padding
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
