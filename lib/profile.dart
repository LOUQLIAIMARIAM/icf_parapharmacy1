import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String? phoneNumber = user.phoneNumber;

      // Create a List of widgets for your custom grid
      List<Widget> gridItems = [
        Text(
          'Phone Number: $phoneNumber',
          style: TextStyle(fontSize: 18),
        ),
        // Add other profile information widgets here
      ];

      // Create your custom grid or use a GridView widget
      // For example, let's use a GridView.builder
      return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: Center(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // You can adjust the number of columns as needed
            ),
            itemCount: gridItems.length,
            itemBuilder: (BuildContext context, int index) {
              return gridItems[index];
            },
          ),
        ),
      );
    } else {
      // Handle the case where the user is not logged in or phone number is not available
      return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: Center(
          child: Text(
            'User not authenticated',
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    }
  }
}
