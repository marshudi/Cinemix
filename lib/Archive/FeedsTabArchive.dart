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
                  children: [


                    SizedBox(height: 20),
                    // Display the animated list of feeds
                    Expanded(
                      child: FirebaseAnimatedList(
                        query: FirebaseDatabase.instance.ref("User").child(widget.userKey).child("logs"),
                        reverse: true,

                        itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                          // Use the snapshot data to build your list item
                          Map<dynamic, dynamic>? feed = snapshot.value as Map?;

                          // Display "Just Watched" for the first feed, and "You have Watched" for others
                          // String title = index == 1 ? 'Just Watched' : 'You have Watched';
                          DateTime time = DateTime.parse(feed?['time'] ?? '');


                          return ListTile(

                            title: Text(feed?['movieName'] ?? ''),
                            subtitle: Text(timeAgoCustom(time)),
                          );

                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }


  String timeAgoCustom(DateTime d) {
    // <-- Custom method Time Show  (Display Example  ==> 'Today 7:00 PM')     // WhatsApp Time Show Status Shimila
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




// Future<int> getTotalLogs() async {
  //   try {
  //     DatabaseEvent event = await myDataBase.child(widget.userKey).child("logs").once();
  //     if (event.snapshot != null) {
  //       Map<dynamic, dynamic>? logs = event.snapshot!.value as Map?;
  //       int totalLogs = logs?.length ?? 0;
  //       totalLogs=totalLogs-1;
  //       print(totalLogs);
  //       return totalLogs;
  //     } else {
  //       print('Snapshot is null');
  //       return 0;
  //     }
  //   } catch (e) {
  //     print('Error fetching total logs: $e');
  //     return 0;
  //   }
  // }








}
