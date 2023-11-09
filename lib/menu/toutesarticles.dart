
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../cart.dart';
import '../paimant/paiment_methods.dart';

class toutesarticls extends StatefulWidget {
  const toutesarticls({Key? key}) : super(key: key);

  @override
  State<toutesarticls> createState() => _toutesarticlsState();
}

class _toutesarticlsState extends State<toutesarticls> {
  Cart cart = Cart();
  List<Product> products = [
    Product(
      name: 'Botot Dentifrice\nJaune Anis',
      price: 'MAD70.00',
      imageUrl: 'assets/mv/botot.png',
      isFavorite: false,
    ),
    Product(
      name: 'Rogé Cavaillès\nBaume Lèvres',
      price: 'MAD47.00',
      imageUrl: 'assets/mv/pro.png',
      isFavorite: false,
    ),
    Product(
      name: 'Elixir Ultime\nhuile Lavante',
      price: 'MAD660.00',
      imageUrl: 'assets/mv/lik.png',
      isFavorite: false,
    ),
    Product(
      name: '	LIERAC Cohérence\nJour & Nuit ',
      price: 'MAD400.00',
      imageUrl: 'assets/mv/lirak.png',
      isFavorite: false,
    ),
    Product(
      name: 'SVR Clairial Peel',
      price: 'MAD299.00',
      imageUrl: 'assets/mv/svr.jpg',
      isFavorite: false,
    ),
    Product(
      name: 'Avène Solaire Anti-Âge',
      price: 'MAD12.99',
      imageUrl:'assets/mv/avene.png',
      isFavorite: false,
    ),
    Product(
      name: 'Fenioux Huile De Foie ',
      price: 'MAD194.00',
      imageUrl: 'assets/mv/yani.png',
      isFavorite: false,
    ),
    Product(
      name: 'Akileine Onykoleine',
      price: 'MAD99.00',
      imageUrl: 'assets/mv/df.png',
      isFavorite: false,
    ),
    Product(
      name: 'Cattier Gel Douche Douceur',
      price: 'MAD150.00',
      imageUrl: 'assets/mv/cari.png',
      isFavorite: false,
    ),
    Product(
      name: 'Physicians Formula Fond De',
      price: 'MAD220.00',
      imageUrl: 'assets/mv/fond.png',
      isFavorite: false,
    ),
    Product(
      name: 'Promotion Elisabeth Arden',
      price: 'MAD480.00',
      imageUrl: 'assets/mv/par.png',
      isFavorite: false,
    ),
    Product(
      name: 'Klorane Myrte Shampooing',
      price: 'MAD56.00',
      imageUrl: 'assets/mv/klo.png',
      isFavorite: false,
    ),
    // Ajoutez plus de produits ici
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toutes Les Article'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final productName = await showSearch(
                context: context,
                delegate: ProductSearch(products),
              );

              if (productName != null) {
                // Handle the selected product, e.g., navigate to the product details page.
                // You can add your logic here.
              }
            },
          ),
        ],
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsPage(
                    product: products[index], cart: cart,
                  ),
                ),
              );
            },
            child: ProductItem(
              product: products[index],
              onFavoriteToggle: () {
                setState(() {
                  products[index].isFavorite = !products[index].isFavorite;
                });
              }, cart: cart,
            ),
          );
        },
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final Product product;
  final VoidCallback onFavoriteToggle;
  final Cart cart;

  ProductItem({
    required this.product,
    required this.onFavoriteToggle,
    required this.cart,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFE9F7FF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Image.asset(
                product.imageUrl,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: onFavoriteToggle,
                  child: Icon(
                    product.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: product.isFavorite ? Colors.green : Colors.black,
                    size: 32,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  product.name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  product.price,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.brown,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Cart {
  List<Product> items = [];

  void addToCart(Product product) {
    items.add(product);
  }
}

class Product {
  final String name;
  final String price;
  final String imageUrl;
  bool isFavorite;
  int quantity;

  Product({
    required this.name,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
    this.quantity = 1
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'quantity': quantity,
      'imageUrl': imageUrl,
    };
  }
}


class CartPage extends StatefulWidget {
  final List<Product> cartItems;

  CartPage({required this.cartItems});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late List<Product> cartItems;

  @override
  void initState() {
    super.initState();
    cartItems = widget.cartItems.toList();
  }

  // Function to remove an item from the cart
  void removeItem(Product product) {
    setState(() {
      cartItems.remove(product);
    });
  }

  // Function to increase the quantity of an item
  void increaseQuantity(Product product) {
    setState(() {
      product.quantity++;
    });
  }

  // Function to decrease the quantity of an item
  void decreaseQuantity(Product product) {
    setState(() {
      if (product.quantity > 1) {
        product.quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Calculate the total price
    double totalPrice = 0;
    for (var item in cartItems) {
      totalPrice += double.parse(item.price.replaceAll('MAD', '')) * item.quantity;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: CustomCartListView(cartItems: cartItems, onRemoveItem: removeItem, onIncreaseQuantity: increaseQuantity, onDecreaseQuantity: decreaseQuantity),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Total Price: MAD $totalPrice',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigate to the cart summary screen
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CartSummaryScreen(
                      cartItems: cartItems,
                      total: totalPrice,
                    ),
                  ),
                );
              },
              child: Text('Acheter Maintenant',
                style: TextStyle(
                  fontSize: 16, // Adjust the font size as needed
                  color: Colors.white,
                  fontFamily: 'Raleway',// Add the color you want for the link
                ),),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF204B64)), // Set the background color
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomCartListView extends StatelessWidget {
  final List<Product> cartItems;
  final Function(Product) onRemoveItem;
  final Function(Product) onIncreaseQuantity;
  final Function(Product) onDecreaseQuantity;

  CustomCartListView({
    required this.cartItems,
    required this.onRemoveItem,
    required this.onIncreaseQuantity,
    required this.onDecreaseQuantity,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        final cartProduct = cartItems[index];
        return ListTile(
          title: Text(cartProduct.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Price: ${cartProduct.price}'),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      onDecreaseQuantity(cartProduct);
                    },
                  ),
                  Text('${cartProduct.quantity}'),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      onIncreaseQuantity(cartProduct);
                    },
                  ),
                ],
              ),
            ],
          ),
          leading: Image.asset(
            cartProduct.imageUrl,
            width: 100,
            height: 150,
            fit: BoxFit.cover,
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              onRemoveItem(cartProduct);
            },
          ),
        );
      },
    );
  }
}

class ProductDetailsPage extends StatefulWidget {
  final Product product;
  final Cart cart; // Pass the Cart instance

  ProductDetailsPage({
    required this.product,
    required this.cart, // Pass the Cart instance
  });

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  double _rating = 4.5; // Initial rating value, replace with the actual product rating

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: Container( // Add a Container for the white background
        color: Colors.white, // Set the background color to white
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Image.asset(
                widget.product.imageUrl,
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Name
                    Text(
                      widget.product.name,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    // Product Price
                    Text(
                      widget.product.price,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.brown,
                      ),
                    ),
                    SizedBox(height: 16),
                    // Product Description
                    Text(
                      'Description: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed condimentum lectus in dui imperdiet bibendum.',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 16),
                    // Rating Bar
                    RatingBar.builder(
                      initialRating: _rating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 30,
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (newRating) {
                        setState(() {
                          _rating = newRating;
                        });
                      },
                    ),
                    SizedBox(height: 24),
                    // Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            widget.cart.addToCart(widget.product); // Add the product to the cart
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${widget.product.name} added to cart'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                          child: Text('Add to Cart',
                            style: TextStyle(
                              fontSize: 16, // Adjust the font size as needed
                              color: Colors.white,
                              fontFamily: 'Raleway',// Add the color you want for the link
                            ),),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF204B64)), // Set the background color
                          ),
                        ),

                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => PaymentScreen(
                                productName: widget.product.name, // Replace with the actual product name
                                productPrice: widget.product.price, // Replace with the actual product price
                              ),
                            ));
                          },
                          child: Text(
                            'Acheter Maintenant',
                            style: TextStyle(
                              fontSize: 16, // Adjust the font size as needed
                              color: Colors.white,
                              fontFamily: 'Raleway', // Add the color you want for the link
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF204B64)), // Set the background color
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 24),
                    Align(
                      alignment: Alignment.topRight,
                      child: FloatingActionButton(
                        onPressed: () {
                          // Navigate to the CartPage with cartItems
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CartPage(cartItems: widget.cart.items),
                            ),
                          );
                        },
                        child: Icon(Icons.shopping_cart),
                        backgroundColor: Color(0xFF95B6A3),
                      ),
                    ),
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
class PaymentScreen extends StatefulWidget {
  final String productName;
  final String productPrice;

  PaymentScreen({required this.productName, required this.productPrice});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  void _insertDataIntoFirestore() {
    if (_formKey.currentState!.validate()) {
      CollectionReference collRef =
      FirebaseFirestore.instance.collection('paiment');
      collRef.add({
        'lien': _mapLinkController.text,
        'nom': _nameController.text,
        'numero_telephone': _phoneNumberController.text,
        'produit': _productNameController.text,
        'prix': _productPriceController.text,
      }).then((value) {
        // Data added successfully, show a confirmation dialog.
        _showConfirmationDialog();
      }).catchError((error, stackTrace) {
        print("Error adding data: $error");
        print(stackTrace); // Print the stack trace for more information
      });
    }
  }

  late TextEditingController _productNameController;
  late TextEditingController _productPriceController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _mapLinkController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the controllers with the provided values
    _productNameController = TextEditingController(text: widget.productName);
    _productPriceController = TextEditingController(text: widget.productPrice);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumberController.dispose();
    _mapLinkController.dispose();
    _productNameController.dispose();
    _productPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Paiement à la livraison',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image(
                  image: AssetImage('assets/images/adresse-unscreen.gif'),
                  width: 100, // Adjust the width as needed
                  height: 100, // Adjust the height as needed
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Nom complet',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez saisir votre nom complet';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _phoneNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Numéro de téléphone',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.phone),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez saisir votre numéro de téléphone';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _mapLinkController,
                  decoration: InputDecoration(
                    labelText: 'Votre Adresse',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.map),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez saisir Votre Adresse';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _productNameController,
                  decoration: InputDecoration(
                    labelText: 'Product Name:',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.padding_rounded),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _productPriceController,
                  decoration: InputDecoration(
                    labelText: 'Product Price:',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.price_change),
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                      onPressed: () {
                        _insertDataIntoFirestore();
                      },
                      child: Text('Valider',
                        style: TextStyle(
                          fontSize: 20, color: Colors.white,
                        ),),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        alignment: Alignment.center, // Align the child (text) in the center
                        primary: Colors.blue,)
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Merci de votre confiance, le produit arrivera sous 24h.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class CartSummaryScreen extends StatelessWidget {
  final List<Product> cartItems;
  final double total;

  CartSummaryScreen({required this.cartItems, required this.total});

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paiement à la livraison'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final cartProduct = cartItems[index];
                return ListTile(
                  title: Text(cartProduct.name),
                  subtitle: Text('Quantity: ${cartProduct.quantity}'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: TextField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      labelText: 'Phone',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: TextField(
                    controller: addressController,
                    decoration: InputDecoration(
                      labelText: 'Address',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Text(
                  'Total Price: MAD $total',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    saveToDatabase(cartItems, total, nameController.text, phoneController.text, addressController.text);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Confirmer le paiement',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF204B64)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void saveToDatabase(List<Product> cartItems, double total, String name, String phone, String address) {
    CollectionReference payments = FirebaseFirestore.instance.collection('paiment');

    List<Map<String, dynamic>> cartItemMaps = cartItems.map((item) => item.toMap()).toList();

    Map<String, dynamic> paymentData = {
      'cartItems': cartItemMaps,
      'total': total,
      'name': name,
      'phone': phone,
      'address': address,
      'timestamp': FieldValue.serverTimestamp(),
    };

    payments.add(paymentData)
        .then((value) {
      print("Payment added to Firestore with ID: ${value.id}");
      // You can handle success here, e.g., show a success message to the user.
    })
        .catchError((error) {
      print("Error adding payment to Firestore: $error");
      // Handle the error, e.g., show an error message to the user.
    });
  }
}
class ProductSearch extends SearchDelegate<String> {
  final List<Product> products;

  ProductSearch(this.products);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = products
        .where((product) => product.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return _buildSearchResults(results);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final results = products
        .where((product) => product.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return _buildSearchResults(results);
  }

  Widget _buildSearchResults(List<Product> results) {
    if (results.isEmpty) {
      return Center(
        child: Text('No results found.'),
      );
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            close(context, results[index].name); // Pass the selected product name back to the calling page
          },
          child: ListTile(
            title: Text(results[index].name),
          ),
        );
      },
    );

  }
}
