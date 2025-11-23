class Unit {
  String name; // Name of the unit
  double factorToBase; // Conversion factor to a base unit of the category
  // For example, in Time, base = seconds
  //A factor to base How many of this unit equal one base unit

  // Constructor: requires name and factorToBase
  Unit({required this.name, required this.factorToBase});
}

class Units {
  // Dictionary (map) of categories
  // Each category has a list of Unit objects
  static Map<String, List<Unit>> categories = {
    'Time': [
      Unit(name: 'Seconds', factorToBase: 1), // Base unit = seconds
      Unit(name: 'Minutes', factorToBase: 60), // 1 minute = 60 seconds
      Unit(name: 'Hours', factorToBase: 3600), // 1 hour = 3600 seconds
      Unit(name: 'Milliseconds', factorToBase: 0.001),
      Unit(name: 'Nanoseconds', factorToBase: 1e-9),
    ],
    'Length': [
      Unit(name: 'Meters', factorToBase: 1), // Base unit = meters
      Unit(name: 'Kilometers', factorToBase: 1000),
      Unit(name: 'Miles', factorToBase: 1609.34),
      Unit(name: 'Centimeters', factorToBase: 0.01),
      Unit(name: 'Feet', factorToBase: 0.3048),
    ],
    'Weight': [
      Unit(name: 'Grams', factorToBase: 1), // Base unit = grams
      Unit(name: 'Kilograms', factorToBase: 1000),
      Unit(name: 'Pounds', factorToBase: 453.592),
      Unit(name: 'Milligrams', factorToBase: 0.001),
      Unit(name: 'Tons', factorToBase: 1e6),
    ],
    'Temperature': [
      Unit(name: 'Celsius', factorToBase: 1),
      Unit(name: 'Fahrenheit', factorToBase: 1),
      Unit(name: 'Kelvin', factorToBase: 1),
    ],
  };


  // Static method to convert between units
  static double convert(
    String category, // e.g., 'Time', 'Length'
    String fromUnit, // e.g., 'Seconds'
    String toUnit, // e.g., 'Minutes'
    double value, // value to convert
  ) {
    // If category is Temperature, use the special formula
    if (category == 'Temperature') {
      return _convertTemperature(fromUnit, toUnit, value);
    }
    // For other categories (linear conversions like Time, Length, Weight)
    else {
      // Find the "from" unit object in the list for this category
      // firstWhere loops through the list and finds the first element where the lambda is true
      final from = categories[category]!.firstWhere((u) => u.name == fromUnit);

      // Find the "to" unit object in the list
      final to = categories[category]!.firstWhere((u) => u.name == toUnit);

      return value * from.factorToBase / to.factorToBase;
    }
  }

  // Helper function for Temperature conversion
  // Converts any input temperature to Celsius first, then to the target unit
  static double _convertTemperature(String from, String to, double value) {
    double celsius;

    // Convert input to Celsius
    switch (from) {
      case 'Celsius':
        celsius = value;
        break;
      case 'Fahrenheit':
        celsius = (value - 32) * 5 / 9;
        break;
      case 'Kelvin':
        celsius = value - 273.15;
        break;
      default:
        celsius = value;
    }

    // Convert Celsius to the desired target unit
    switch (to) {
      case 'Celsius':
        return celsius;
      case 'Fahrenheit':
        return celsius * 9 / 5 + 32;
      case 'Kelvin':
        return celsius + 273.15;
      default:
        return celsius;
    }
  }
}
