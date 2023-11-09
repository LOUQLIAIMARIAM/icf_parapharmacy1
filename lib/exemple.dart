import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> _categoryImages = [];

  @override
  void initState() {
    super.initState();
    fetchCategoryImages();
  }

  void fetchCategoryImages() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('categories').get();
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        final categoryData = doc.data() as Map<String, dynamic>?; // Cast to Map

        if (categoryData != null && categoryData.containsKey('categoryImage')) {
          final categoryImage = categoryData['categoryImage'] as String?;
          if (categoryImage != null) {
            setState(() {
              _categoryImages.add(categoryImage);
            });
          }
        }
      }
    } catch (e) {
      print("Error fetching category images: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: _categoryImages.isNotEmpty
          ? StaggeredGridView.countBuilder(
           crossAxisCount: 2,
           itemCount: _categoryImages.length,
           itemBuilder: (context, index) {
           final categoryImage = _categoryImages[index];
           return InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CategoryImageDetailScreen(
                  categoryImage: categoryImage,
                ),
              ));
            },
            child: Hero(
              tag: 'categoryImage_$index',
              child: Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black), // Add frame
                  borderRadius: BorderRadius.circular(10), // Add border radius
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    categoryImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        },
        staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
      )
          : Center(
           child: CircularProgressIndicator(), // Display a loading indicator while fetching data
      ),
    );
  }
}

class CategoryImageDetailScreen extends StatelessWidget {
  final String categoryImage;

  CategoryImageDetailScreen({required this.categoryImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Detail'),
      ),
      body: Center(
        child: Hero(
          tag: 'categoryImage',
          child: Image.network(categoryImage),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CategoriesScreen(),
  ));
}
