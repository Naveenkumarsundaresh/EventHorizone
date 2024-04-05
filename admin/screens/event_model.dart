import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  String id;
  String eventName;
  String eventDescription;
  String eventLocation;
  String startDate;
  String endDate;
  String startTime;
  String endTime;
  String eventImage;

  Event({required this.id,
    required this.eventName,
    required this.eventDescription,
    required this.eventLocation,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.eventImage
  });
}

Future<List<Event>> getEvents() async {
  var events = await FirebaseFirestore.instance.collection('events').get();

  return events.docs.map((doc) => Event(
    id: doc.id,
    eventName: doc['Event Name'],
    eventDescription: doc['Event Description'],
    eventLocation: doc['Event Location'],
    startDate: doc['Start Date'],
    endDate: doc['End Date'],
    startTime: doc['Start Time'],
    endTime: doc['End Time'],
    eventImage: doc['Event Image']
  )).toList();
}
