import 'package:flutter/material.dart';
import 'conversion.dart';

class HomePage extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {'name': 'Time', 'icon': Icons.access_time},
    {'name': 'Length', 'icon': Icons.straighten},
    {'name': 'Weight', 'icon': Icons.fitness_center},
    {'name': 'Temperature', 'icon': Icons.thermostat},
  ];

  // Autumn vibe colors
  final Color primaryColor = Color(0xFF8B0000); // dark red / brown
  final Color secondaryColor = Color(0xFFFFF5E1); // soft cream background

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        title: Text('Convertly'),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 4,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Intro / About
            Text(
              'Welcome to Convertly!\n\nEasily convert units of Time, Length, Weight, and Temperature. '
              'Select a category below to start converting quickly and efficiently. Enjoy simple and accurate conversions!',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 24),

            // Grid of categories (2 per row)
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // 2 cards per row
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.5, // smaller height → cards less tall
                children: categories.map((category) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ConversionPage(
                            category: category['name'],
                            primaryColor: primaryColor,
                            secondaryColor: secondaryColor,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(category['icon'], size: 36, color: Colors.white),
                          SizedBox(height: 8),
                          Text(
                            category['name'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
