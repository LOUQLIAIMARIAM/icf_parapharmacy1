import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:icf_parapharmacy1/profile.dart';
import 'package:icf_parapharmacy1/search.dart';

import 'cartPage.dart';
import 'categories/anti.dart';
import 'categories/beaute.dart';
import 'categories/bio.dart';
import 'categories/cheveux.dart';
import 'categories/complement.dart';
import 'categories/corps.dart';
import 'categories/homme.dart';
import 'categories/maman.dart';
import 'categories/sante.dart';
import 'categories/soins.dart';
import 'categories/taches.dart';
import 'exemple.dart';
import 'favorite.dart';
import 'menu/meilleuresventes.dart';
import 'menu/notrevadette.dart';
import 'menu/nouveautes.dart';
import 'menu/offres.dart';
import 'menu/tendance.dart';
import 'menu/toutesarticles.dart';
import 'menu/toutmagazin.dart';

final Color customColor = Color(0xFFE9F7FF);

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final List<Map<String, dynamic>> products = [
  {
   "image": "assets/mv/klo.png", // Replace with your image asset path
  },
  {
   "image": "assets/mv/svr.jpg",
  },
  {
  "image": "assets/mv/lirak.png",
  },
  {
   "image": "assets/mv/yani.png",
  },
  ];
  final List<Map<String, dynamic>> nouveaute = [
    {
      "image": "assets/mv/cari.png", // Replace with your image asset path
    },
    {
      "image": "assets/mv/fond.png",
    },
    {
      "image": "assets/mv/par.png",
    },
    {
      "image": "assets/mv/df.png",
    },
  ];

  final List<Map<String, dynamic>> magazin = [
    {
      "image": "assets/categories/beaute/algo.png", // Replace with your image asset path
    },
    {
      "image": "assets/categories/beaute/fend.jpg"
    },
    {
      "image": "assets/categories/beaute/garnier.jpg"
    },
    {
      "image": "assets/categories/beaute/isdin.jpg"
    },
  ];

  List imageList = [
    {"id": 1, "image_path": 'assets/offers/ima3.png'},
    {"id": 2, "image_path": 'assets/offers/ima8.png'},
    {"id": 3, "image_path": 'assets/offers/ima9.png'}
  ];
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  int _selectedIndex = 0;
  double _navBarHeight = 60.0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Parapharmacy',
          style: TextStyle(
            fontFamily: 'Raleway',
          ),
        ),
        backgroundColor: customColor,
        actions: [
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Color(0xFFBFD2C3),
          child: ListView(
            children: [
              ListTile(
                title: Text('                '),
              ),
              ListTile(
                title: Text('   Meilleures Ventes'),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.push(context, MaterialPageRoute(builder: (context) => meilleuresventes()));
                },
              ),
              ListTile(
                title: Text('   Nouveautés'),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.push(context, MaterialPageRoute(builder: (context) => nouveautes()));
                },
              ),
              ListTile(
                title: Text('   Tendances'),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.push(context, MaterialPageRoute(builder: (context) => tendance()));
                },
              ),
              ListTile(
                title: Text('   Offres'),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.push(context, MaterialPageRoute(builder: (context) => offres()));
                },
              ),
              ListTile(
                title: Text('   Tout le magasin'),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.push(context, MaterialPageRoute(builder: (context) => toutmagazin()));
                },
              ),
              ListTile(
                title: Text('   Tout les Articles'),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.push(context, MaterialPageRoute(builder: (context) => toutesarticls()));
                },
              ),
              ListTile(
                title: Text('   Notre Vedette'),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.push(context, MaterialPageRoute(builder: (context) => notrevadette()));
                },
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              items: [
                Image.asset('assets/coursal/design.png'),
                Image.asset('assets/coursal/cam.png'),
                Image.asset('assets/coursal/cadeaux.png'),
                Image.asset('assets/coursal/retour.png'),
                Image.asset('assets/coursal/rebod.png'),
              ],
              options: CarouselOptions(
                height: 200,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
            ),
            // Category List
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Add padding as needed
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 18, // Adjust the font size as needed
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Raleway',
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 100,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('categories').snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // or a loading indicator
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Text('No data available'); // Handle the case when there is no data in Firestore
                  }

                  List<Map<String, dynamic>> categories = snapshot.data!.docs.map((document) {
                    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                    return {
                      "name": data["categoryName"],
                      "image": data["categoryImage"],
                    };
                  }).toList();

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // Get the category name and corresponding screen widget
                          String categoryName = categories[index]["name"];
                          Widget navScreen;

                          switch (categoryName) {
                            case "cheveux":
                              navScreen = cheveux();
                              break;
                            case "anti-covid":
                              navScreen = AntiClass();
                              break;
                            case "compléments alimentaires":
                              navScreen = complement();
                              break;
                            case "beaut":
                              navScreen = beaute();
                              break;
                            case "santer":
                              navScreen = sante();
                              break;
                            case "homme":
                              navScreen = homme();
                              break;
                            case "bio – phytoterapie":
                              navScreen = bio();
                              break;
                            case "corps":
                              navScreen = corps();
                              break;
                            default:
                              navScreen = AntiClass();
                          }

                          // Navigate to the selected category screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => navScreen,
                            ),
                          );
                        },
                        child: Container(
                          width: 120, // Adjust the width as needed
                          margin: EdgeInsets.all(10), // Adjust the margin as needed
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              categories[index]["image"],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Add padding as needed
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Offers',
                    style: TextStyle(
                      fontSize: 18, // Adjust the font size as needed
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Raleway',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle "See All" click
                      // Replace with your navigation logic
                      Navigator.push(context, MaterialPageRoute(builder: (context) => offres())); // Replace with the appropriate screen for viewing all offers
                    },
                    child: Text(
                      'See All',
                      style: TextStyle(
                        fontSize: 16, // Adjust the font size as needed
                        color: Colors.blue,
                        fontFamily: 'Raleway',// Add the color you want for the link
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Add your new widget here
            Column(children: [
              Stack(
                children: [
                  InkWell(
                    onTap: () {
                      print(currentIndex);
                    },
                    child: CarouselSlider(
                      items: imageList
                          .map(
                            (item) => Image.asset(
                          item['image_path'],
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      )
                          .toList(),
                      carouselController: carouselController,
                      options: CarouselOptions(
                        scrollPhysics: const BouncingScrollPhysics(),
                        autoPlay: true,
                        aspectRatio: 2,
                        viewportFraction: 1,
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: imageList.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () => carouselController.animateToPage(entry.key),
                          child: Container(
                            width: currentIndex == entry.key ? 17 : 7,
                            height: 7.0,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 3.0,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: currentIndex == entry.key
                                    ? Colors.red
                                    : Colors.teal),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ]),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Add padding as needed
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tandance',
                    style: TextStyle(
                      fontSize: 18, // Adjust the font size as needed
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Raleway',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle "See All" click
                      // Replace with your navigation logic
                      Navigator.push(context, MaterialPageRoute(builder: (context) => tendance())); // Replace with the appropriate screen for viewing all offers
                    },
                    child: Text(
                      'See All',
                      style: TextStyle(
                        fontSize: 16, // Adjust the font size as needed
                        color: Colors.blue,
                        fontFamily: 'Raleway',// Add the color you want for the link
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Add your new widget here
            Container(
              height: 150, // Adjust the height as needed
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Handle category item click
                      // Replace with your navigation logic
                      Navigator.push(context, MaterialPageRoute(builder: (context) => tendance())); // Replace with the appropriate category screen
                    },
                    child: Container(
                      width: 150, // Adjust the width as needed
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(products[index]["image"]),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(
                          color: customColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Add padding as needed
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Nouveautes',
                    style: TextStyle(
                      fontSize: 18, // Adjust the font size as needed
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Raleway',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle "See All" click
                      // Replace with your navigation logic
                      Navigator.push(context, MaterialPageRoute(builder: (context) => nouveautes())); // Replace with the appropriate screen for viewing all offers
                    },
                    child: Text(
                      'See All',
                      style: TextStyle(
                        fontSize: 16, // Adjust the font size as needed
                        color: Colors.blue,
                        fontFamily: 'Raleway',// Add the color you want for the link
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 150, // Adjust the height as needed
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: nouveaute.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Handle category item click
                      // Replace with your navigation logic
                      Navigator.push(context, MaterialPageRoute(builder: (context) => nouveautes())); // Replace with the appropriate category screen
                    },
                    child: Container(
                      width: 150, // Adjust the width as needed
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(nouveaute[index]["image"]),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(
                          color: customColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Add padding as needed
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tout Le Magazin',
                    style: TextStyle(
                      fontSize: 18, // Adjust the font size as needed
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Raleway',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle "See All" click
                      // Replace with your navigation logic
                      Navigator.push(context, MaterialPageRoute(builder: (context) => toutmagazin())); // Replace with the appropriate screen for viewing all offers
                    },
                    child: Text(
                      'See All',
                      style: TextStyle(
                        fontSize: 16, // Adjust the font size as needed
                        color: Colors.blue,
                        fontFamily: 'Raleway',// Add the color you want for the link
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 150, // Adjust the height as needed
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: magazin.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Handle category item click
                      // Replace with your navigation logic
                      Navigator.push(context, MaterialPageRoute(builder: (context) => toutmagazin())); // Replace with the appropriate category screen
                    },
                    child: Container(
                      width: 150, // Adjust the width as needed
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(magazin[index]["image"]),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(
                          color: customColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: GNav(
        rippleColor: Colors.grey,
        hoverColor: Colors.white,
        gap:9,
        activeColor: Colors.black,
        iconSize: 24,
        padding: EdgeInsets.symmetric(horizontal:20,vertical:20),
        duration: Duration(milliseconds:200),
        tabBackgroundColor: customColor,
        tabs: [
          GButton(
            icon: Icons.home,
            text: 'Home',
            onPressed: () {
              // Handle Home button tap
              // Replace with your navigation logic
            },
          ),
          GButton(
            icon: Icons.category_outlined,
            text: 'Categories',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CategoriesScreen()),
              );
            },
          ),GButton(
            icon: Icons.person,
            text: 'Profile',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }

  void setState(Null Function() param0) {}
}


