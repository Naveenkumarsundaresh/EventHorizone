import 'dart:convert';
import 'package:image/image.dart' as img;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  File? _image;
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;
  TextEditingController eventNameController = TextEditingController();
  TextEditingController eventDescriptionController = TextEditingController();
  TextEditingController eventLocationController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  String? imageBase64;

  void _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101), // Adjust as needed
    );

    if (picked != null && picked != selectedStartDate) {
      setState(() {
        selectedStartDate = picked;
        startDateController.text = selectedStartDate
            .toString(); // Set the selected date in the text field
      });
    }
  }

  void _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedEndDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101), // Adjust as needed
    );

    if (picked != null && picked != selectedEndDate) {
      setState(() {
        selectedEndDate = picked;
        endDateController.text = selectedEndDate
            .toString(); // Set the selected date in the text field
      });
    }
  }

  void _selectStartTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      // Handle the selected start time
      setState(() {
        selectedStartTime = pickedTime;
        startTimeController.text = selectedStartTime != null
            ? "${selectedStartTime!.hour.toString().padLeft(2, '0')}:${selectedStartTime!.minute.toString().padLeft(2, '0')}"
            : '';
      });
    }
  }

  void _selectEndTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      // Handle the selected time
      setState(() {
        selectedEndTime = pickedTime;
        endTimeController.text = selectedEndTime != null
            ? "${selectedEndTime!.hour.toString().padLeft(2, '0')}:${selectedEndTime!.minute.toString().padLeft(2, '0')}"
            : '';
      });
    }
  }

  Future<void> _getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final originalImage =
          img.decodeImage(File(pickedFile.path).readAsBytesSync());

      // Compress the image to reduce its quality
      final compressedImage = img.copyResize(originalImage!, width: 800);

      // Save the compressed image to a temporary file
      final compressedFile = File(pickedFile.path)
        ..writeAsBytesSync(img.encodeJpg(compressedImage));

      setState(() {
        _image = compressedFile;
        imageBase64 = base64Encode(_image!.readAsBytesSync());
      });
    }
  }

  Future<void> _createEvent() async {
    if (_image == null) {
      // Show an error message or handle it as needed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please pick an event image.'),
        ),
      );
      return;
    }

    // Get the values from the input fields
    String name = eventNameController.text;
    String description = eventDescriptionController.text;
    String location = eventLocationController.text;
    DateTime startDate = selectedStartDate ?? DateTime.now();
    DateTime endDate = selectedEndDate ?? DateTime.now();
    TimeOfDay startTime = selectedStartTime ?? TimeOfDay.now();
    TimeOfDay endTime = selectedEndTime ?? TimeOfDay.now();

    CollectionReference eventCollection =
        FirebaseFirestore.instance.collection('events');

    // Convert TimeOfDay objects to formatted strings with AM/PM
    String formattedStartTime = _formatTimeOfDay(startTime);
    String formattedEndTime = _formatTimeOfDay(endTime);

    // Read the image file as bytes
    List<int> imageBytes = await _image!.readAsBytes();

    // Encode the image bytes to base64
    String imageBase64 = base64Encode(imageBytes);

    // Add the event data to Firestore
    await eventCollection.add({
      'Event Name': name,
      'Event Description': description,
      'Event Location': location,
      'Start Date': DateFormat('yyyy-MM-dd').format(startDate),
      'End Date': DateFormat('yyyy-MM-dd').format(endDate),
      'Start Time': formattedStartTime,
      'End Time': formattedEndTime,
      'Event Image': imageBase64,
    });

    eventNameController.clear();
    eventDescriptionController.clear();
    eventLocationController.clear();
    startDateController.clear();
    endDateController.clear();
    startTimeController.clear();
    endTimeController.clear();
    setState(() {
      _image = null;
      selectedStartDate = null;
      selectedEndDate = null;
      selectedStartTime = null;
      selectedEndTime = null;
    });

    // Show a success message or perform other actions as needed
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Data saved to Firestore.'),
      ),
    );
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final DateTime datetime =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('hh:mm a').format(datetime);
  }

  @override
  Widget build(BuildContext context) {
    final eventName = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Event Name",
          style: TextStyle(
            color: Color(0xff6749EC),
            fontFamily: 'Afacad',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextField(
          controller: eventNameController,
          decoration: InputDecoration(),
        ),
      ],
    );
    final eventDescription = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Event Description",
          style: TextStyle(
            color: Color(0xff6749EC),
            fontFamily: 'Afacad',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextField(
          controller: eventDescriptionController,
          decoration: InputDecoration(),
        ),
      ],
    );
    final eventLocation = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Event Location",
          style: TextStyle(
            color: Color(0xff6749EC),
            fontFamily: 'Afacad',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextField(
          controller: eventLocationController,
          decoration: InputDecoration(),
        ),
      ],
    );
    final eventStartDate = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Start Date',
          style: TextStyle(
            color: Color(0xff6749EC),
            fontSize: 18,
            fontFamily: 'Afacad',
            fontWeight: FontWeight.bold,
          ),
        ),
        InkWell(
          onTap: () => _selectStartDate(context),
          child: AbsorbPointer(
            child: TextField(
              controller: startDateController,
              decoration: InputDecoration(
                suffixIcon: Icon(
                  Icons.calendar_today,
                  color: Color(0xff6749EC),
                ),
              ),
            ),
          ),
        ),
      ],
    );
    final eventEndDate = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'End Date',
          style: TextStyle(
            color: Color(0xff6749EC),
            fontSize: 18,
            fontFamily: 'Afacad',
            fontWeight: FontWeight.bold,
          ),
        ),
        InkWell(
          onTap: () => _selectEndDate(context),
          child: AbsorbPointer(
            child: TextField(
              controller: endDateController,
              decoration: const InputDecoration(
                suffixIcon: Icon(
                  Icons.calendar_today,
                  color: Color(0xff6749EC),
                ),
              ),
            ),
          ),
        ),
      ],
    );
    final eventStartTime = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Start Time',
          style: TextStyle(
            color: Color(0xff6749EC),
            fontSize: 18,
            fontFamily: 'Afacad',
            fontWeight: FontWeight.bold,
          ),
        ),
        InkWell(
          onTap: () => _selectStartTime(context),
          child: AbsorbPointer(
            child: TextField(
              controller: startTimeController,
              decoration: const InputDecoration(
                suffixIcon: Icon(
                  Icons.access_time,
                  color: Color(0xff6749EC),
                ),
              ),
            ),
          ),
        ),
      ],
    );
    final eventEndTime = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'End Time',
          style: TextStyle(
            color: Color(0xff6749EC),
            fontSize: 18,
            fontFamily: 'Afacad',
            fontWeight: FontWeight.bold,
          ),
        ),
        InkWell(
          onTap: () => _selectEndTime(context),
          child: AbsorbPointer(
            child: TextField(
              controller: endTimeController,
              decoration: const InputDecoration(
                suffixIcon: Icon(
                  Icons.access_time,
                  color: Color(0xff6749EC),
                ),
              ),
            ),
          ),
        ),
      ],
    );
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 40, left: 24, right: 24, bottom: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Center(
                  child: Text(
                    'Create Event',
                    style: TextStyle(
                      color: Color(0xff6749EC),
                      fontFamily: 'Afacad',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                InkWell(
                  onTap: _getImage,
                  child: CircleAvatar(
                    radius: 48,
                    backgroundColor: Color(0xffE3E3E3),
                    child: _image == null
                        ? Icon(
                            Icons.camera_alt,
                            size: 32,
                            color: Color(0xff6749EC),
                          )
                        : null,
                    backgroundImage: _image != null ? FileImage(_image!) : null,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Event Image',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xff6749EC),
                    fontFamily: 'Afacad',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                eventName,
                SizedBox(height: 16),
                eventDescription,
                SizedBox(height: 16),
                eventLocation,
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: eventStartDate,
                    ),
                    SizedBox(width: 80),
                    Expanded(
                      child: eventEndDate,
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: eventStartTime,
                    ),
                    SizedBox(width: 80),
                    Expanded(
                      child: eventEndTime,
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.only(
                      top: 8,
                    ),
                    child: ElevatedButton(
                      onPressed: _createEvent,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff6749EC),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          fixedSize: Size(150, 50)),
                      child: Text(
                        'Create Event',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Afacad',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
