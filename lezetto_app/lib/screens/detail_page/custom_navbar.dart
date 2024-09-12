import 'package:flutter/material.dart';

class CustomNavbar extends StatelessWidget {
  final VoidCallback onBackPressed;
  final VoidCallback onSavePressed;
  final VoidCallback onRatePressed;
  final VoidCallback onSharePressed;

  CustomNavbar({
    required this.onBackPressed,
    required this.onSavePressed,
    required this.onRatePressed,
    required this.onSharePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.grey[300],
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.1,
            child: Center(
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.grey[800], size: 40),
                onPressed: onBackPressed,
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Align(
                child: IconButton(
                  icon: Icon(Icons.favorite_border, color: Colors.grey[800], size: 40),
                  onPressed: onSavePressed,
                ),
              ),
                SizedBox(width: 30),
                Align(
                  child: IconButton(
                    icon: Icon(Icons.star_border, color: Colors.grey[800], size: 40),
                    onPressed: onRatePressed,
                  ),
                ),
                SizedBox(width: 30),
                Align(
                  child: IconButton(
                    icon: Icon(Icons.share, color: Colors.grey[800], size: 40),
                    onPressed: onSharePressed,
                  ),
                ),],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onPressed) {
    return Container(
      height: 65,
      alignment: Alignment.center,
      child: IconButton(
        icon: Icon(icon, color: Colors.grey[600], size: 40),
        onPressed: onPressed,
      ),
    );
  }
}
