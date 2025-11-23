class Unit {
  String name;
  double
  factorToBase; // For relative conversion; for temperature we handle separately

  Unit({required this.name, required this.factorToBase});
}

class Units {
  static Map<String, List<Unit>> categories = {
    'Time': [
      Unit(name: 'Seconds', factorToBase: 1),
      Unit(name: 'Minutes', factorToBase: 60),
      Unit(name: 'Hours', factorToBase: 3600),
      Unit(name: 'Milliseconds', factorToBase: 0.001),
      Unit(name: 'Nanoseconds', factorToBase: 1e-9),
    ],
    'Length': [
      Unit(name: 'Meters', factorToBase: 1),
      Unit(name: 'Kilometers', factorToBase: 1000),
      Unit(name: 'Miles', factorToBase: 1609.34),
      Unit(name: 'Centimeters', factorToBase: 0.01),
      Unit(name: 'Feet', factorToBase: 0.3048),
    ],
    'Weight': [
      Unit(name: 'Grams', factorToBase: 1),
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

  // Conversion function
  static double convert(
    String category,
    String fromUnit,
    String toUnit,
    double value,
  ) {
    if (category == 'Temperature') {
      return _convertTemperature(fromUnit, toUnit, value);
    } else {
      final from = categories[category]!.firstWhere((u) => u.name == fromUnit);
      final to = categories[category]!.firstWhere((u) => u.name == toUnit);
      return value * from.factorToBase / to.factorToBase;
    }
  }

  // Temperature conversion helper
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

    // Convert from Celsius to target
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
