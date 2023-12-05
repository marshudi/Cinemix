import 'package:flutter/material.dart';
import 'package:cinemix/Welcome/Welcome.dart';
import 'package:cinemix/UserUI/UpdatePassword.dart';
import 'package:cinemix/UserUI/UpdateProfile.dart';
import 'package:firebase_database/firebase_database.dart';
class ProfileTab extends StatefulWidget {
  final String image, userKey, email, firstName, lastName, password;

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
  DatabaseReference userReference = FirebaseDatabase.instance.ref("User");
  String selectedAvatar = ""; // Add this line to track the selected avatar

  // Add a list of avatar images here
  final List<String> avatarImages = [
    "lib/Assets/profiles/default.jpg",
    "lib/Assets/profiles/female_1.jpg",
    "lib/Assets/profiles/female_2.jpg",
    "lib/Assets/profiles/female_3.jpg",
    "lib/Assets/profiles/female_4.jpg",
    "lib/Assets/profiles/male_1.jpg",
    "lib/Assets/profiles/male_2.jpg",
    "lib/Assets/profiles/male_3.jpg",
    "lib/Assets/profiles/male_4.jpg",
    "lib/Assets/profiles/male_5.jpg",
    // Add more avatar images as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(0, 23, 30, 1.0),
        flexibleSpace: Container(
          alignment: Alignment.bottomCenter,
          child: Text(
            "Profile",
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
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
                gradient: LinearGradient(
                  colors: [Color(0xff02293f), Color(0xff011118)],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Make the avatar clickable
                    GestureDetector(
                      onTap: () {
                        // Open avatar selection or update logic here
                        _showAvatarSelectionDialog(context);
                      },
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white,
                        backgroundImage: selectedAvatar.isEmpty
                            ? AssetImage("${widget.image}")
                            : AssetImage(selectedAvatar),
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
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 200.0),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: Color(0xff021723),
                ),
                height: double.infinity,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 50),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UpdateProfile(
                                    email: widget.email,
                                    firstName: widget.firstName,
                                    lastName: widget.lastName,
                                    password: widget.password,
                                    userKey: widget.userKey,
                                    image: widget.image,
                                  )));
                        },
                        child: Text("Edit Profile"),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 48.0),
                          backgroundColor: Color.fromRGBO(0, 96, 129, 1.0),
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdatePassword(
                                email: widget.email,
                                firstName: widget.firstName,
                                lastName: widget.lastName,
                                password: widget.password,
                                userKey: widget.userKey,
                                image: widget.image,
                              ),
                            ),
                          );
                        },
                        child: Text("Change Password"),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 48.0),
                          backgroundColor: Color.fromRGBO(86, 109, 203, 1.0),
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Welcome(),
                            ),
                          );
                        },
                        child: Text("Sign Out"),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(100.0, 10.0),
                          backgroundColor: Color.fromRGBO(199, 36, 36, 1.0),
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Function to show avatar selection dialog
  Future<void> _showAvatarSelectionDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromRGBO(0, 64, 86, 1.0),
          title: Text('Select Avatar'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // Display a list of avatar options here
                for (String avatarImage in avatarImages)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedAvatar = avatarImage;
                        userReference.child(widget.userKey).update({'image': selectedAvatar.toString()});
                      });
                      Navigator.pop(context);
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(avatarImage),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
