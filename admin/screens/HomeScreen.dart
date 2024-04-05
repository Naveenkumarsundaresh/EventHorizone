import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventhorizon/admin/screens/ViewEvent.dart';
import 'package:eventhorizon/admin/screens/event_model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CollectionReference eventsCollection =  FirebaseFirestore.instance.collection('events');

  List eventname = ["Music Concert", "Birthday Function", "Leo"];
  List location = ["YMCA, Chennai", "ECR, Chennai", "PVR Cinemas"];
  List startdate = ["16/06/23", "18/06/23", "30/12/23"];
  List images = ["https://images.unsplash.com/photo-1516450360452-9312f5e86fc7?q=80&w=1470&auto=format&fit=crop"
        "&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com"
        "/photo-1604668915840-580c30026e5f?q=80&w=1648&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwa"
        "G90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://wallpaperbuzz.net/wp-content/uploads/2023/02/leo-vijay-hd"
        "-wallpapers-1200px-105219.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF9F9F9),
        body: Padding(
          padding: EdgeInsets.only(top: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 24,
                    ),
                    child: Text(
                      'Explore Events',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Afacad',
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.only(right: 32),
                    icon: Icon(
                      Icons.logout,
                      // Replace with the actual icon you want to use for logout
                      color: Color(0xff6749EC),
                      size: 24,
                    ),
                    onPressed: () {
                      // Add your logout functionality here
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 8, left: 24, right: 24, bottom: 16),
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xffD9D9D9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Search Users",
                    hintStyle: TextStyle(
                      color: Color(0xffACABAB),
                      fontFamily: 'Afacad',
                    ),
                    prefixIcon: Icon(Icons.search),
                    prefixIconColor: Color(0xffACABAB),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 16), // Adjust the height
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: eventsCollection.snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      List<DocumentSnapshot> events = snapshot.data!.docs;
                      return ListView.builder(
                          itemCount: events.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            // Extract event details
                            String eventName =
                                events[index]['Event Name'] ?? 'No Event Name';
                            String location = events[index]['Event Location'] ??
                                'No Location';
                            String startDate =
                                events[index]['Start Date'] ?? 'No Start Date';
                            String imageUrl = events[index]['Event Image'];
                            Uint8List bytes = base64Decode(imageUrl);
                            return GestureDetector(
                              onTap: () async {
                                // Fetch the document data
                                var doc = await FirebaseFirestore.instance
                                    .collection('events')
                                    .doc(events[index].id)
                                    .get();

                                // Check if the document exists and has the "Event Name" field
                                if (doc.exists &&
                                    doc.data() != null &&
                                    doc.data()!.containsKey('Event Name')) {
                                  // Create an Event object from the document data
                                  Event selectedEvent = Event(
                                    id: doc.id,
                                    eventImage: doc['Event Image'],
                                    eventName: doc['Event Name'],
                                    eventDescription: doc['Event Description'],
                                    eventLocation: doc['Event Location'],
                                    startDate: doc['Start Date'],
                                    endDate: doc['End Date'],
                                    startTime: doc['Start Time'],
                                    endTime: doc['End Time'],
                                  );
                                  // Navigate to the event details page
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ViewEvent(event: selectedEvent),
                                    ),
                                  );
                                } else {
                                  // Handle the case where the "Event Name" field is missing
                                  print(
                                      'The "Event Name" field is missing in the document.');
                                }
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 24.0,
                                ),
                                child: Card(
                                  color: Colors.transparent,
                                  // Set the Card color to transparent
                                  child: Container(
                                    // color: Colors.transparent,
                                    width: MediaQuery.of(context).size.width,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Stack(
                                      children: [
                                        // Image Container with Overlay
                                        Container(
                                          width: double.infinity,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: MemoryImage(bytes),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                        // Overlay Container
                                        Container(
                                          width: double.infinity,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            color: Colors.black.withOpacity(
                                                0.2), // Adjust the opacity as needed
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 14.0, vertical: 10.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Row(
                                                children: <Widget>[
                                                  Text(
                                                    eventName,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Afacad',
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 12.0,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: <Widget>[
                                                  Transform.translate(
                                                    offset: Offset(0, -5),
                                                    // Adjust the offset to move the icon up
                                                    child: Icon(
                                                      Icons
                                                          .location_on_outlined,
                                                      color: Colors.white,
                                                      size: 18,
                                                    ),
                                                  ),
                                                  SizedBox(width: 8),
                                                  Text(
                                                    location,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Afacad',
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(width: 16),
                                                  Transform.translate(
                                                    offset: Offset(0, -5),
                                                    // Adjust the offset to move the text down
                                                    child: Icon(
                                                      Icons.calendar_today,
                                                      color: Colors.white,
                                                      size: 18,
                                                    ),
                                                  ),
                                                  SizedBox(width: 8),
                                                  Text(
                                                    startDate,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Afacad',
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}