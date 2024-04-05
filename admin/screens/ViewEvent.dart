import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventhorizon/admin/screens/event_model.dart';
import 'package:flutter/material.dart';

class ViewEvent extends StatefulWidget {
  final Event event;

  ViewEvent({super.key, required this.event});

  @override
  State<ViewEvent> createState() => _ViewEventState();
}

class _ViewEventState extends State<ViewEvent> {
  // List events = ["Music Concert", "Birthday Function", "Leo"];
  // List names = ["YMCA, Chennai", "ECR, Chennai", "PVR Cinemas"];
  // List usernames = ["16/06/23", "18/06/23", "30/12/23"];
  List images = [
    "https://images.unsplash.com/photo-1516450360452-9312f5e86fc7?q=80&w=1470&auto=format&fit=crop"
        "&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com"
        "/photo-1604668915840-580c30026e5f?q=80&w=1648&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwa"
        "G90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://wallpaperbuzz.net/wp-content/uploads/2023/02/leo-vijay-hd"
        "-wallpapers-1200px-105219.jpg"
  ];
  bool isEditing = false;
  TextEditingController eventNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize text controllers with the initial values
    eventNameController.text = widget.event.eventName;
    descriptionController.text = widget.event.eventDescription;
    locationController.text = widget.event.eventLocation;
    startDateController.text = widget.event.startDate;
    endDateController.text = widget.event.endDate;
    startTimeController.text = widget.event.startTime;
    endTimeController.text = widget.event.endTime;
  }

  CollectionReference eventsCollection = FirebaseFirestore.instance.collection('events');

  // Function to delete an event in Firestore
  // Function to delete an event in Firestore
  void deleteEvent() async {
    try {
      // Find the document by querying based on a unique field (e.g., 'eventName')
      QuerySnapshot querySnapshot = await eventsCollection
          .where('Event Name', isEqualTo: widget.event.eventName)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Delete the first document found
        String documentId = querySnapshot.docs.first.id;
        await eventsCollection.doc(documentId).delete();

        // Show a message or perform any other action after successful delete
        print('Event deleted successfully!');

        // Navigate back to the previous screen
        Navigator.pop(context);
      } else {
        print('Event not found in Firestore.');
      }
    } catch (e) {
      // Handle errors here
      print('Error deleting event: $e');
    }
  }



  // Function to update event data in Firestore
  void updateEventData() async {
    try {
      // Create a map with the updated data
      Map<String, dynamic> updatedData = {
        'Event Name': eventNameController.text,
        'Event Description': descriptionController.text,
        'Event Location': locationController.text,
        'Start Date': startDateController.text,
        'End Date': endDateController.text,
        'Start Time': startTimeController.text,
        'End Time': endTimeController.text,
      };

      // Find the document by querying based on a unique field (e.g., 'eventName')
      QuerySnapshot querySnapshot = await eventsCollection
          .where('Event Name', isEqualTo: widget.event.eventName)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Update the first document found
        String documentId = querySnapshot.docs.first.id;
        await eventsCollection.doc(documentId).update(updatedData);

        // Show a message or perform any other action after successful update
        print('Event data updated successfully!');
        Navigator.pop(context);
      } else {
        print('Event not found in Firestore.');
      }
    } catch (e) {
      // Handle errors here
      print('Error updating event data: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 230,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: MemoryImage(
                          Uint8List.fromList(base64Decode(widget.event.eventImage)),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            Color(0xff6749EC), // Background color of the circle
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 24,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 16, left: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Event Name',
                        style: TextStyle(
                          color: Color(0xff6749EC),
                          fontFamily: 'Afacad',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        padding: EdgeInsets.only(right: 24),
                        height: 48,
                        child: TextField(
                          controller: eventNameController,
                          maxLines: 3,
                          enabled: isEditing,
                          style: TextStyle(
                            fontFamily: 'Afacad',
                            fontSize: 18,
                            fontWeight:
                                isEditing ? FontWeight.w500 : FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(12),
                            hintText: '', // Set an empty string for hintText
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Event Description',
                        style: TextStyle(
                          color: Color(0xff6749EC),
                          fontFamily: 'Afacad',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 24),
                        height: 48,
                        child: TextField(
                          controller: descriptionController,
                          maxLines: 3,
                          enabled: isEditing,
                          style: TextStyle(
                            fontFamily: 'Afacad',
                            fontSize: 18,
                            fontWeight:
                                isEditing ? FontWeight.w500 : FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(12),
                            hintText: '', // Set an empty string for hintText
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Event Location',
                        style: TextStyle(
                          color: Color(0xff6749EC),
                          fontFamily: 'Afacad',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 24),
                        height: 48,
                        child: TextField(
                          controller: locationController,
                          maxLines: 3,
                          enabled: isEditing,
                          style: TextStyle(
                            fontFamily: 'Afacad',
                            fontSize: 18,
                            fontWeight:
                                isEditing ? FontWeight.w500 : FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(12),
                            hintText: '', // Set an empty string for hintText
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Start date',
                                  style: TextStyle(
                                    color: Color(0xff6749EC),
                                    fontFamily: 'Afacad',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Container(
                                  height: 50, // Adjust the height as needed
                                  width: 150, // Adjust the width as needed
                                  child: TextField(
                                    controller: startDateController,
                                    maxLines: 3,
                                    enabled: isEditing,
                                    style: TextStyle(
                                      fontFamily: 'Afacad',
                                      fontSize: 18,
                                      fontWeight: isEditing ? FontWeight.w500 : FontWeight.bold,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(12),
                                      hintText: "",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          Icons.calendar_today,
                                          color: Color(0xff6749EC),
                                        ),
                                        onPressed: isEditing
                                            ? () async {
                                          // Implement your date picker logic here
                                          DateTime? pickedDate = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime(2101),
                                          );
                                          if (pickedDate != null) {
                                            startDateController.text =
                                            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year % 100}";
                                          }
                                        }
                                            : null,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'End date',
                                  style: TextStyle(
                                    color: Color(0xff6749EC),
                                    fontFamily: 'Afacad',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  height: 50, // Adjust the height as needed
                                  width: 150, // Adjust the width as needed
                                  child: TextField(
                                    controller: endDateController,
                                    maxLines: 3,
                                    enabled: isEditing,
                                    style: TextStyle(
                                      fontFamily: 'Afacad',
                                      fontSize: 18,
                                      fontWeight: isEditing ? FontWeight.w500 : FontWeight.bold,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(12),
                                      hintText: "",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          Icons.calendar_today,
                                          color: Color(0xff6749EC),
                                        ),
                                        onPressed: isEditing
                                            ? () async {
                                          // Implement your date picker logic here
                                          DateTime? pickedDate = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime(2101),
                                          );
                                          if (pickedDate != null) {
                                            startDateController.text =
                                            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year % 100}";
                                          }
                                        }
                                            : null,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Start time',
                              style: TextStyle(
                                color: Color(0xff6749EC),
                                fontFamily: 'Afacad',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Container(
                              height: 50, // Adjust the height as needed
                              width: 140, // Adjust the width as needed
                              child: TextField(
                                controller: startTimeController,
                                maxLines: 3,
                                enabled: isEditing,
                                style: TextStyle(
                                  fontFamily: 'Afacad',
                                  fontSize: 18,
                                  fontWeight: isEditing ? FontWeight.w500 : FontWeight.bold,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(12),
                                  hintText: "",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      Icons.access_time,
                                      color: Color(0xff6749EC),
                                    ),
                                    onPressed: isEditing
                                        ? () async {
                                      // Implement your time picker logic here
                                      TimeOfDay? pickedTime = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      );
                                      if (pickedTime != null) {
                                        startTimeController.text =
                                        "${pickedTime.hour}:${pickedTime.minute}";
                                      }
                                    }
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'End time',
                              style: TextStyle(
                                color: Color(0xff6749EC),
                                fontFamily: 'Afacad',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              height: 50, // Adjust the height as needed
                              width: 140, // Adjust the width as needed
                              child: TextField(
                                controller: endTimeController,
                                maxLines: 3,
                                enabled: isEditing,
                                style: TextStyle(
                                  fontFamily: 'Afacad',
                                  fontSize: 18,
                                  fontWeight: isEditing ? FontWeight.w500 : FontWeight.bold,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(12),
                                  hintText: "",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      Icons.access_time,
                                      color: Color(0xff6749EC),
                                    ),
                                    onPressed: isEditing
                                        ? () async {
                                      // Implement your time picker logic here
                                      TimeOfDay? pickedTime = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      );
                                      if (pickedTime != null) {
                                        endTimeController.text =
                                        "${pickedTime.hour}:${pickedTime.minute}";
                                      }
                                    }
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                // Toggle the editing state when the "Edit" button is pressed
                                setState(() {
                                  isEditing = !isEditing;

                                  // If in editing mode, update the data in Firestore
                                  if (!isEditing) {
                                    updateEventData();
                                  }
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff6749EC),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                fixedSize: Size(150, 50),
                              ),
                              child: Text(
                                isEditing ? 'Save' : 'Edit',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Afacad',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 24),
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 24,
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                if (!isEditing) {
                                  // If not in editing mode (i.e., Save is visible), perform delete action
                                  deleteEvent();
                                } else {
                                  // Toggle the editing state when the "Edit" button is pressed
                                  setState(() {
                                    isEditing = !isEditing;
                                  });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xff6749EC),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                fixedSize: Size(
                                    150, 50), // Set the desired width and height
                              ),
                              child: Text(
                                'Delete',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Afacad',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
