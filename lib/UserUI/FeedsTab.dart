import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:intl/intl.dart';

class FeedsTab extends StatefulWidget {
  final String userKey;

  const FeedsTab({
    Key? key,
    required this.userKey,
  }) : super(key: key);

  @override
  State<FeedsTab> createState() => _FeedsTabState();
}

class _FeedsTabState extends State<FeedsTab> {
  DatabaseReference myDataBase = FirebaseDatabase.instance.ref("User");
  late StreamController<DateTime> _timeController;
  late Stream<DateTime> _timeStream;

  @override
  void initState() {
    super.initState();
    _timeController = StreamController<DateTime>();
    _timeStream = _timeController.stream;

    // Emit the current time at regular intervals
    Timer.periodic(Duration(seconds: 45), (timer) {
      _timeController.add(DateTime.now());
    });
  }

  @override
  void dispose() {
    _timeController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(0, 23, 30, 1.0),
        flexibleSpace: Container(
          alignment: Alignment.bottomCenter,
          child: Text(
            "Feeds",
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
            ),
          ),
        ),
      ),
      backgroundColor: Color.fromRGBO(0, 23, 30, 1.0),
      body: Stack(
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
                children: [
                  SizedBox(height: 20),
                  Expanded(
                    child: StreamBuilder<DateTime>(
                      stream: _timeStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          DateTime currentTime = snapshot.data!;
                          return FirebaseAnimatedList(
                            query: FirebaseDatabase.instance
                                .ref("User")
                                .child(widget.userKey)
                                .child("logs"),
                            reverse: true,
                            itemBuilder: (BuildContext context,
                                DataSnapshot snapshot,
                                Animation<double> animation,
                                int index) {
                              Map<dynamic, dynamic>? feed =
                              snapshot.value as Map?;
                              DateTime time =
                              DateTime.parse(feed?['time'] ?? '');

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    title: Text(feed?['movieName'] ?? '',
                                        style: TextStyle(
                                            color: Color(0xffecc8d4))),
                                    subtitle: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                              timeAgoCustom(time),
                                              style: TextStyle(
                                                  color: Color(0xff988289))),
                                        ),
                                        Container(
                                          width: 30,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  feed?['image'] ?? ''),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                      color: Colors.white), // Add a Divider between ListTiles
                                ],
                              );
                            },
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String timeAgoCustom(DateTime d) {
    Duration diff = DateTime.now().difference(d);
    if (diff.inDays > 365)
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
    if (diff.inDays > 30)
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
    if (diff.inDays > 7)
      return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
    if (diff.inDays > 0)
      return "${DateFormat.E().add_jm().format(d)}";
    if (diff.inHours > 0)
      return "Today ${DateFormat('jm').format(d)}";
    if (diff.inMinutes > 0)
      return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
    return "just now";
  }
}
