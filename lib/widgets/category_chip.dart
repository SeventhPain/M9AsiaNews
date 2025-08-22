import 'package:flutter/material.dart';
import '../models/news_type_model.dart';
import '../utils/constants.dart';

class CategoryChip extends StatelessWidget {
  final NewsType category;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryChip({
    Key? key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppConstants.primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppConstants.primaryColor, width: 1),
        ),
        child: Text(
          category.name,
          style: TextStyle(
            color: isSelected ? Colors.white : AppConstants.primaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
