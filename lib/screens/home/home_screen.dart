import 'dart:io';

import 'package:deal_zone/screens/products/sell_screen.dart';
import 'package:deal_zone/screens/profile/edit_profile.dart';
import 'package:deal_zone/screens/profile/profile_display.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeContent(),
    SellContent(),
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
      body: _screens[_selectedIndex], // Displays the selected screen
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            backgroundColor: Colors.yellowAccent,
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            backgroundColor: Colors.yellowAccent,
            label: 'Sell',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          )
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home',   
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error while registering'),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No products found'),
            );
          }
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75, // Adjust the aspect ratio as needed
            ),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var product = snapshot.data!.docs[index];
              return ProductCard(
                productName: product['productName'],
                productDescription: product['productDescription'],
                price: '₹ ${product['price']}',
                sellerId: product['sellerId'],
                imageUrl: product['imageUrl'],
                
              );
            },
          );
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String productName;
  final String productDescription;
  final String price;
  final String sellerId;
  final String imageUrl;

  const ProductCard({
    Key? key,
    required this.productName,
    required this.productDescription,
    required this.price,
    required this.sellerId,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: imageUrl.isNotEmpty
                ? Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  )
                : Container(), // Placeholder if no image
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: const TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4.0),
                Text(
                  productDescription,
                  style: const TextStyle(fontSize: 14.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      price,
                      style: const TextStyle(fontSize: 14.0),
                    ),
                    Row(
                      children: [
                      IconButton(
                          onPressed: () {
                            // Implement messaging functionality
                            _sendMessage(context, productName);
                          },
                          icon: const Icon(Icons.message),
                        ),
                        IconButton(
                          onPressed: () async {
                            try {
                              await FlutterShare.share(
                                title: 'Check out this product!',
                                text: '$productName: $productDescription\nPrice: $price',
                                linkUrl: imageUrl.isNotEmpty ? imageUrl : null,
                                chooserTitle: 'Share Product', // Optional, default: 'Share'
                              );
                            } catch (e) {
                              print('Error sharing');
                              // Handle error if sharing fails
                            }
                          },
                          icon: const Icon(Icons.share),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage(BuildContext context, String productName) async {
  // Construct the message text with placeholders
  final message = 'Hi, I am interested in $productName. Can you provide more details?';

  // Construct platform-specific WhatsApp URLs
  final androidUrl = 'https://wa.me/9607002555?text=${Uri.encodeComponent(message)}';
  final iosUrl = 'https://api.whatsapp.com/send?phone=&text=${Uri.encodeComponent(message)}';

  // Construct SMS URL with encoded message
  final smsUrl = 'sms:?body=${Uri.encodeComponent(message)}';

  // Check platform and launch corresponding URL
  if (await canLaunchUrl(Uri.parse(androidUrl))) {
    await launchUrl(Uri.parse(androidUrl));
  } else if (await canLaunchUrl(Uri.parse(iosUrl))) {
    await launchUrl(Uri.parse(iosUrl));
  } else {
    // Fallback to SMS on other platforms
    await launchUrl(Uri.parse(smsUrl));
  }
}
}