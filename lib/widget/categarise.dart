import 'package:flutter/material.dart';
import 'package:shoes_shop/config/color.dart';

class Categarise extends StatelessWidget {
  final void Function(String) onCategorySelected;

  const Categarise({super.key, required this.onCategorySelected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100, // Set a fixed height for the ListView
      child: ListView(
        padding: const EdgeInsets.only(left: 10),
        scrollDirection: Axis.horizontal,
        children: [
          _buildCategoryItem(context, 'All',
              'https://cdn-icons-png.flaticon.com/128/5393/5393437.png'),
          _buildCategoryItem(context, 'Slippers',
              'https://cdn-icons-png.flaticon.com/128/3100/3100602.png'),
          _buildCategoryItem(context, 'Normal',
              'https://cdn-icons-png.flaticon.com/128/1952/1952861.png'),
          _buildCategoryItem(context, 'Shoes',
              'https://cdn-icons-png.flaticon.com/128/3113/3113245.png'),
          _buildCategoryItem(context, 'Heels',
              'https://cdn-icons-png.flaticon.com/128/4016/4016399.png'),
          _buildCategoryItem(context, 'Baby Shoes',
              'https://cdn-icons-png.flaticon.com/128/9960/9960195.png'),
          _buildCategoryItem(context, 'Boots',
              'https://cdn-icons-png.flaticon.com/128/6003/6003701.png'),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(
      BuildContext context, String categoryName, String imageUrl) {
    return GestureDetector(
      onTap: () => onCategorySelected(categoryName),
      child: Padding(
        padding: const EdgeInsets.only(right: 5),
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: mainColor,
              radius: 30,
              child: Image.network(
                imageUrl,
                height: 40,
                width: 40,
              ),
            ),
            Text(categoryName)
          ],
        ),
      ),
    );
  }
}
