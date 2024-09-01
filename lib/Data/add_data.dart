import 'package:cloud_firestore/cloud_firestore.dart';

//For Add Products
Future<void> addProducts() async {
  final products = [
    {
      'productName': "Normal Chappals",
      'productPrice': 30,
      'productImage':
          "https://i.pinimg.com/564x/96/ed/20/96ed206fa55a01b0acdcefe737a0c5cb.jpg",
      'category': "Normal"
    },
  ];

  final firestore = FirebaseFirestore.instance;

  for (var product in products) {
    // Check if the product already exists
    var existingDocs = await firestore
        .collection('products')
        .where('productName', isEqualTo: product['productName'])
        .get();

    if (existingDocs.docs.isEmpty) {
      await firestore.collection('products').add(product);
      print('Product added: ${product['productName']}');
    } else {
      print('Product already exists: ${product['productName']}');
    }
  }
}

//For Add Categories
// Future<void> addCategories() async {
//   final categories = [
//     {'name': 'Slippers'},
//     {'name': 'Normal'},
//     {'name': 'Shoes'},
//     {'name': 'Heels'},
//     {'name': 'Baby Shoes'},
//     {'name': 'Boots'}
//   ];

//   final firestore = FirebaseFirestore.instance;

//   for (var category in categories) {
//     await firestore.collection('categories').add(category);
//   }

//   print('Categories added');
// }
