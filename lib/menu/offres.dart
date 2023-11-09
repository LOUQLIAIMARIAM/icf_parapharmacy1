import 'package:flutter/material.dart';

import '../paimant/paiment_methods.dart';

class offres extends StatelessWidget {
  final List<String> imagePaths = [
    'assets/offers/ima1.png',
    'assets/offers/ima2.png',
    'assets/offers/ima3.png',
    'assets/offers/ima4.png',
    'assets/offers/ima5.png',
    'assets/offers/ima6.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Offers'),
      ),
      body: ListView.builder(
        itemCount: imagePaths.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              // Handle the tap action here, for example, navigate to a new page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(imagePath: imagePaths[index]),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  image: DecorationImage(
                    image: AssetImage(imagePaths[index]),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Text(
                    'Promotion',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final String imagePath;

  DetailPage({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath),
            SizedBox(height: 30), // Add some spacing
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(context, MaterialPageRoute(builder: (context) => paimethode()));
              },
              child: Text('Acheter Maintenant',
              style: TextStyle(
                fontFamily: 'Raleway',
                color: Colors.white
              ),),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF204B64), // Set the background color
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: offres()));
}
