// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
//
// class AddEvent extends StatefulWidget {
//   const AddEvent({super.key});
//
//   @override
//   State<AddEvent> createState() => _AddEventState();
// }
//
// class _AddEventState extends State<AddEvent> {
//   File? _image;
//   DateTime? _selectedStartDate;
//   DateTime? _selectedEndDate;
//   TimeOfDay? _selectedStartTime;
//   TimeOfDay? _selectedEndTime;
//   TextEditingController eventNameController = TextEditingController();
//   TextEditingController eventDescriptionController = TextEditingController();
//   TextEditingController eventLocationController = TextEditingController();
//
//   Future<void> _getImage() async {
//     final pickedFile =
//     await ImagePicker().pickImage(source: ImageSource.gallery);
//
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//     }
//   }
//
//   void _selectStartDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2101), // Adjust as needed
//     );
//
//     if (picked != null && picked != _selectedStartDate) {
//       setState(() {
//         _selectedStartDate = picked;
//       });
//     }
//   }
//
//   void _selectEndDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: _selectedEndDate ?? DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2101), // Adjust as needed
//     );
//
//     if (picked != null && picked != _selectedEndDate) {
//       setState(() {
//         _selectedEndDate = picked;
//       });
//     }
//   }
//
//   void _selectStartTime(BuildContext context) async {
//     TimeOfDay? pickedTime = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//       builder: (BuildContext context, Widget? child) {
//         return MediaQuery(
//           data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
//           child: child!,
//         );
//       },
//     );
//
//     if (pickedTime != null) {
//       // Handle the selected start time
//       setState(() {
//         _selectedStartTime = pickedTime;
//       });
//     }
//   }
//
//   void _selectEndTime(BuildContext context) async {
//     TimeOfDay? pickedTime = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//       builder: (BuildContext context, Widget? child) {
//         return MediaQuery(
//           data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
//           child: child!,
//         );
//       },
//     );
//
//     if (pickedTime != null) {
//       // Handle the selected time
//       setState(() {
//         _selectedEndTime = pickedTime;
//       });
//     }
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     final eventName = Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "Event Name",
//           style: TextStyle(
//             color: Color(0xff6749EC),
//             fontFamily: 'Afacad',
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         TextField(
//           controller: eventNameController,
//           decoration: InputDecoration(),
//         ),
//       ],
//     );
//     final eventDescription = Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "Event Description",
//           style: TextStyle(
//             color: Color(0xff6749EC),
//             fontFamily: 'Afacad',
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         TextField(
//           controller: eventDescriptionController,
//           decoration: InputDecoration(),
//         ),
//       ],
//     );
//     final eventLocation = Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "Event Location",
//           style: TextStyle(
//             color: Color(0xff6749EC),
//             fontFamily: 'Afacad',
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         TextField(
//           controller: eventLocationController,
//           decoration: InputDecoration(),
//         ),
//       ],
//     );
//     final eventStartDate = Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'End Date',
//           style: TextStyle(
//             color: Color(0xff6749EC),
//             fontSize: 18,
//             fontFamily: 'Afacad',
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         InkWell(
//           onTap: () => _selectStartDate(context),
//           child: AbsorbPointer(
//             child: TextField(
//               controller: TextEditingController(
//                 text: _selectedStartDate != null
//                     ? "${_selectedStartDate!.toLocal()}".split(' ')[0]
//                     : '',
//               ),
//               decoration: InputDecoration(
//                 suffixIcon: Icon(
//                   Icons.calendar_today,
//                   color: Color(0xff6749EC),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//     final eventEndDate = Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Start Date',
//           style: TextStyle(
//             color: Color(0xff6749EC),
//             fontSize: 18,
//             fontFamily: 'Afacad',
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         InkWell(
//           onTap: () => _selectEndDate(context),
//           child: AbsorbPointer(
//             child: TextField(
//               controller: TextEditingController(
//                 text: _selectedEndDate != null
//                     ? "${_selectedEndDate!.toLocal()}".split(' ')[0]
//                     : '',
//               ),
//               decoration: InputDecoration(
//                 suffixIcon: Icon(
//                   Icons.calendar_today,
//                   color: Color(0xff6749EC),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//     final eventStartTime = Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Start Time',
//           style: TextStyle(
//             color: Color(0xff6749EC),
//             fontSize: 18,
//             fontFamily: 'Afacad',
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         InkWell(
//           onTap: () => _selectStartTime(context),
//           child: AbsorbPointer(
//             child: TextField(
//               controller: TextEditingController(
//                 text: _selectedStartTime != null
//                     ? "${_selectedStartTime!.hour.toString().padLeft(2, '0')}:${_selectedStartTime!.minute.toString().padLeft(2, '0')}"
//                     : '',
//               ),
//               decoration: InputDecoration(
//                 suffixIcon: Icon(
//                   Icons.access_time,
//                   color: Color(0xff6749EC),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//     final eventEndTime = Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'End Time',
//           style: TextStyle(
//             color: Color(0xff6749EC),
//             fontSize: 18,
//             fontFamily: 'Afacad',
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         InkWell(
//           onTap: () => _selectEndTime(context),
//           child: AbsorbPointer(
//             child: TextField(
//               controller: TextEditingController(
//                 text: _selectedEndTime != null
//                     ? "${_selectedEndTime!.hour.toString().padLeft(2, '0')}:${_selectedEndTime!.minute.toString().padLeft(2, '0')}"
//                     : '',
//               ),
//               decoration: const InputDecoration(
//                 suffixIcon: Icon(
//                   Icons.access_time,
//                   color: Color(0xff6749EC),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//     return SafeArea(
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: Padding(
//             padding:
//             const EdgeInsets.only(top: 40, left: 24, right: 24, bottom: 0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Center(
//                   child: Text(
//                     'Create Event',
//                     style: TextStyle(
//                       color: Color(0xff6749EC),
//                       fontFamily: 'Afacad',
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 16),
//                 InkWell(
//                   onTap: _getImage,
//                   child: CircleAvatar(
//                     radius: 48,
//                     backgroundColor: Color(0xffE3E3E3),
//                     child: _image == null
//                         ? Icon(
//                       Icons.camera_alt,
//                       size: 32,
//                       color: Color(0xff6749EC),
//                     )
//                         : null,
//                     backgroundImage: _image != null ? FileImage(_image!) : null,
//                   ),
//                 ),
//                 SizedBox(height: 16),
//                 Text(
//                   'Event Image',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: Color(0xff6749EC),
//                     fontFamily: 'Afacad',
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 16),
//                 _buildInputField('Event Name', eventNameController),
//                 SizedBox(height: 16),
//                 _buildInputField('Event Name', eventDescriptionController),
//                 SizedBox(height: 16),
//                 _buildInputField('Event Name', )
//                 SizedBox(height: 16),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: eventStartDate,
//                     ),
//                     SizedBox(width: 80),
//                     Expanded(
//                       child: eventEndDate,
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 16),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: eventStartTime,
//                     ),
//                     SizedBox(width: 80),
//                     Expanded(
//                       child: eventEndTime,
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 16),
//                 Align(
//                   alignment: Alignment.bottomCenter,
//                   child: Container(
//                     padding: EdgeInsets.only(
//                       top: 8,
//                     ),
//                     child: ElevatedButton(
//                       onPressed: () {},
//                       style: ElevatedButton.styleFrom(
//                           primary: Color(0xff6749EC),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           fixedSize: Size(150, 50)),
//                       child: Text(
//                         'Create Event',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontFamily: 'Afacad',
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildInputField(String label, TextEditingController controller) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "Event Name",
//           style: TextStyle(
//             color: Color(0xff6749EC),
//             fontFamily: 'Afacad',
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         TextField(
//           controller: eventNameController,
//           decoration: InputDecoration(),
//         ),
//       ],
//     );
//   }
// }
//
