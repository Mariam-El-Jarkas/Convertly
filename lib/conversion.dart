import 'package:flutter/material.dart';
import 'units.dart';

class ConversionPage extends StatefulWidget {
  final String category;
  final Color primaryColor;
  final Color secondaryColor;

  ConversionPage({
    required this.category,
    required this.primaryColor,
    required this.secondaryColor,
  });

  @override
  _ConversionPageState createState() => _ConversionPageState();
}

class _ConversionPageState extends State<ConversionPage> {
  final TextEditingController _controller = TextEditingController();
  String fromUnit = '';
  String toUnit = '';
  double? result;

  @override
  void initState() {
    super.initState();
    final unitList = Units.categories[widget.category]!;
    fromUnit = unitList[0].name;
    toUnit = unitList.length > 1 ? unitList[1].name : unitList[0].name;
  }

  void convert() {
    double input = double.tryParse(_controller.text) ?? 0;
    double value = Units.convert(widget.category, fromUnit, toUnit, input);
    setState(() {
      result = value;
    });
  }

  void reset() {
    final unitList = Units.categories[widget.category]!;
    setState(() {
      _controller.clear();
      result = null;
      fromUnit = unitList[0].name;
      toUnit = unitList.length > 1 ? unitList[1].name : unitList[0].name;
    });
  }

  @override
  Widget build(BuildContext context) {
    final unitList = Units.categories[widget.category]!;

    return Scaffold(
      backgroundColor: widget.secondaryColor.withOpacity(0.1),
      appBar: AppBar(
        title: Text('${widget.category} Conversion'),
        centerTitle: true,
        backgroundColor: widget.primaryColor,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: reset,
            tooltip: 'Reset',
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Input Field
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter value',
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
            SizedBox(height: 20),

            // Dropdowns
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: fromUnit,
                    items: unitList
                        .map(
                          (unit) => DropdownMenuItem(
                            value: unit.name,
                            child: Text(unit.name),
                          ),
                        )
                        .toList(),
                    onChanged: (val) => setState(() => fromUnit = val!),
                    decoration: InputDecoration(
                      labelText: 'From',
                      labelStyle: TextStyle(color: widget.primaryColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: toUnit,
                    items: unitList
                        .map(
                          (unit) => DropdownMenuItem(
                            value: unit.name,
                            child: Text(unit.name),
                          ),
                        )
                        .toList(),
                    onChanged: (val) => setState(() => toUnit = val!),
                    decoration: InputDecoration(
                      labelText: 'To',
                      labelStyle: TextStyle(color: widget.primaryColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Convert Button
            ElevatedButton(
              onPressed: convert,
              child: Text('Convert'),
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 30),

            // Result Box
            if (result != null)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: widget.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$result $toUnit',
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


