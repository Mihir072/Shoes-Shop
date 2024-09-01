import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_shop/config/color.dart';
import 'package:shoes_shop/widget/bottumbar.dart';
import 'package:shoes_shop/widget/categarise.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedCategory = 'All'; // Default category
  String _searchQuery = ''; // Search query

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottumBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              height: 150,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
                child: Image.asset(
                  'asset/images/Banner.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.search),
                    hintText: 'Search Here..',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Categories..',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Categarise(onCategorySelected: (category) {
              setState(() {
                _selectedCategory = category;
              });
            }),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("products")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      var filteredDocs = snapshot.data!.docs
                          .where((doc) =>
                              (_selectedCategory == 'All' ||
                                  doc['category'] == _selectedCategory) &&
                              doc['productName']
                                  .toString()
                                  .toLowerCase()
                                  .contains(_searchQuery.toLowerCase()))
                          .toList();

                      return ListView.builder(
                        itemCount: filteredDocs.length,
                        itemBuilder: (context, index) {
                          var doc = filteredDocs[index];
                          return Container(
                            margin: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 5),
                            height: 100,
                            width: 345,
                            decoration: BoxDecoration(
                              color: mainColor,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Center(
                              child: ListTile(
                                leading: Image.network(
                                  doc["productImage"],
                                  height: 80,
                                  width: 80,
                                ),
                                title: Text(
                                  doc['productName'],
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                subtitle: Text(
                                  "\$${doc['productPrice']}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                                trailing: const CircleAvatar(
                                  child: Icon(Icons.add),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text("Error: ${snapshot.error.toString()}"),
                      );
                    } else {
                      return const Center(
                        child: Text("No products available"),
                      );
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
