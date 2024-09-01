import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_shop/config/color.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({super.key});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("product").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return ListView.builder(itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                height: 100,
                width: 345,
                decoration: BoxDecoration(
                    color: mainColor, borderRadius: BorderRadius.circular(18)),
                child: Center(
                  child: ListTile(
                    leading: Image.network(
                      "${snapshot.data!.docs[index]["image"]}",
                      height: 80,
                      width: 80,
                    ),
                    title: Text(
                      "${snapshot.data!.docs[index]['Name']}",
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    subtitle: Text(
                      "\$${snapshot.data!.docs[index]['Price']}",
                      style: GoogleFonts.poppins(
                          fontSize: 15, color: Colors.white),
                    ),
                    trailing: const CircleAvatar(
                      child: Icon(Icons.add),
                    ),
                  ),
                ),
              );
            });
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
    );
  }
}
