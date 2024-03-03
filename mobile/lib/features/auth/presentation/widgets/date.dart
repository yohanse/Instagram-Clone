import 'package:flutter/material.dart';

class CustomDate extends StatelessWidget {
  final TextEditingController dateController;
  const CustomDate({super.key, required this.dateController});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: dateController,
      readOnly: true,
      style: TextStyle(
        fontSize: 16,
        color: const Color.fromARGB(255, 255, 255, 255),
      ),
      
      decoration: InputDecoration(
        suffixIcon: IconButton(
          color: Color.fromARGB(200, 224, 219, 219),
          icon: const Icon(Icons.date_range),
          onPressed: () {
            showDatePicker(
              context: context,
              initialDate: DateTime(1970),
              firstDate: DateTime(1970),
              lastDate: DateTime(2002),
            ).then((value) =>
                {dateController.text = value.toString().substring(0, 10)});
          },
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
        hintText: 'Date',
        hintStyle: TextStyle(
          fontSize: 16,
          color: const Color.fromARGB(200, 224, 219, 219),
        ),

        filled: true,
        fillColor: Color(0xFF1C2B33), // Set transparent background color
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0), // Set border radius
          borderSide: BorderSide(
            color: const Color.fromARGB(200, 224, 219, 219), // Set border color
            width: 0.5, // Set border width
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: const Color.fromARGB(200, 224, 219, 219),
            width: 0.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: const Color.fromARGB(200, 224, 219, 219),
            width: 0.5,
          ),
        ),
      ),
    );
  }
}