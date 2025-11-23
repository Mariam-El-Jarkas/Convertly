import 'package:flutter/material.dart';
import 'units.dart';

class ConversionPage extends StatefulWidget {
  final String category; // The conversion category (Time, Length, Weight, Temperature)
  final Color primaryColor; 
  final Color secondaryColor; 

//constructor
  ConversionPage({
    required this.category,
    required this.primaryColor,
    required this.secondaryColor,
  });

  @override
  _ConversionPageState createState() => _ConversionPageState();
}

// State class manages the mutable state of ConversionPage
class _ConversionPageState extends State<ConversionPage> {
  final TextEditingController _controller =
      TextEditingController(); // Input field controller
  String fromUnit = ''; // Currently selected "from" unit
  String toUnit = ''; // Currently selected "to" unit
  double? result; // Holds conversion result (null initially)

  @override
  void initState() {
    super.initState();
    // Initialize default units (first two units in the category)
    var units = Units
        .categories[widget.category]!; // Get units list for selected category
    fromUnit = units[0].name; // Default "from" unit = first unit in the list
    toUnit = units.length > 1
        ? units[1].name
        : units[0].name; // Default "to" unit
  }

  // Helper function to build dropdowns for "from" and "to" units
  Widget buildDropdown(String value, Function(String?) onChanged) {
    return Expanded(
      child: DropdownButtonFormField<String>(
        value: value, // Selected value
        items: Units
            .categories[widget.category]! // Get all units in category
            .map((u) => DropdownMenuItem(value: u.name, child: Text(u.name)))
            .toList(),
        onChanged: onChanged, // Update state when a new unit is selected
        decoration: InputDecoration(
          labelText: value == fromUnit
              ? 'From'
              : 'To', // Label depends on which dropdown
          labelStyle: TextStyle(color: widget.primaryColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ), // Rounded border
        ),
      ),
    );
  }

  // Convert input value from "fromUnit" to "toUnit"
  void convert() {
    setState(() {
      // Parse input, default to 0 if invalid, then perform conversion
      result = Units.convert(
        widget.category,
        fromUnit,
        toUnit,
        double.tryParse(_controller.text) ?? 0,
      );
    });
  }

  // Reset input field, result, and dropdowns to default values
  void reset() {
    var units = Units.categories[widget.category]!;
    setState(() {
      _controller.clear(); // Clear input
      result = null; // Clear displayed result
      fromUnit = units[0].name; // Reset "from" unit
      toUnit = units.length > 1
          ? units[1].name
          : units[0].name; // Reset "to" unit
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.secondaryColor.withOpacity(  0.1, ), // Light background color
      // AppBar with dynamic title and reset icon
      appBar: AppBar(
        title: Text('${widget.category} Conversion'), // Show category name
        centerTitle: true,
        backgroundColor: widget.primaryColor,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh), // Reset button
            onPressed: reset,
            tooltip: 'Reset',
          ),
        ],
      ),

      // Main page body
      body: Padding(
        padding: EdgeInsets.all(16), // Outer padding
        child: Column(
          children: [
            // Input TextField
            TextField(
              controller: _controller, // Connect controller
              keyboardType: TextInputType.number, // Only numeric input
              decoration: InputDecoration(
                labelText: 'Enter value', // Placeholder
                labelStyle: TextStyle(color: widget.primaryColor),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: widget.primaryColor),
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.primaryColor.withOpacity(0.5),
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 20), // Spacing
            // Row with "from" and "to" dropdowns
            Row(
              children: [
                buildDropdown(
                  fromUnit,
                  (val) => setState(() => fromUnit = val!),
                ), // From dropdown
                SizedBox(width: 16), // Horizontal spacing
                buildDropdown(
                  toUnit,
                  (val) => setState(() => toUnit = val!),
                ), // To dropdown
              ],
            ),
            SizedBox(height: 20), // Spacing
            // Convert button
            ElevatedButton(
              onPressed: convert, // Perform conversion when tapped
              child: Text('Convert'),
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.primaryColor,
                foregroundColor: Colors.black, 
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 30), // Spacing
            // Result display container (only shown if result is not null)
            if (result != null)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: widget.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$result $toUnit', // Show converted value and target unit
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: widget.primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
