import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  BottomNavBar({required this.selectedIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: Colors.grey[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(5, (index) {
          bool isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () => onItemTapped(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: isSelected ? 120 : 50,
              height: 50,
              margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                color: isSelected ? Colors.grey[800] : Colors.grey[300],
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    [Icons.home, Icons.soup_kitchen, Icons.search, Icons.receipt, Icons.shopping_bag_outlined][index],
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                  if (isSelected)
                    SizedBox(width: 8),
                  if (isSelected)
                    Flexible(
                      child: Text(
                        ['Anasayfa', 'Mutfak', 'Arama', 'Tariflerim', 'A. Listesi'][index],
                        style: const TextStyle(color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
