import 'package:flutter/material.dart';

class ChestField extends StatelessWidget {
  final String fixedString;
  final int initialNumber;
  final IconData icon;
  final ValueChanged<int>? onChanged;
  final TextEditingController? numberController;

  const ChestField({
    super.key,
    required this.fixedString,
    required this.initialNumber,
    required this.icon,
    this.onChanged,
    this.numberController,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController effectiveController =
        numberController ?? TextEditingController(text: initialNumber.toString());

    return TextField(
      controller: effectiveController,
      keyboardType: TextInputType.number,
      style: const TextStyle(color: Colors.white),
      onChanged: (value) {
        if (onChanged != null) {
          onChanged!(int.tryParse(value) ?? 0);
        }
      },
      decoration: InputDecoration(
        prefix: Container(
          padding: const EdgeInsets.only(right: 8.0), // Add some space between text and input
          child: Text(
            fixedString,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        prefixIcon: Icon(icon, color: Colors.white), // Icon on the left
        labelText: 'Chest Number',
        labelStyle: const TextStyle(color: Colors.white), // White label text
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white), // White border
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white, width: 2.0), // Thicker white border when focused
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white), // Default border
        ),
      ),
    );
  }
}
