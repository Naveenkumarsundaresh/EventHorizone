import 'package:flutter/material.dart';

class ManageUsers extends StatefulWidget {
  const ManageUsers({super.key});

  @override
  State<ManageUsers> createState() => _ManageUsersState();
}

class _ManageUsersState extends State<ManageUsers> {
  List names = ["Yashmin", "Neha", "Nithya", "John", "Jack"];
  List usernames = [
    "yashmin@123",
    "neha@123",
    "nithya@123",
    "john@123",
    "jack@123"
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
              Center(
                child: Text(
                  'Manage Users',
                  style: TextStyle(
                    color: Color(0xff6749EC),
                    fontFamily: 'Afacad',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 24, left: 24, right: 24, bottom: 16),
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
                child: ListView.builder(
                  itemCount: names.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  // Disable scrolling to take available space
                  itemBuilder: (BuildContext context, int index) => Container(
                    width: MediaQuery.of(context).size.width,
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                    child: Card(
                      color: Colors.white,
                      // elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 60.0,
                                  height: 60.0,
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage("https://i.pinimg.com/originals/1c/42/db/1c42dbe4cfb44025ac69d041568cf2c5.jpg"),
                                    backgroundColor: Colors.transparent,
                                    radius: 50.0,
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      names[index],
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Afacad',
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      usernames[index],
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: 'Afacad',
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 10.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        // Handle icon click here
                                        print(
                                            "Edit icon clicked for user $index");
                                      },
                                      child: Icon(
                                        Icons.edit,
                                        color: Color(0xff6749EC),
                                      ),
                                    ),
                                  ),
                                ),
                                // Add a SizedBox to control the space between icons
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 10.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        // Handle icon click here
                                        print(
                                            "Delete icon clicked for user $index");
                                      },
                                      child: Icon(
                                        Icons.delete_outline,
                                        color: Color(0xff6749EC),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
