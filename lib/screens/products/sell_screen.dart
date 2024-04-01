/*
import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'package:deal_zone/screens/products/add_product.dart';
import 'package:deal_zone/screens/home/home_screen.dart'; 
import 'package:flutter/material.dart';
import 'package:deal_zone/screens/profile/edit_profile.dart';

class SellScreen extends StatefulWidget {
  @override
  _SellScreenState createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  final _productsStream = FirebaseFirestore.instance.collection('products').snapshots();
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    SellContent(),
    const EditProfileScreen(sapId: 'sapId',),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sell Screen'),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: 'Sell',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class SellContent extends StatefulWidget {
  @override
  _SellContentState createState() => _SellContentState();
}

class _SellContentState extends State<SellContent> {
  late Stream<QuerySnapshot> _productsStream;

  @override
  void initState() {
    super.initState();
    _productsStream = FirebaseFirestore.instance.collection('products').snapshots();
  }

  void _addProduct() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddProductScreen()),
    );
  }

  void _deleteProduct(String productId) {
    FirebaseFirestore.instance.collection('products').doc(productId).delete().then((value) {
     return const AlertDialog(
      title: Text("Product Deleted Successfully"),
     );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete product')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sell Products'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextButton(
              onPressed: _addProduct,
              child: const Text('Add Product'),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _productsStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No products found'));
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var product = snapshot.data!.docs[index];
                      return ListTile(
                        title: Text(product['productName']),
                        subtitle: Text(product['productDescription']),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteProduct(product.id),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'package:deal_zone/screens/products/add_product.dart';
import 'package:deal_zone/screens/home/home_screen.dart';
import 'package:deal_zone/screens/profile/profile_display.dart'; 
import 'package:flutter/material.dart';
import 'package:deal_zone/screens/profile/edit_profile.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({super.key});

  @override
  _SellScreenState createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const SellContent(),
    ProfileDisplayScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Sell Screen'),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: 'Sell',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class SellContent extends StatefulWidget {
  const SellContent({super.key});

  @override
  _SellContentState createState() => _SellContentState();
}

class _SellContentState extends State<SellContent> {
  late Stream<QuerySnapshot> _productsStream;

  @override
  void initState() {
    super.initState();
    _productsStream = FirebaseFirestore.instance.collection('products').snapshots();
  }

  void _addProduct() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddProductScreen()),
    );
  }

  void _deleteProduct(String productId) {
    FirebaseFirestore.instance.collection('products').doc(productId).delete().then((value) {
     return const AlertDialog(
      title: Text("Product Deleted Successfully!!"),
     );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete product')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sell Products'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _addProduct,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.purpleAccent), // Set accent color of Twitch
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0), // Give border to button
                  ),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Add Product',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black, // Set text color to black
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _productsStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No products found'));
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var product = snapshot.data!.docs[index];
                      return ListTile(
                        title: Text(product['productName']),
                        subtitle: Text(product['productDescription']),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteProduct(product.id),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
