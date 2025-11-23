import 'package:flutter/material.dart';
import 'conversion.dart';

class HomePage extends StatelessWidget {
  // List of conversion categories, each with a name and an icon
  final List<Map<String, dynamic>> categories = [
    {'name': 'Time', 'icon': Icons.access_time},
    {'name': 'Length', 'icon': Icons.straighten},
    {'name': 'Weight', 'icon': Icons.fitness_center},
    {'name': 'Temperature', 'icon': Icons.thermostat},
  ];

  // Autumn theme colors
  final Color primaryColor = Color( 0xFF8B0000,); 
  final Color secondaryColor = Color(0xFFFFF5E1); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor, // Set the overall background color
      // AppBar at the top
      appBar: AppBar(
        title: Text('Convertly'), // App name
        centerTitle: true, // Center the title
        backgroundColor: primaryColor, // Dark red color
        elevation: 4, // Shadow below the AppBar
      ),

      // Main body of the page
      body: Padding(
        padding: EdgeInsets.all(16), // Padding around the entire body
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.stretch, // Stretch children to full width
          children: [
            // Intro / About text
            Text(
              'Welcome to Convertly!\n\nEasily convert units of Time, Length, Weight, and Temperature. '
              'Select a category below to start converting quickly and efficiently. Enjoy simple and accurate conversions!',
              style: TextStyle(
                fontSize: 16, // Text size
                height: 1.5, // Line spacing for readability
              ),
            ),
            SizedBox(height: 24), // Space between intro and category grid
            // Grid of category cards (2 per row)
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // Number of columns
                mainAxisSpacing: 16, // Vertical spacing between rows
                crossAxisSpacing: 16, // Horizontal spacing between columns
                childAspectRatio:1.5, // Controls card height; smaller → less tall
                children: categories.map((category) {
                  // Each category is a tappable card
                  return GestureDetector(
                    onTap: () {
                      // Navigate to the ConversionPage when tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute( builder: (_) => ConversionPage(
                            category: category['name'], // Pass category name
                            primaryColor: primaryColor, // Pass theme colors
                            secondaryColor: secondaryColor,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      // Card decoration
                      decoration: BoxDecoration(
                        color: primaryColor, // Card background color
                        borderRadius: BorderRadius.circular(
                          16,
                        ), // Rounded corners
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26, // Shadow color
                            blurRadius: 4, // Shadow blur
                            offset: Offset(2, 2), // Shadow offset
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment
                            .center, // Center content vertically
                        children: [
                          Icon(
                            category['icon'], // Icon of the category
                            size: 36,
                            color: Colors.white, // White icon
                          ),
                          SizedBox(height: 8), // Space between icon and text
                          Text(
                            category['name'], // Category name
                            style: TextStyle(
                              color: Colors.white, // White text
                              fontSize: 16, // Text size
                              fontWeight: FontWeight.bold, // Bold
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(), // Convert mapped widgets to list
              ),
            ),

            // Footer section
            Container(
              padding: EdgeInsets.symmetric(vertical: 12), // Vertical padding
              color: primaryColor.withOpacity(
                0.1,
              ), // Slightly darker than background
              child: Center(
                child: Text(
                  '@Convertly • All Right Reserved • CSCI410 Project',
                  style: TextStyle(
                    fontSize: 12, // Small text
                    color: primaryColor, // Match primary color
                    fontWeight: FontWeight.w600, // Semi-bold
                  ),
                  textAlign: TextAlign.center, // Center the text
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
