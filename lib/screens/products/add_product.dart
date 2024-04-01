import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productDescriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  File? _imageFile;
  bool _isAddingProduct = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              GestureDetector(
                onTap: _getImage,
                child: _imageFile == null
                    ? Container(
                        height: 300,
                        color: Colors.white, // Set background color to white
                        alignment: Alignment.center,
                        child: const Icon(Icons.add_a_photo, size: 100, color: Colors.purple), // Set text color to black
                      )
                    : Image.file(_imageFile!, height: 200,width: 200, fit: BoxFit.contain),
              ),
              TextFormField(
                controller: _productNameController,
                decoration: const InputDecoration(labelText: 'Product Name', labelStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255))), // Set text color to black
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter product name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _productDescriptionController,
                decoration: const InputDecoration(labelText: 'Product Description', labelStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255))), // Set text color to black
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter product description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price', labelStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255))), // Set text color to black
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter price';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: _isAddingProduct ? null : () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _isAddingProduct = true;
                    });

                    // Upload image (replace with your upload logic)
                    String imageUrl = '';
                    if (_imageFile != null) {
                      imageUrl = await uploadImage(_imageFile!);
                    }

                    // Store product details in Firestore
                    final CollectionReference products = FirebaseFirestore.instance.collection('products');

                    // Generate sellerId
                    final sellerId = FirebaseFirestore.instance.collection('sellers').doc().id;

                    // Generate productId
                    final newProductRef = products.doc();
                    final productId = newProductRef.id;

                    await newProductRef.set({
                      'productId': productId,
                      'sellerId': sellerId,
                      'productName': _productNameController.text,
                      'productDescription': _productDescriptionController.text,
                      'price': double.parse(_priceController.text),
                      'imageUrl': imageUrl,
                    });

                    // Clear form fields after adding the product
                    _productNameController.clear();
                    _productDescriptionController.clear();
                    _priceController.clear();
                    setState(() {
                      _imageFile = null;
                      _isAddingProduct = false;
                    });

                    // Show success alert
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Success', style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))), // Set text color to black
                          content: const Text('Product added successfully', style: TextStyle(color: Colors.black)), // Set text color to black
                          actions: [
                             TextButton(
                          onPressed: () {
                          Navigator.of(context).pop(); // Close alert dialog
                          },
                          child: const Text('OK'),
                           ),
                          ],
                        );
                      },
                    );
                  }
                }, // Set text color to black
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.purpleAccent), // Set accent color of Twitch
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), // Give border to button
                    ),
                  ),
                ),
                child: _isAddingProduct
                    ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 255, 255, 255)),
                    ) // Show circular progress indicator while adding
                    : const Text('Add Product', style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<String> uploadImage(File imageFile) async {
    final storage = FirebaseStorage.instance;
    final reference = storage.ref().child('product_images/${DateTime.now().millisecondsSinceEpoch}');
    final uploadTask = await reference.putFile(imageFile);
    final imageUrl = await uploadTask.ref.getDownloadURL();
    return imageUrl;
  }
}
